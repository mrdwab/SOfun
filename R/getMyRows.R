#' Get Rows Before and After a Specific Value or Rowname
#' 
#' Extracts (possibly overlapping) rows provided both a pattern or index
#' position to match and a range specifying how many rows before and after the
#' matched row.
#' 
#' 
#' @param data The input \code{data.frame}.
#' @param pattern Either the pattern to match in the \code{rownames} or the
#' numeric position of the initial rows.
#' @param range A vector indicating the range of rows you want to extract (in
#' the form of \code{-2:3}). In this case, it would extract two rows before and
#' three rows after the matched index or pattern. Alternatively, a specific
#' vector (instead of a range) can be supplied, as in \code{c(-1, 1)} in which
#' case only the previous and next row will be returned, \emph{but not the row
#' itself}.
#' @param isNumeric Logical. Is \code{pattern} a numeric vector of row
#' positions (\code{isNumeri = TRUE}) or is it a string value that needs to be
#' matched against the \code{rownames}? Defaults to \code{TRUE}.
#' @return A \code{list} of \code{data.frame}s with the relevant rows
#' extracted.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/13155669/1270695}
#' @examples
#' 
#' set.seed(1)
#' dat1 <- data.frame(ID = 1:25, V1 = sample(100, 25, replace = TRUE))
#' rownames(dat1) <- paste("rowname", sample(apply(combn(LETTERS[1:4], 2),
#'                         2, paste, collapse = ""),
#'                         25, replace = TRUE),
#'                         sprintf("%02d", 1:25), sep = ".")
#' getMyRows(dat1, c(2, 10), -3:2)
#' getMyRows(dat1, c("AB", "AC"), -1:1, FALSE)
#' getMyRows(dat1, c("AB", "AC"), c(-1, 1), FALSE)
#' 
#' @export getMyRows
getMyRows <- function(data, pattern, range, isNumeric = TRUE) {
  if (isTRUE(isNumeric)) {
    if (!is.numeric(pattern)) stop("set isNumeric to FALSE or check your input pattern")
    x <- pattern
  } else {
    x <- grep(paste(pattern, collapse = "|"), rownames(data))
  }
  lapply(x, function(y) {
    Z <- y + range
    data[Z[Z > 0 & Z <= nrow(data)], ]
  })
}

