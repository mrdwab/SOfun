#' Create Adjacent Combinations, Varying Length
#' 
#' Create adjacent combinations of the elements of a vector, varying the length
#' with each iteration.
#' 
#' 
#' @param invec The input vector
#' @return A \code{list} of vectors
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/20157957/1270695}
#' @examples
#' 
#' adjCombos(letters[1:5])
#' 
#' @export adjCombos
adjCombos <- function(invec) {
  A <- lapply(2:(length(invec)-1), sequence)
  B <- lapply(rev(vapply(A, length, 1L))-1, function(x) c(0, sequence(x)))
  unlist(lapply(seq_along(A), function(x) {
    lapply(B[[x]], function(y) invec[A[[x]]+y])
  }), recursive = FALSE, use.names = FALSE)
}
NULL
