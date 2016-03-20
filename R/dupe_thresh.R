#' Filters a Vector According to Number of Duplicates
#' 
#' Filters a vector according to the number of duplicates in the vector, where 
#' the conditions for the acceptable number of duplicate values are specified.
#' 
#' @param invec The input vector.
#' @param count The threshold for duplicates. See "Details".
#' @return A vector.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/q/29973061/1270695}
#' @details The \code{"count"} parameter can be either a single digit or a 
#' character vector showing the desired comparison to be used as the threshold
#' (for example "> 5"). If no binary relational operator is specified, the 
#' relational operator used is \code{>=}.
#' @examples
#' 
#' set.seed(1)
#' x <- sample(letters[1:10], 35, TRUE)
#' sort(table(x))
#' 
#' table(dupe_thresh(x, 3))
#' table(dupe_thresh(x, "<3"))
#' table(dupe_thresh(x, "== 3"))
#' table(dupe_thresh(x, "!=3"))
#' 
#' @export dupe_thresh
dupe_thresh <- function(invec, count) {
  x <- trimws(strsplit(as.character(count), "(?<=[<>=!])", perl = TRUE)[[1]])
  y <- if (length(x) == 1) {
    list(">=", x)
  } else if (length(x) == 2) {
    list(x[1], x[2])
  } else if (length(x) == 3) {
    list(paste0(x[1], x[2]), x[3])
  }
  ind <- ave(rep(1L, length(invec)), invec, FUN = length)
  invec[match.fun(y[[1]])(ind, as.numeric(y[[2]]))]
}
NULL