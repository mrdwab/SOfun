#' Append \code{data.frame}s with a new column indicating the original
#' \code{data.frame} name
#' 
#' Append \code{data.frame}s by row with a new column indicating the name of
#' the original \code{data.frame}s. Matrices are converted to
#' \code{data.frame}s in the process.
#' 
#' 
#' @param dfNames A character vector of the names of the \code{data.frame}s
#' that need to be appended.
#' @return A \code{data.frame}.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/15162401/1270695}
#' @examples
#' 
#' df.1 <- data.frame("x"=c(1,2), "y"=2)
#' df.2 <- data.frame("x"=c(2,4), "y"=4)
#' df.3 <- data.frame("x"=2, "y"=c(4,5))
#' 
#' appendMe(c("df.1", "df.2", "df.3"))
#' 
#' @export appendMe
appendMe <- function(dfNames) {
  do.call(rbind, lapply(dfNames, function(x) {
    cbind(get(x), source = x)
  }))
}
