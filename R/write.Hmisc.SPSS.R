#' Write an Hmisc data.frame with labels to SPSS
#' 
#' The Hmisc package lets you assign labels to data. This information is not
#' included when using write.spss from the "foreign" package. This function
#' tries to address that.
#' 
#' 
#' @param data The input data.frame
#' @param datafile The name for the resulting SPSS data file
#' @param codefile The name for the resulting SPSS code file
#' @return Two files will be created in your working directory: a script file
#' and a data file that can be used with SPSS
#' @author Ananda Mahto. Includes code from Chuck Cleland
#' @references \url{http://stackoverflow.com/a/10261534/1270695}
#' @examples
#' 
#' df <- data.frame(id = c(1:6),
#'                  p.code = c(1, 5, 4, NA, 0, 5),
#'                  p.label = c('Optometrists', 'Nurses',
#'                              'Financial analysts', '<NA>',
#'                              '0', 'Nurses'),
#'                  foo = LETTERS[1:6])
#' # Add some variable labels using label from the Hmisc package
#' library(Hmisc)
#' label(df) <- "Sweet sweet data"
#' label(df$id) <- "id blahblah"
#' label(df$p.label) <- "Profession with human readable information"
#' label(df$p.code) <- "Profession code"
#' label(df$foo) <- "Variable label for variable x.var"
#' # modify the name of one varibe to see what happens when exported
#' names(df)[4] <- "New crazy name for 'foo'"
#' 
#' df
#' 
#' x <- getwd()
#' setwd(tempdir())
#' list.files()
#' write.Hmisc.SPSS(df, "df.sav", "df.sps")
#' cat(readLines("df.sav"), sep = "\n")
#' cat(readLines("df.sps"), sep = "\n")
#' file.remove("df.sav", "df.sps")
#' setwd(x)
#' 
#' @export write.Hmisc.SPSS
write.Hmisc.SPSS = function(data, datafile, codefile) {
  a = do.call(llist, data)
  tempout = vector("list", length(a))
  
  for (i in 1:length(a)) {
    tempout[[i]] = label(a[[i]])
  }
  b = unlist(tempout)
  label.temp = structure(c(b), .Names = names(data))
  attributes(data)$variable.labels = label.temp
  write.SPSS <- function (df, datafile, codefile, varnames = NULL) { 
    # Author: Chuck Cleland
    # https://stat.ethz.ch/pipermail/r-help/2006-January/085941.html
    adQuote <- function(x){paste("\"", x, "\"", sep = "")}
    dfn <- lapply(df, function(x) if (is.factor(x)) as.numeric(x) else x)
    write.table(dfn, file = datafile, row = FALSE, col = FALSE)
    if(is.null(attributes(df)$variable.labels)) varlabels <- names(df) 
    else varlabels <- attributes(df)$variable.labels
    if (is.null(varnames)) {
      varnames <- abbreviate(names(df), 8)
      if (any(sapply(varnames, nchar) > 8))
        stop("I cannot abbreviate the variable names to eight or fewer letters")
      if (any(varnames != names(df)))
        warning("some variable names were abbreviated")
    }
    cat("DATA LIST FILE=", dQuote(datafile), " free\n", file = codefile)
    cat("/", varnames, " .\n\n", file = codefile, append = TRUE)
    cat("VARIABLE LABELS\n", file = codefile, append = TRUE)
    cat(paste(varnames, adQuote(varlabels), "\n"), ".\n", 
        file = codefile, append = TRUE)
    factors <- sapply(df, is.factor)
    if (any(factors)) {
      cat("\nVALUE LABELS\n", file = codefile, append = TRUE)
      for (v in which(factors)) {
        cat("/\n", file = codefile, append = TRUE)
        cat(varnames[v], " \n", file = codefile, append = TRUE)
        levs <- levels(df[[v]])
        cat(paste(1:length(levs), adQuote(levs), "\n", sep = " "),
            file = codefile, append = TRUE)
      }
      cat(".\n", file = codefile, append = TRUE)
    }
    cat("\nEXECUTE.\n", file = codefile, append = TRUE) }
  write.SPSS(data, datafile, codefile)
}
