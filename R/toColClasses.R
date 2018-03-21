#' Change the Column Classes of Variables in a \code{data.frame}
#' 
#' Change the column classes of variables in a \code{data.frame} that has
#' already been read into your workspace.
#' 
#' @param inDF The source \code{data.frame}.
#' @param colClasses A character vector of the desired column classes. This
#' should be the same length as the number of columns in the \code{data.frame}.
#' If no change is desired, use \code{""}.
#' @return A \code{data.frame}.
#' @note This function has only been tested with a very small set of the
#' \code{as.*} functions.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/18893672/1270695}
#' @examples
#' 
#' mydf <- data.frame(
#'   a = c(" 1"," 2", " 3"),
#'   b = c("a","b","c"),
#'   c = c(" 1.0", "NA", " 2.0"),
#'   d = c(" 1", "B", "2"),
#'   e = c(1, 0, 1))
#' 
#' mydf
#' str(mydf)
#' 
#' x <- toColClasses(mydf, c("as.integer", "", "as.numeric",
#'                           "as.factor", "as.logical"))
#' x
#' str(x)
#' 
#' y <- toColClasses(mydf, c("as.integer", "", "as.numeric",
#'                           "as.character", "as.logical"))
#' y
#' str(y)
#' 
#' @export toColClasses
toColClasses <- function(inDF, colClasses) {
  if (length(colClasses) != length(inDF)) stop("Please specify colClasses for each column")
  inDF[] <- lapply(seq_along(colClasses), function(y) {
    if (colClasses[y] == "") {
      inDF[y] <- inDF[[y]]
    } else if (colClasses[y] == "as.logical") {
      FUN <- match.fun(colClasses[y])
      inDF[y] <- suppressWarnings(FUN(as.numeric(as.character(inDF[[y]]))))
    }
    else {
      FUN <- match.fun(colClasses[y])
      inDF[y] <- suppressWarnings(FUN(as.character(inDF[[y]])))
    }
  })
  inDF
}
NULL
