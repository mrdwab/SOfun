#' Sample from a specific range with a target vector sum
#' 
#' Takes a sample from a given range (for example, 1 to 100), and a specified
#' resulting vector length (for example, 10), which add up to a specified
#' value.
#' 
#' 
#' @param Target The value that the vector should \code{sum} to
#' @param VecLen The required vector length
#' @param InRange The input range that values can be sampled from
#' @param Tolerance A "buffer" for the \code{Target} argument, allowing the
#' resulting sum to be slightly higher or slightly lower than specified.
#' @param showSum Logical. Should the resulting total be shown?
#' @return A vector
#' @note There is a good chance that with certain settings, this will be VERY
#' SLOW!
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/14687223/1270695}
#' @examples
#' 
#' set.seed(1)
#' SampleToSum()
#' 
#' SampleToSum()
#' 
#' SampleToSum(Tolerance = 0)
#' 
#' SampleToSum(Tolerance = 0)
#' 
#' set.seed(123)
#' ## You'll have to wait a few seconds here
#' SampleToSum(Target = 1163, VecLen = 15, InRange = 50:150)
#' 
#' @export SampleToSum
SampleToSum <- function(Target = 100, VecLen = 10, 
                        InRange = 1:100, Tolerance = 2, 
                        showSum = TRUE) {
  Res <- vector()
  while ( TRUE ) {
    Res <- round(diff(c(0, sort(runif(VecLen - 1)), 1)) * Target)
    if ( all(Res > 0)  & 
           all(Res >= min(InRange)) &
           all(Res <= max(InRange)) &
           abs((sum(Res) - Target)) <= Tolerance ) { break }
  }
  if (isTRUE(showSum)) cat("Total = ", sum(Res), "\n")
  Res
}
