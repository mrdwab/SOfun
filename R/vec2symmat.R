#' Creates a Symmetric Matrix from a Vector
#' 
#' Takes a vector and, if the vector is of the correct lenght to be made into a
#' symmetric matrix, performs the conversion.
#' 
#' 
#' @param invec The input vector
#' @param diag The value for the diagonal
#' @param byrow Logical. Whether the upper-triangle should be filled in by row
#' @return A matrix
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/18598933/1270695}
#' @examples
#' 
#' myvec <- c(-.55, -.48, .66, .47, -.38, -.46)
#' vec2symmat(myvec)
#' 
#' vec2symmat(1:15, diag = 0)
#' vec2symmat(1:15, diag = 0, byrow = FALSE)
#' 
#' @export vec2symmat
vec2symmat <- function(invec, diag = 1, byrow = TRUE) {
  Nrow <- ceiling(sqrt(2*length(invec)))
  
  if (!sqrt(length(invec)*2 + Nrow) %% 1 == 0) {
    stop("invec is wrong length to create a square symmetrical matrix")
  }
  
  mempty <- matrix(0, nrow = Nrow, ncol = Nrow)
  mindex <- matrix(sequence(Nrow^2), nrow = Nrow, ncol = Nrow, byrow = byrow)
  if (isTRUE(byrow)) {
    mempty[mindex[lower.tri(mindex)]] <- invec
    mempty[lower.tri(mempty)] <- t(mempty)[lower.tri(t(mempty))]
  } else {
    mempty[mindex[upper.tri(mindex)]] <- invec
    mempty[lower.tri(mempty)] <- t(mempty)[lower.tri(t(mempty))]
  }
  
  diag(mempty) <- diag
  mempty
}
