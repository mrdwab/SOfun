#' Calculate the median of already grouped data
#' 
#' Calculates the median of already grouped data given the interval ranges and
#' the frequencies of each group.
#' 
#' 
#' @param frequencies A vector of frequencies.
#' @param intervals A 2-row \code{matrix} with the same number of columns as
#' the length of frequencies, with the first row being the lower class
#' boundary, and the second row being the upper class boundary. Alternatively,
#' \code{intervals} may be a column in your \code{data.frame}, and you may
#' specify \code{sep} (and possibly, \code{trim}) to have the
#' \code{GroupedMedian} function automatically create the required
#' \code{matrix} for you.
#' @param sep Optional. If the \code{intervals} are represented by a character
#' vector with a character separating the interval ranges.
#' @param trim Characters to trim from the vector before splitting. For
#' example, if you are doing this on the output of \code{cut} (where, for some
#' reason, you no longer have access to the original data), you can use the
#' pre-set trim pattern \code{"cut"}.
#' @return A single numeric value representing the grouped median.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/18931054/1270695}
#' @examples
#' 
#' mydf <- structure(list(salary = c("1500-1600", "1600-1700", "1700-1800",
#'         "1800-1900", "1900-2000", "2000-2100", "2100-2200", "2200-2300",
#'         "2300-2400", "2400-2500"), number = c(110L, 180L, 320L, 460L,
#'         850L, 250L, 130L, 70L, 20L, 10L)), .Names = c("salary", "number"),
#'         class = "data.frame", row.names = c(NA, -10L))
#' mydf
#' 
#' GroupedMedian(frequencies = mydf$number, intervals = mydf$salary, sep = "-")
#' 
#' ## Example with intervals manually specified
#' X <- rbind(c(1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400),
#'            c(1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500))
#' 
#' GroupedMedian(mydf$number, X)
#' 
#' set.seed(1)
#' x <- sample(100, 100, replace = TRUE)
#' y <- data.frame(table(cut(x, 10)))
#' 
#' GroupedMedian(y$Freq, y$Var1, sep = ",", trim = "cut")
#' 
#' @export GroupedMedian
GroupedMedian <- function(frequencies, intervals, sep = NULL, trim = NULL) {
  if (!is.null(sep)) {
    if (is.null(trim)) pattern <- ""
    else if (trim == "cut") pattern <- "\\[|\\]|\\(|\\)"
    else pattern <- trim
    intervals <- sapply(strsplit(gsub(pattern, "", intervals), sep), as.numeric)
  }
  
  Midpoints <- rowMeans(intervals)
  cf <- cumsum(frequencies)
  Midrow <- findInterval(max(cf)/2, cf) + 1
  L <- intervals[1, Midrow] 
  h <- diff(intervals[, Midrow])
  f <- frequencies[Midrow]
  cf2 <- cf[Midrow - 1]
  n_2 <- max(cf)/2
  
  unname(L + (n_2 - cf2)/f * h)
}
