#' @name col_flatten
#' @rdname col_flatten
#' @title Flatten List Columns into a Wide or Long Form
#' 
#' @description Converts list columns into separate columns or into a long form.
#' 
#' @param indt The input \code{data.table}.
#' @param cols Character vector containing the names of list columns
#' @param drop Logical. Should the list columns be dropped from the original 
#' \code{data.table}?
#' @return A \code{data.table}.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/q/34206003/1270695}
NULL

#' @rdname col_flatten
#' @examples
#' 
#' df <- structure(
#'   list(CAT = structure(1:2, .Label = c("A", "B"), class = "factor"),
#'        COUNT = list(1:3, 4:5), TREAT = list(c("Treat-a", "Treat-b"), 
#'        c("Treat-c", "Treat-d", "Treat-e"))), 
#'        .Names = c("CAT", "COUNT", "TREAT"), 
#'        row.names = c(NA, -2L), class = "data.frame")
#'        
#' col_flatten(df, c("COUNT", "TREAT"), TRUE)
#' 
#' @export
#' @aliases col_flatten
col_flatten <- function(indt, cols, drop = FALSE) {
  if (!data.table::is.data.table(indt)) indt <- data.table::as.data.table(indt)
  x <- unlist(indt[, lapply(.SD, function(x) max(lengths(x))), .SDcols = cols])
  nams <- paste(rep(cols, x), sequence(x), sep = "_")
  indt[, (nams) := unlist(lapply(.SD, transpose), recursive = FALSE), .SDcols = (cols)]
  if (isTRUE(drop)) indt[, (cols) := NULL]
  indt[]
}
NULL

#' @rdname col_flatten
#' @examples
#' 
#' col_flattenLong(df, c("COUNT", "TREAT"))
#' 
#' @export
#' @aliases col_flattenLong
col_flattenLong <- function(indt, cols) {
  ob <- setdiff(names(indt), cols)
  x <- col_flatten(indt, cols, TRUE)
  mv <- lapply(cols, function(y) grep(sprintf("^%s_", y), names(x)))
  data.table::setorderv(melt(x, measure.vars = mv, value.name = cols), ob)[]
}
NULL