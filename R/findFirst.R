#' Find the First, Second, n Non-sequential Position of a Value in a Vector
#' 
#' This function returns the location of the first, second, third (and so on)
#' occurrence of a specified non-sequential value in a vector.
#' 
#' @param invec The input vector.
#' @param value The value you are looking for.
#' @param event The desired position to be returned.
#' @return A vector of length 1.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/q/22049035/1270695}
#' @examples
#' 
#' set.seed(1)
#' a <- sample(LETTERS[1:5], 20, TRUE)
#' a
#' 
#' ## Note the difference between the following.
#' ## The value "2" is skipped because it is sequential.
#' which(a == "B")
#' 
#' findFirst(a, "B", 2)
#' 
#' @export findFirst
findFirst <- function(invec, value, event) {
  x <- which(invec == value)
  if (event == 1) out <- x[1]
  else out <- x[which(diff(x) != 1)[event-1] + 1]
  out
}

