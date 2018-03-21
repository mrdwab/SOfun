#' Apply This By Every n Values
#' 
#' Applies a function by every n values to a vector minus the first value.
#' 
#' @param invec The input vector.
#' @param n By how many values?
#' @param FUN The function to apply to each set of n values.
#' @param pad_val The value to padd the resulting vector with. Defaults to \code{NA}.
#' @return A vector the same length as the input vector.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/q/34563693/1270695}
#' @examples
#' 
#' x <- c(1, 2, 3, 4, 7, 9, 2, 4)
#' this_by_n(x, 3, mean)
#' this_by_n(x, 2, max)
#' this_by_n(x, 4, min)
#' 
#' @export this_by_n
this_by_n <- function(invec, n = 3, FUN = sum, pad_val = NA) {
  FUN <- match.fun(FUN)
  apply(embed(c(invec[-1], rep(pad_val, n)), n), 1, {
    function(x) if (all(is.na(x))) NA else FUN(x[!is.na(x)])
  })
}
NULL
