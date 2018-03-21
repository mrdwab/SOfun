#' @name unlist_by_row
#' @rdname unlist_by_row
#' @title Unlists the Values in a Rectangular Dataset by Row or Column
#' 
#' @description Unlists the values in a rectangular dataset (like a \code{matrix},
#' \code{data.frame}, or \code{data.table}) by row.
#' 
#' @param indt The input dataset.
#' @param source Logical. Should columns indicating the original row and column
#' positions be returned. Defaults to \code{TRUE}.
#' @return A \code{data.table} if \code{source = TRUE} or a vector.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/q/36073947/1270695}
NULL

#' @rdname unlist_by_row
#' @examples
#' 
#' unlist_by_row(mtcars)
#' 
#' @export
#' @aliases unlist_by_row
unlist_by_row <- function(indt, source = TRUE) {
  if (!is.data.table(indt)) indt <- as.data.table(indt)
  temp <- c(t(indt))
  if (isTRUE(source)) {
    setnames(do.call(CJ, lapply(dim(indt), seq_len)), 
             c("row", "col"))[, value := temp][]
  } else {
    temp
  }
}
NULL

#' @rdname unlist_by_row
#' @examples
#' 
#' unlist_by_col(mtcars)
#' 
#' @export
#' @aliases unlist_by_col
unlist_by_col <- function(indt, source = TRUE) {
  if (!is.data.table(indt)) indt <- as.data.table(indt)
  if (isTRUE(source)) {
    setorder(unlist_by_row(indt, TRUE), col, row)[]
  } else {
    unlist(indt, use.names = FALSE)
  }
}
NULL
