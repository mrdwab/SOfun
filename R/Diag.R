#' Extract the Values at the Diagonal of a Matrix
#' 
#' A faster version of \code{\link{diag}} (on larger matrices).
#' 
#' 
#' @param inMatrix The input matrix
#' @return A vector
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/20489737/1270695}
#' @examples
#' 
#' set.seed(1)
#' m <- matrix(rnorm(100), ncol = 10)
#' 
#' Diag(m)
#' diag(m)
#' 
#' @export Diag
Diag <- function(inMatrix) { 
  A <- sequence(ncol(inMatrix))[sequence(min(nrow(inMatrix), 
                                             ncol(inMatrix)))]
  inMatrix[cbind(A, A)]
}

