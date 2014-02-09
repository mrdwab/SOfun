#' Get the row and column indices of upper and lower trianges of a matrix
#' 
#' Given the number of rows in a symmetric matrix, calculate the row and column
#' indices of the upper or lower triangles.
#' 
#' 
#' @param Nrow The number of rows
#' @param which Specify \code{which = "lower"} or \code{which = "upper"}.
#' Defaults to \code{"lower"}.
#' @return A two-column matrix.
#' @note A straightforward way to do this is to use
#' \code{which(lower.tri(YourMatrix), arr.ind = TRUE)}, however, this can be
#' quite slow as the number of rows increases.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/20899060/1270695}
#' @examples
#' 
#' TriIndex(4)
#' TriIndex(4, "upper")
#' 
#' m <- matrix(0, nrow = 4, ncol = 4)
#' which(lower.tri(m), arr.ind = TRUE)
#' 
#' @export TriIndex
TriIndex <- function(Nrow, which = "lower") {
  z <- sequence(Nrow)
  lower <- cbind(
    row = unlist(lapply(2:Nrow, function(x) x:Nrow), use.names = FALSE),
    col = rep(z[-length(z)], times = rev(tail(z, -1))-1))
  out <- switch(
    which,
    lower = lower,
    upper = abs(lower - (Nrow + 1))[nrow(lower):1, ],
    stop("which should be 'upper' or 'lower'"))
  out
}
