#' Bind Vectors Column-Wise According to Name
#' 
#' Combines named vectors into a matrix with the rows being the names of the
#' vector elements, and the columns being the name of the source vector.
#' 
#' @param \dots The objects that need to be combined.
#' @return A matrix.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/q/25639223/1270695}
#' @examples
#' 
#' set.seed(1)
#' t1 <- table(sample(LETTERS[c(1, 2, 4)], 20, TRUE))
#' t2 <- table(sample(LETTERS[c(1, 2, 3)], 20, TRUE))
#' t3 <- table(sample(LETTERS[c(2, 4, 5)], 20, TRUE))
#' 
#' vectorBind(t1, t2, t3)
#' 
#' @export vectorBind
vectorBind <- function(...) {
  tbs <- list(...)
  names(tbs) <- getDots(...)
  nm <- unique(names(unlist(unname(tbs))))
  vapply(tbs, function(x) {
    length(x) <- length(nm)
    x <- x[match(nm, names(x))]
    setNames(x, nm)
  }, numeric(length = length(nm)))
}
NULL
