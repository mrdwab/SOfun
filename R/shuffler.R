#' Shuffle the elements of a vector
#' 
#' Shuffles the elements of a vector such that no single element is in the same
#' place it was before.
#' 
#' 
#' @param inVec The input vector
#' @return A shuffled version of the input vector
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/19898689/1270695}
#' @examples
#' 
#' shuffler(letters[1:10])
#' 
#' @export shuffler
shuffler <- function(inVec) {
  Res <- vector()
  while ( TRUE ) {
    Res <- sample(inVec)
    if ( !any(Res == inVec) ) { break }
  }
  Res
}
