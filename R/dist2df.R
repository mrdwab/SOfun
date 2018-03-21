#' Converts a Distance Matrix to a data.frame
#' 
#' Converts a distance matrix to a `data.frame`.
#' 
#' @param inDist The input distance object.
#' @return A `data.frame`.
#' @author Ananda Mahto
#' @references <http://stackoverflow.com/q/23474729/1270695>
#' @examples
#' 
#' dd <- as.dist((1 - cor(USJudgeRatings)[1:5, 1:5])/2)
#' dist2df(dd)
#' 
#' @export dist2df
dist2df <- function(inDist) {
  if (class(inDist) != "dist") stop("wrong input type")
  A <- attr(inDist, "Size")
  B <- if (is.null(attr(inDist, "Labels"))) sequence(A) else attr(inDist, "Labels")
  if (isTRUE(attr(inDist, "Diag"))) attr(inDist, "Diag") <- FALSE
  if (isTRUE(attr(inDist, "Upper"))) attr(inDist, "Upper") <- FALSE
  data.frame(
    row = B[unlist(lapply(sequence(A)[-1], function(x) x:A))],
    col = rep(B[-length(B)], (length(B)-1):1),
    value = as.vector(inDist))
}
NULL
