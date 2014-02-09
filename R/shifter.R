#' "Shift" the values of a vector ahead or behind by a specified amount
#' 
#' This function "shifts" the values of a vector by a specified amount. For
#' instance, if you are starting with a vector, "x", where the range of values
#' is between 1 and 10, and you want 10 to be replaced by 9, 9 to be replaced
#' by 8, and so on, with 1 being ultimately replaced by 10, this funciton
#' should be of use.
#' 
#' 
#' @param x The range that you are shifting
#' @param n How much of a shift you want
#' @return A vector of shifted values
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/20825012/1270695}
#' @examples
#' 
#' set.seed(1)
#' X <- sample(10, 20, replace = TRUE)
#' X
#' 
#' shifter()[X]
#' shifter(n = -2)[X]
#' 
#' @export shifter
shifter <- function(x = 1:10, n = 1) {
  if (n == 0) x <- x
  else x <- c(tail(x, -n), head(x, n))
  x
}
