#' Apply This By Every n Values
#' 
#' Applies a function by every n values to a vector.
#' 
#' @param invec The input vector.
#' @param n By how many values?
#' @param FUN The function to apply to each set of n values.
#' @param fill The value to padd the resulting vector with. Defaults to \code{NA}.
#' @param include_first Logical. Should the first value be included. Defaults to `TRUE`.
#' @return A vector the same length as the input vector.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/q/34563693/1270695}
#' @examples
#' 
#' x <- c(1, 2, 3, 4, 7, 9, 2, 4)
#' this_by_n(x, 3, mean)
#' this_by_n(x, 2, max)
#' this_by_n(x, 4, min)
#' this_by_n(letters[1:10], 5, toString)
#' 
#' @export this_by_n
this_by_n <- function(invec, n = 3, FUN = sum, fill = NA, include_first = TRUE) {
  FUN <- match.fun(FUN)
  n <- if (include_first) seq_len(n)-1 else seq_len(n)
  temp <- data.table::transpose(data.table::shift(invec, n = n, fill = fill, type = "lead"))
  sapply(temp, function(x) if (all(is.na(x))) NA else FUN(x[!is.na(x)]))
}
NULL
