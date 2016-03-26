#' @name ftable2dt
#' @rdname ftable2dt
#' @title Convert an \code{ftable} or an \code{array} Object to a \code{data.table}
#' 
#' @description While convenient methods exist for converting \code{table}s and 
#' other objects to \code{data.tables}s, such methods do not exist for converting 
#' an \code{ftable} to a \code{data.table}. An \code{ftable} is essentially a
#' \code{matrix} with \code{attributes} for the rows and columns, which can be
#' nested.
#' 
#' @param mydata The input \code{ftable} or \code{array}
#' @param direction Should the reslut be "wide" (with multiple measurement 
#' columns) or "long" (with a single measurement column)? Defaults to \code{"wide"}.
#' @return A \code{data.table}
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/11143126/1270695}
#' @examples
#' 
#' x <- ftable(Titanic, row.vars = 1:3)
#' x
#' ftable2dt(x)
#' ftable2dt(x, direction = "long")
#' 
#' @export ftable2dt
ftable2dt <- function(inarray, direction = "wide") {
  if (!is.array(inarray)) stop("input must be an array")
  dims <- dim(inarray)
  if (is.null(dimnames(inarray))) {
    inarray <- provideDimnames(inarray, base = list(as.character(seq_len(max(dims)))))
  }
  FT <- if (any(class(inarray) %in% "ftable")) inarray else ftable(inarray) 
  switch(direction,
         long = ftablelong(FT, dims),
         wide = ftablewide(FT),
         stop("direction must be 'wide' or 'long'"))
}
NULL

ftablelong <- function(FT, dims) {
  data.table(as.table(ftable(FT), row.vars = seq_along(dims)))
}
NULL

ftablewide <- function(FT) {
  ft_attr <- attributes(FT)
  rows <- rev(expand.grid(rev(ft_attr$row.vars)))
  if (is.null(names(ft_attr$row.vars))) setnames(rows, paste0("V", seq_len(ncol(rows))))
  cols <- data.table(setattr(FT, "class", "matrix"))
  setnames(cols, do.call(paste, c(rev(expand.grid(rev(ft_attr$col.vars))), sep = "_")))
  data.table(rows, cols)
}
NULL