#' Split vectors in the form of numbers+characters or characters+numbers to respective parts
#' 
#' A convenience function for the `perl = TRUE` patterns for \code{"(?<=[a-zA-Z])(?=[0-9])"} and \code{"(?<=[0-9])(?=[a-zA-Z])"}. That's it. Really.
#' 
#' @param string The string to be split.
#' @param alphaFirst Logical. Characters first (\code{TRUE})? Or numbers (\code{FALSE})?
#' @return A \code{list} with the split values.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/23052016/1270695}
#' @examples
#' 
#' STR1 <- c("ABC123", "BCD234", "CDE345", "DEF456")
#' STR2 <- c("123ABC", "234BCD", "345CDE", "456DEF")
#' 
#' CharNumSplit(STR1, alphaFirst = TRUE)
#' CharNumSplit(STR2, alphaFirst = FALSE)
#' 
#' @export CharNumSplit
CharNumSplit <- function(string, alphaFirst = TRUE) {
  Pattern <- ifelse(isTRUE(alphaFirst), "(?<=[a-zA-Z])(?=[0-9])", "(?<=[0-9])(?=[a-zA-Z])")
  strsplit(string, split = Pattern, perl = T)
}
