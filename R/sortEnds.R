#' Select the Top-n Highest or Lowest Values in a Vector
#' 
#' Takes "n" values from the head or tail of a sorted vector. Utilizes the 
#' "partial" argument from `sort` for increased efficiency. 
#' 
#' @param invec The input vector
#' @param n The number of values desired
#' @param where Either \code{"head"} or \code{"tail"}.
#' @return A sorted vector of length = n
#' @author Ananda Mahto
#' @note The \code{"tail"}  approach may not be consideraby faster than 
#' the standard approach.
#' 
#' @examples
#' 
#' set.seed(1)
#' x <- sample(300, 45, TRUE)
#' sortEnds(x, 3)
#' sortEnds(x, 3, "tail")
#' 
#' ## Compare with
#' head(sort(x), 3)
#' tail(sort(x), 3)
#' 
#' @export sortEnds
sortEnds <- function(invec, n, where = "head") {
  invec <- switch(where, head = invec, tail = -invec,
                  stop("where must be 'head' or 'tail'"))
  out <- sort(invec, partial = seq_len(n))[seq_len(n)]
  switch(where, head = out, tail = sort(-out))
}
NULL
