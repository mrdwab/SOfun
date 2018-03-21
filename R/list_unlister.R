#' Unlists Columns of Lists by Combinations of Values
#' 
#' Unlists columns of lists by row creating combinations of values in the process.
#' 
#' @param indt The input \code{data.table}. The input can also be a \code{list}, 
#' possibly with elements of different lengths.
#' @param addRN Logical. Should a column named "rn" be added to the 
#' \code{data.table}? Such a column is required, so if it does not already exist,
#' it is suggested to keep this set to \code{TRUE}, the default.
#' @return A \code{data.table}.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/q/23217958/1270695}
#' @examples
#' 
#' L1 <- list(list("A", c("B", "C")), list(1:2, 1:3))
#' list_unlister(L1)
#' 
#' ## Note the NULLs and the shorter length of the first list item
#' L2 <- list(V1 = list("A", c("A", "B"), "X", NULL),
#' V2 = list(1, c(1, 2, 3), c(1, 2), c(1, 2, 3, 4), 1),
#' V3 = list(c("a", "b"), "c", "d", c("e", "f"), c("g", "h", "i")))
#' list_unlister(L2)
#' 
#' DT <- data.frame(x1 = list("A", c("A", "B"), "X", NULL, c("Z", "W")),
#' x2 = list(1, c(1, 2, 3), c(1, 2), c(1, 2, 3, 4), 1),
#' x3 = list(c("a", "b"), "c", "d", c("e", "f"), c("g", "h", "i")))
#' list_unlister(DT)
#' 
#' @export list_unlister
list_unlister <- function(indt, addRN = TRUE) {
  LEN <- lengths(indt)
  MLen <- max(LEN)
  if (any(LEN != MLen)) indt <- lapply(indt, `length<-`, MLen)
  if (!is.data.table(indt)) indt <- as.data.table(indt)
  if (isTRUE(addRN)) indt <- copy(indt)[, rn := seq_len(nrow(indt))]
  setkey(indt, rn)
  setcolorder(indt, c("rn", names(indt)[-length(indt)]))
  out <- Reduce(function(x, y) x[y, allow.cartesian = TRUE],
                lapply(setdiff(names(indt), "rn"), function(x) 
                  indt[, list(unlist(get(x))), by = rn]))
  setnames(out, names(indt))[]
}
NULL