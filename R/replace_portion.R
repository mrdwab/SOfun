#' Find and Replace a Portion of a Vector
#' 
#' Searches for a pattern in a vector and replaces it with a provided replacement pattern.
#' 
#' @param invec The input vector.
#' @param find What is the sequence that you're looking for?
#' @param replace What do you want to replace the values with?
#' @return A vector the same length as the input vector.
#' @author Ananda Mahto
#' @examples
#' 
#' x <- c(1, 2, 3, 1, 0, 1, 0, 1, 2, 3, 4, 1, 0, 1)
#' replace_portion(x, c(1, 0, 1), c(9, 9, 9))
#' 
#' @export replace_portion
replace_portion <- function(invec, find, replace) {
  if (length(find) != length(replace)) stop("incompatible find/replace")
  if (all(find %in% invec)) {
    pos <- which(invec == find[1])
    for (i in seq_along(pos)) {
      ind <- pos[i]:(pos[i]+length(find)-1)
      if (identical(invec[ind], find)) invec[ind] <- replace
    }
  } else {
    message("nothing changed")
  }
  invec
}
NULL
