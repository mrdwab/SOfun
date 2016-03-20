#' Creates a CSV Representation of Data Accoding to Stacks of Whitespace
#' 
#' Uses AWK to convert a fixed-width file to a CSV based on stacks of whitespace.
#' 
#' @param infile The input file. Can also be \code{"clipboard"} to read directly
#' from the clipboard.
#' @param toDF Logical. Should the file be read in while we are at it? Defaults
#' to \code{FALSE}.
#' @param \dots Other arguments to be passed to \code{read.table}.
#' @return A vector or a \code{data.frame}, depending on the value in \code{toDF}.
#' @author Ananda Mahto and \href{http://stackoverflow.com/users/1745001/ed-morton}{Ed Morton}.
#' @references \url{http://stackoverflow.com/q/30868600/1270695}
#' @note Only tested on Linux.
#' @examples
#' 
#' myfile <- tempfile(fileext = ".txt")
#' Lines <- c("aaa  b b ccc      345", "ddd  fgt f u      3456", "e r  der der      5 674")
#' cat(Lines, sep = "\n")
#' cat(Lines, sep = "\n", file = myfile)
#' fwf2csv(myfile)
#' fwf2csv(myfile, TRUE, header = FALSE)
#'  
#' @export fwf2csv
fwf2csv <- function(infile, toDF = FALSE, ...) {
  if (infile == "clipboard") {
    infile <- tempfile()
    writeLines(overflow:::readClip(), infile)
  }
  
  a <- tempfile()
  text <- 'BEGIN{ FS=OFS=""; ARGV[ARGC]=ARGV[ARGC-1]; ARGC++ }
NR==FNR {
    for (i=1;i<=NF;i++) {
        if ($i == " ") {
            space[i]
        }
        else {
            nonSpace[i]
        }
    }
    next
}
FNR==1 {
    for (i in nonSpace) {
        delete space[i]
    }
}
{
    for (i in space) {
        $i = ","
    }
    gsub(/,+/,",")
    print
}'
  writeLines(text, a)
  command <- sprintf("awk -f %s %s", a, infile)
  if (isTRUE(toDF)) read.csv(text = system(command, intern = TRUE), ...)
  else system(command, intern = TRUE)
}
NULL