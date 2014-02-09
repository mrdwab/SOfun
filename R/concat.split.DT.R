#' Split concatenated cells in a \code{data.frame} or a \code{data.table}
#' 
#' A variation of the \code{concat.split} family of functions designed for
#' large rectangular datasets.
#' 
#' While the general \code{concat.split} functions are able to handle
#' "unbalanced" datasets (for example, where the number of fields in a given
#' column might differ from row to row) because of the nature of \code{fread}
#' from the "data.table" package, this function does not support such data
#' types.
#' 
#' @param dataset The input \code{data.frame} or \code{data.table}.
#' @param splitcols The columns that need to be split up.
#' @param sep The character that serves as a delimiter within the columns that
#' need to be split up.
#' @param drop Logical. Should the original columns be dropped? Defaults to
#' \code{TRUE}.
#' @param dotsub The character that should be substituted as a delimiter
#' \emph{if \code{sep = "."}}. \code{fread} does not seem to work nicely with
#' \code{sep = "."}, so it needs to be substituted. By default, this function
#' will substitute \code{"."} with \code{"|"}.
#' @return A \code{data.table}.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/19231054/1270695}
#' @examples
#' 
#' small_file <- system.file("concatDT.csv", package = "SOfun")
#' small_data <- read.csv(small_file)
#' dim(small_data)
#' head(small_data)
#' out <- concat.split.DT(small_data,
#'                        splitcols = c("VARIABLE", "VAR2", "VAR3", "VAR4"),
#'                        sep = "_", drop = TRUE)
#' out
#' 
#' \dontrun{
#' ## Make a much bigger dataset
#' big_data <- small_data[rep(rownames(small_data),
#'                            1500000/nrow(small_data)), ]
#' dim(big_data)
#' system.time(big_out <- concat.split.DT(big_data,
#'                                        splitcols = c("VARIABLE", "VAR2",
#'                                                      "VAR3", "VAR4"),
#'                                        sep = "_", drop = TRUE))
#' big_out
#' }
#' 
#' @export concat.split.DT
concat.split.DT <- function(dataset, splitcols, sep, drop = TRUE, dotsub = "|") {
  require(data.table)
  if (is.numeric(splitcols)) splitcols <- names(dataset)[splitcols]
  if (!is.data.table(dataset)) dataset <- data.table(dataset)
  if (sep == ".") {
    dataset[, (splitcols) := gsub(".", dotsub, get(splitcols), fixed = TRUE)]
    sep <- dotsub
  }

  Splits <- do.call(cbind, lapply(splitcols, function(Z) {
    x <- tempfile()
    if (!is.character(dataset[[Z]])) writeLines(as.character(dataset[[Z]]), x)
    else writeLines(dataset[[Z]], x)
    Split <- fread(x, sep = sep, header = FALSE)
    setnames(Split, paste(Z, seq_along(Split), sep = "_"))
    Split
  }))
  
  final <- cbind(dataset, Splits)
  if (isTRUE(drop)) final <- final[, setdiff(names(final), splitcols), with = FALSE]
  final
}
