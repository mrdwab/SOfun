#' Convert TRUE Values in a Vector to a Grouped Sequence
#' 
#' Convert the \code{TRUE} values in a vector into a sequence by groups of
#' values.
#' 
#' 
#' @param inLogi The input logical vector.
#' @param zero2NA Logical. Should the zeroes in the result be converted to
#' \code{NA}. Defaults to \code{FALSE}.
#' @return A numeric vector
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/21328046/1270695}
#' @examples
#' 
#' set.seed(1)
#' x <- sample(c(TRUE, FALSE), 100, TRUE)
#' 
#' TrueSeq(x)
#' 
#' @export TrueSeq
TrueSeq <- function(inLogi, zero2NA = FALSE) {
  if (!is.logical(inLogi)) stop("Your input must be a logical vector")
  x <- rle(cumsum(!inLogi)[inLogi])$lengths
  inLogi[inLogi] <- rep(seq_along(x), x)
  if (isTRUE(zero2NA)) inLogi[inLogi == 0] <- NA
  inLogi
}
