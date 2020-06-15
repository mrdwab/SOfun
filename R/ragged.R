#' Display a `data.frame` with "ragged" keys
#' 
#' This is a display method for `data.frame`s to show ragged key/grouping variables,
#' similar to `ftable`
#' 
#' @param indt The input `data.frame` or `data.table`
#' @param keys The variables to be used as keys or grouping variables
#' @param blank The character to print to show nesting. Defaults to "".
#' @return A `list` with a "ragged" object and the sorted `data.table`. The custom
#' `print` method displays the "ragged" result, but allows further use of `data.table`.
#' @author Ananda Mahto
#' @references <https://stackoverflow.com/q/41324110/1270695>
#' @seealso [stats::ftable()]
#' @examples
#' 
#' before= data.frame(C1= c(rep("A", 5), rep("L", 2)),
#' C2= c("B", rep("E", 3), rep("K", 2), "L"),
#' C3= c("C", "F", rep("H", 5)),
#' C4= c("D", "G", "I", rep("J", 4)), 
#' stringsAsFactors = FALSE)
#' 
#' ragged(before, c("C1", "C2"))
#' ragged(before, names(before), ":")
#' data(diamonds, package = "ggplot2")
#' ragged(head(diamonds, 30), c("cut", "color"), ":")[, mean(price), .(cut, color)]
#' 
#' @export ragged
ragged <- function(indt, keys, blank = "") {
  indt <- data.table::setkeyv(data.table::as.data.table(indt), keys)
  vals <- setdiff(names(indt), keys)
  nams <- paste0(keys, "_copy")
  for (i in seq_along(nams)) {
    indt[, (nams[i]) := c(as.character(get(key(indt)[i])[1]),
                          rep(blank, .N-1)), by = eval(keys[seq(i)])]
  }
  out <- cbind(indt[, ..nams], indt[, ..vals])
  out <- data.table::setnames(out, nams, keys)[]
  out <- list(indt = indt[, (nams) := NULL][], out = out, keys = keys, blank = blank)
  class(out) <- c("ragged", class(out))
  out
}
NULL

#' @rdname ragged
#' @export
#' @param x The object to be printed.
print.ragged <- function(x, ...) {
  print(x$out)
}
NULL

#' @export
`[.ragged` <- function(x, ...) {
  out <- x$indt[...]
  out <- ragged(out, keys = intersect(x$keys, names(out)), blank = x$blank)
  out
}
NULL
