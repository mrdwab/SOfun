#' Successively Applies a Function at Each Index in a List
#' 
#' Successively applies a function (`intersect`, by default) to elements 
#' at each index level in a `list`.
#' 
#' @param inlist The input `list`.
#' @param FUN The function to be applied. Note that the supplied function should be one
#' that you would expect to have work with two or more `vectors` as the given arguments.
#' Thus, you can expect `range` to work, but not `mean`.
#' @param flatten Logical. Should the output be simplified from a `list`. Defaults to
#' `FALSE`. This is useful when you expect the result at each `list` index to be a 
#' single value (for example, when using a function like `sum` or `max`).
#' @param sorted Logical. Should the values at each `list` index be sorted? Defaults
#' to `FALSE`.
#' @param MoreArgs A `list` of additional arguments to be passed to `FUN`. See
#' [base::mapply()] for more details.
#' @return A `list` (default) or a simple `vector` (if `flatten = TRUE`).
#' @author Ananda Mahto
#' @seealso [base::Reduce()], [base::mapply()]
#' @references See: <https://stackoverflow.com/q/62454705/1270695>
#' @examples
#' 
#' L <- list(colA = list(c("a", "b", "c", "ñ"), c("f", "g", "h"), c("i", "j", "k")), 
#'           colB = list(c("d", "b", "e"), c("f", "g", "m", "p"), c("f", "o", "j")),
#'           colC = list(c("a", "b", "g"), c("l", "g", "f", "k", "h"), c("j", "o", "l")))
#' list_reduction(L)
#' list_reduction(L, flatten = TRUE)
#' 
#' set.seed(1)
#' L2 <- replicate(3, replicate(3, sample(sample(20), sample(10), TRUE), FALSE), FALSE)
#' list_reduction(L2)
#' list_reduction(L2, sum, flatten = TRUE)
#' list_reduction(L2, range)
#' list_reduction(L2, union)
#' list_reduction(L2, union, sorted = TRUE)
#' 
#' @export list_reduction
list_reduction <- function(inlist, FUN = intersect, flatten = FALSE, sorted = FALSE, MoreArgs = NULL) {
  temp <- Reduce(function(x, y) mapply(FUN, x, y, MoreArgs = MoreArgs, SIMPLIFY = FALSE), inlist)
  if (sorted) temp <- lapply(temp, sort)
  if (flatten) {
    if (all(lengths(temp) == 1L)) {
      return(unlist(temp, use.names = FALSE))
    } else {
      return(vapply(temp, toString, character(1L)))
    }
  } else {
    return(temp)
  }
}
NULL
