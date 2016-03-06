#' Convert an \code{ftable} Object to a \code{data.frame}
#' 
#' While convenient methods exist for converting \code{table}s and other
#' objects to \code{data.frame}s, such methods do not exist for converting an
#' \code{ftable} to a \code{data.frame}. An \code{ftable} is essentially a
#' \code{matrix} with \code{attributes} for the rows and columns, which can be
#' nested.
#' 
#' 
#' @param mydata The input \code{ftable} object
#' @return A \code{data.frame}
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/11143126/1270695}
#' @examples
#' 
#' x <- ftable(Titanic, row.vars = 1:3)
#' 
#' x
#' 
#' ftable2df(x)
#' 
#' @export ftable2df
ftable2df <- function(mydata) {
  ifelse(class(mydata) == "ftable", 
         mydata <- mydata, mydata <- ftable(mydata))
  dfrows <- rev(expand.grid(rev(attr(mydata, "row.vars"))))
  dfcols <- as.data.frame.matrix(mydata)
  names(dfcols) <- do.call(
    paste, c(rev(expand.grid(rev(attr(mydata, "col.vars")))), sep = "_"))
  cbind(dfrows, dfcols)
}
