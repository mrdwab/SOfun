#' Create a Grouped Stem-and-Leaf Plot
#' 
#' Create a stem-and-leaf plot where the stems can be grouped by multiple values
#' and the leaves indicate where the values are split
#' 
#' @param invec The input vector. This function only works with integers.
#' @param n The number of stem values to be grouped
#' @return A `list` printed with stem-and-leaf formatting
#' @author Ananda Mahto
#' @references <https://stackoverflow.com/q/62044245/1270695>
#' @seealso [graphics::stem()]
#' @examples
#' 
#' set.seed(1)
#' data_pos <- sample(0:50, 100, TRUE)
#' grouped_stem(data_pos, 2)
#' 
#' data_neg <- sample(-50:-1, 100, TRUE)
#' grouped_stem(data_neg, 2)
#' 
#' data_pos_neg <- c(0, sample(-50:50, 100, TRUE))
#' grouped_stem(data_pos_neg, 3)
#' 
#' @export grouped_stem
grouped_stem <- function(invec, n = 2) {
  if (!all(as.numeric(invec) == as.integer(invec))) stop("This function only works with integers")
  invec <- sort(invec)
  negative <- if (any(invec < 0)) TRUE else FALSE
  positive <- if (any(invec >= 0)) TRUE else FALSE
  type <- c("positive", "negative")[c(positive, negative)]
  type <- if (length(type) == 2) "both" else type
  out <- switch(type,
                negative = gsn(invec[invec < 0], n),
                positive = gsp(invec[invec >= 0], n),
                both = c(gsn(invec[invec < 0], n), 
                         gsp(invec[invec >= 0], n)))
  class(out) <- c("grouped_stem", class(out))
  out
}
NULL

gsn <- function(negs, n = 2) {
  cuts <- seq(((min(negs) %/% 10)-1) * 10, 0)
  labs <- sub("(.*).$", "\\1", cuts+1)
  labs <- replace(labs, labs == "-" | !nzchar(labs), "-0")
  temp <- split(negs, cut(negs, cuts, labs[-length(labs)], right = TRUE))
  temp <- relist(sub(".*(.)$", "\\1", unlist(temp, use.names = FALSE)), temp)
  combined <- vapply(temp, function(y) sprintf("%s*", paste(y, collapse = "")), character(1L))
  splits <- split(combined, ((seq_along(combined)-1) %/% n))
  stems <- vapply(splits, function(x) {
    paste(names(x)[1], names(x)[length(x)], sep = " to ")
  }, character(1L))
  leaves <- vapply(splits, function(x) {
    sub("[*]$", "", paste(x, sep = "", collapse = ""))
  }, character(1L))
  setNames(as.list(leaves), stems)
}
NULL

gsp <- function(poss, n = 2) {
  cuts <- seq((min(poss) %/% 10) * 10, round(max(poss)+10, -(nchar(max(poss))-1)), 10)
  labs <- sub("(.*).$", "\\1", cuts)
  labs <- replace(labs, !nzchar(labs), "0")
  temp <- split(poss, cut(poss, cuts, labs[-length(labs)], right = FALSE))
  temp <- relist(sub(".*(.)$", "\\1", unlist(temp, use.names = FALSE)), temp)
  combined <- vapply(temp, function(y) sprintf("%s*", paste(y, collapse = "")), character(1L))
  splits <- split(combined, ((seq_along(combined)-1) %/% n))
  stems <- vapply(splits, function(x) {
    paste(names(x)[1], names(x)[length(x)], sep = " to ")
  }, character(1L))
  leaves <- vapply(splits, function(x) {
    sub("[*]$", "", paste(x, sep = "", collapse = ""))
  }, character(1L))
  setNames(as.list(leaves), stems)
}
NULL

#' @rdname grouped_stem
#' @export
#' @param x The object to be printed.
#' @param \dots Not used.
#' @aliases print.grouped_stem
print.grouped_stem <- function(x, ...) {
  cat(sprintf(sprintf("%%%ss | %%s", max(nchar(names(x)))+2), 
              names(x), unlist(x, use.names = FALSE)), sep = "\n")
}