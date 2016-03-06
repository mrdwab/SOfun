#' Allows Tabulate to Be Used with Negative Integers Too
#' 
#' Modifies tabulate to work with non-positive integers too.
#' 
#' @param vec The input vector
#' @return A named integer vector. There is a bin for each of the values 1, ..., nbins.
#' @author Ananda Mahto
#' @note The behavior on non-integers might be somewhat unpredictable, but should 
#' be somewhat like using `table(cut(...))` with breaks being from the minimum
#' to the maximum + 1. See the "Examples" section.
#' @examples
#' 
#' x <- c(-5, -5, 3, 1, 0, 2, 5, -4, 0, 0, 1)
#' TabulateInt(x)
#' 
#' ## Compare
#' tabulate(x)
#' table(x)
#' table(factor(x, min(x):max(x)))
#' 
#' ## Non-integers
#' set.seed(1)
#' x <- rnorm(20)
#' TabulateInt(x)
#' table(cut(x, seq(min(x), max(x)+1, 1), include.lowest = TRUE))
#' 
#' @export TabulateInt
TabulateInt <- function(vec) {
  RANGE <- max(vec)
  x <- c(1, RANGE)
  if (any(vec <= 0)) {
    x <- range(vec)
    RANGE <- diff(x) + 1
    vec <- vec + abs(min(x)) + 1
  }
  `names<-`(tabulate(vec, nbins = RANGE), x[1]:x[2])
}
NULL