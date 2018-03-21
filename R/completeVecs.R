#' Extract the `complete.cases` for a Set of Vectors
#' 
#' Takes vectors as input and outputs a matrix of the complete cases across
#' these vectors.
#' 
#' 
#' @param \dots The vectors that need to be combined.
#' @return A matrix with the same number of columns as there are input vectors.
#' @note Short vectors are recycled without warnings. If your vectors are
#' different lengths, you should decide whether this is a desirable behavior or
#' not before using this function.
#' @author Ananda Mahto
#' @references <http://stackoverflow.com/a/20146003/1270695>
#' @examples
#' 
#' A <- c(12, 8, 11, 9, NA, NA, NA)
#' B <- c(NA, 7, NA, 10, NA, 11, 9)
#' 
#' completeVecs(A, B)
#' 
#' C <- c(1, 2, NA)
#' 
#' completeVecs(A, B, C)
#' 
#' @export completeVecs
completeVecs <- function(...) {
  myList <- list(...)
  Names <- sapply(substitute(list(...)), deparse)[-1]
  out <- suppressWarnings(
    do.call(cbind, myList)[!is.na(Reduce("+", myList)), ])
  colnames(out) <- Names
  out
}
