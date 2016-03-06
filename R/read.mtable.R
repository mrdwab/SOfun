#' Read Data from a File Containing Multiple Datasets
#' 
#' Sometimes, a single file might have multiple datasets, each separated with a
#' "header" of some sort. This function attempts to read the most basic of
#' those types of files.
#' 
#' @param inFile The path to the input file
#' @param chunkId A pattern in the text that identifies the "header" that
#' indicates the start of a new dataset
#' @param \dots Other arguments to be passed to \code{read.table}
#' @return A \code{list} of \code{data.frame}s
#' @note \code{names} are added to the resulting \code{list}, but these are not
#' likely to be syntactically valid R names.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/11530036/1270695},
#' \url{http://stackoverflow.com/a/11555316/1270695}
#' @examples
#' 
#' x <- tempfile()
#' cat("'Experiment Name: Here Be',,", "1,2,3", "4,5,6", "7,8,9",
#'     "'Experiment Name: The Dragons',,", "10,11,12", "13,14,15",
#'     "16,17,18", file = x, sep = "\n")
#' 
#' read.mtable(x, "Experi", sep = ",")
#' 
#' cat("Header: Boston city data",
#'     "Month    Data1    Data2    Data3",
#'     "1        1.5      9.1342   8.1231",
#'     "2        12.3     12.31    1.129",
#'     "", "", "Header: Chicago city data",
#'     "Month    Data1    Data2    Data3",
#'     "1        1.5      9.1342   8.1231",
#'     "2        12.3     12.31    1.129",
#'     file = x, sep = "\n")
#' 
#' read.mtable(x, "Header", header = TRUE)
#' 
#' @export read.mtable
read.mtable <- function(inFile, chunkId, ...) {
  temp <- readLines(inFile)
  temp.loc <- grep(chunkId, temp)
  temp.loc <- c(temp.loc, length(temp)+1)
  temp.nam <- grep(chunkId, temp, value = TRUE)
  temp.out <- vector("list", length = length(temp.nam))
  
  for (i in seq_along(temp.nam)) {
    temp.out[[i]] <- read.table(
      text = temp[seq(from = temp.loc[i]+1, to = temp.loc[i+1]-1)], ...)
    names(temp.out)[i] = temp.nam[i]
  }
  temp.out
}
NULL
