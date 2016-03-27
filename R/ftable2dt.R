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
#' @param mydata The input \code{ftable} or \code{array}.
#' @param direction Should the reslut be "wide" (with multiple measurement.
#' columns) or "long" (with a single measurement column)? Defaults to \code{"wide"}.
#' @return A \code{data.table}
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/11143126/1270695}
#' @note If the array has no \code{dimnames}, names would be added using the
#' \code{provideDimnames} function. Defaults to \code{reshape2::melt} if the
#' input is a simple matrix and not a multidimensional array.
#' @examples
#' 
#' x <- ftable(Titanic, row.vars = 1:3)
#' x
#' ftable2dt(x)
#' ftable2dt(x, direction = "long")
#' 
#' \dontrun{
#' dims <- c(2, 1, 2, 3, 2)
#' set.seed(1)
#' M <- `dim<-`(sample(100, prod(dims), TRUE), dims)
#' N <- O <- `dimnames<-`(M, lapply(dims, function(x) c(letters, LETTERS)[seq_len(x)]))
#' names(attributes(O)$dimnames) <- c("first", "second", "third", "fourth", "fifth")
#' 
#' ftable2dt(M)
#' ftable2dt(N)
#' ftable2dt(O)
#' ftable2dt(M, "long")
#' ftable2dt(N, "long")
#' ftable2dt(O, "long")
#' }
#' 
#' @export ftable2dt
ftable2dt <- function(inarray, direction = "wide") {
  InArray <- copy(inarray)
  if (!is.array(InArray)) stop("input must be an array")
  dims <- dim(InArray)
  if (length(dims) == 1) {
    stop("nothing to do here....")
  } else if (length(dims) == 2 & (!any(class(InArray) %in% "ftable"))) {
    switch(direction, 
           wide = as.data.table(InArray),
           long = setDT(melt(InArray))[],
           stop("direction must be 'wide' or 'long'"))
  } else {
    FIX <- !any(names(attributes(InArray)) %in% c("dimnames", "row.vars"))
    if (is.null(dimnames(InArray))) {
      InArray <- provideDimnames(InArray, base = list(as.character(seq_len(max(dims)))))
    }
    FT <- if (any(class(InArray) %in% "ftable")) InArray else ftable(InArray)
    temp <- ftablewide(FT, FIX = FIX)
    switch(direction,
           long = ftablelong(temp, FIX = FIX)[],
           wide = setorderv(temp[["Data"]], temp[["Names"]])[],
           stop("direction must be 'wide' or 'long'"))
  }
}
NULL

ftablewide <- function(FT, FIX = TRUE) {
  ft_attr <- attributes(FT)
  rows <- setDT(rev(expand.grid(rev(ft_attr$row.vars), stringsAsFactors = FALSE)))
  if (is.null(names(ft_attr$row.vars))) setnames(rows, paste0("V", seq_len(ncol(rows))))
  Nam <- names(rows)
  cols <- data.table(setattr(FT, "class", "matrix"))
  setnames(cols, do.call(paste, c(rev(expand.grid(rev(ft_attr$col.vars), stringsAsFactors = FALSE)), sep = "_")))
  temp <- data.table(rows, cols)
  if (isTRUE(FIX)) temp[, (Nam) := lapply(.SD, as.integer), .SDcols = Nam]
  list(Attributes = ft_attr, Names = Nam, Data = temp)
}
NULL

ftablelong <- function(inlist, FIX = TRUE) {
  temp <- melt(inlist[["Data"]], id.vars = inlist[["Names"]], variable.factor = FALSE)
  if (isTRUE(FIX)) set(temp, i = NULL, j = match("variable", names(temp)), value = as.integer(temp[["variable"]]))
  varName <- names(inlist[["Attributes"]]$col.vars)
  varName <- if (is.null(varName)) paste0("V", length(inlist[[2]])+1) else varName
  setnames(temp, "variable", varName)
}