#' Factor vectors with multiple levels
#'
#' \code{\link{factor}} does not let you use duplicated levels nicely. It results
#' in an ugly warning message and you need to use \code{\link{droplevels}} to get
#' the desired output.
#'
#' The "solution" is to first factor the vector, and then use a named \code{list}
#' with the \code{\link{levels}} function. This function is a wrapper around
#' those steps.
#'
#' @param invec A \code{vector} that needs to be factored.
#' @param levels A named \code{list} of the levels. The \code{name} is the
#' level and the values are what should be mapped to those levels.
#' @param store Logical. Should the input values be stored as an attribute?
#' @param \dots Additional arguments to \code{factor}.
#' @return A factored variable with \code{class} of \code{factor} and 
#' \code{Factor}, optionally with an \code{attribute} of \code{"Input"}
#' which stores the original input values.
#' @author Ananda Mahto
#' @seealso \code{\link{factor}}, \code{\link{levels}}
#' @references \url{http://stackoverflow.com/a/19410249/1270695}
#' @examples
#'
#' x <- c("Y", "Y", "Yes", "N", "No", "H")
#' Factor(x, list(Yes = c("Yes", "Y"), No = c("No", "N")))
#' Factor(x, list(Yes = c("Yes", "Y"), No = c("No", "N")), FALSE)
#' Factor(x, list(No = c("No", "N"), Yes = c("Yes", "Y")), ordered = TRUE)
#'
#' @export Factor
Factor <- function(invec, levels = list(), store = TRUE, ...) {
  Fac <- factor(invec, ...)
  levels(Fac) <- levels
  if (isTRUE(store)) attr(Fac, "Input") <- invec
  class(Fac) <- c("Factor", class(Fac))
  Fac
}

print.Factor <- function(x, ...) {
  if (!is.null(attr(x, "Input"))) {
    cat("Input values:\n")
    print(attr(x, "Input"))
    attr(x, "Input") <- NULL
    cat("\n")
    cat("Factored output:\n")
    print.factor(x)
  } else {
    cat("Factored output:\n")
    print.factor(x)
  }
}

Restore <- function(invec) {
  if (!"Factor" %in% class(invec)) stop("Wrong class of input.")
  if (is.null(attr(invec, "Input"))) stop("No attribute named 'Input' found.")
  attr(invec, "Input")
}
