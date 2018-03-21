#' "Wrap" the \code{letters} Constant
#' 
#' The \code{letterRep} function "wraps" the \code{letters} constant, making
#' repeated letters unique by pasting characters together.
#' 
#' 
#' @param inRange The (numeric) input range.
#' @return A character vector.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/21681824/1270695}
#' @examples
#' 
#' letterRep(60)
#' letterRep(20:40)
#' 
#' @export letterRep
letterRep <- function(inRange) {
  if (length(inRange) == 1) inRange <- sequence(inRange)
  temp <- (inRange - 1) %% 26 + 1
  vals <- letters[temp]
  grp <- cumsum(c(1, temp[-length(temp)] %/% 26))
  vapply(seq_along(vals), 
         function(x) paste(rep(vals[x], grp[x]), collapse = ""),
         character(1L))
}
