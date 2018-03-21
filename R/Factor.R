#' @name Factor
#' @rdname Factor
#' @title Factor Vectors with Multiple Levels
#' 
#' @description [base::factor()] does not let you use duplicated levels nicely. 
#' It results in an ugly warning message and you need to use [base::droplevels()] 
#' to get the desired output. The "solution" is to first factor the vector, and 
#' then use a named `list` with the [base::levels()] function. This function is 
#' a wrapper around those steps.
#' 
#' @param invec A `vector` that needs to be factored.
#' @param levels A named `list` of the levels. The `name` is the
#' level and the values are what should be mapped to those levels.
#' @param store Logical. Should the input values be stored as an attribute?
#' @param \dots Additional arguments to `factor`.
#' @param x The object to be printed.
#' @return A factored variable with `class` of `factor` and `Factor`, optionally 
#' with an `attribute` of `"Input"` which stores the original input values.
#' @author Ananda Mahto
#' @seealso [base::factor()], [base::levels()]
#' @references <http://stackoverflow.com/a/19410249/1270695>
NULL

#' @rdname Factor
#' @examples
#' 
#' x <- c("Y", "Y", "Yes", "N", "No", "H")
#' Factor(x, list(Yes = c("Yes", "Y"), No = c("No", "N")))
#' Factor(x, list(Yes = c("Yes", "Y"), No = c("No", "N")), FALSE)
#' y <- Factor(x, list(No = c("No", "N"), Yes = c("Yes", "Y")), ordered = TRUE)
#' y
#' 
#' RestoreFactor(y)
#' 
#' @export Factor
#' @aliases Factor
Factor <- function(invec, levels = list(), store = TRUE, ...) {
  Fac <- factor(invec, ...)
  levels(Fac) <- levels
  if (isTRUE(store)) attr(Fac, "Input") <- invec
  class(Fac) <- c("Factor", class(Fac))
  Fac
}

#' @rdname Factor
#' @export
#' @aliases print.Factor
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

#' @rdname Factor
#' @export RestoreFactor
#' @aliases RestoreFactor
RestoreFactor <- function(invec) {
  if (!"Factor" %in% class(invec)) stop("Wrong class of input.")
  if (is.null(attr(invec, "Input"))) stop("No attribute named 'Input' found.")
  attr(invec, "Input")
}
