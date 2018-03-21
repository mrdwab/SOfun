#' Lengthens a Dataset by Combination of Columns
#' 
#' Creates a long dataset of "n" columns comprising the combinations of values
#' from different columns.
#' 
#' @param indt The input dataset.
#' @param n The number of columns expected. Passed on to \code{combn}.
#' @return A \code{data.table}.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/q/35690478/1270695}
#' @examples
#' 
#' mydf <- as.data.frame(matrix(c(1,2,3,4,0,0,1,1), byrow = TRUE, nrow = 2))
#' lengthener(mydf, 2)
#' lengthener(mydf, 3)
#' 
#' @export lengthener
lengthener <- function(indt, n = 2) {
  if (!is.data.table(indt)) indt <- as.data.table(indt)
  temp <- rbindlist(
    combn(names(indt), n, FUN = function(x) {
      indt[, x, with = FALSE]
    }, simplify = FALSE),
    use.names = FALSE, idcol = TRUE)
  setorder(temp[, .id := sequence(.N), by = .id], .id)[, .id := NULL][]
}
NULL
