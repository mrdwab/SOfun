#' Find a needle in a haystack...
#' 
#' Find specified search patterns (in any order, not necessarily joined) in
#' another vector of strings.
#' 
#' 
#' @param findMe What are you looking for? A character vector.
#' @param findIn Where are you looking for it? A character vector.
#' @return A matrix with 1 indicating presence and 0 indicating absence.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/q/22129542/1270695}
#' @examples
#' 
#' x <- c("cat", "dog", "rat", "far", "f*n", "god", "g*dn")
#' y <- c("ar", "n*", "a", "zo")
#' 
#' needleInHaystack(y, x)
#' 
#' @export needleInHaystack
needleInHaystack <- function(findMe, findIn) {
  Specials <- c(".", "|", "(", ")", "[", "{", "^", "$", "*", "+", "?")
  Patterns <- strsplit(findMe, "", fixed=TRUE)
  out <- vapply(vapply(Patterns, function(x) {
    x <- ifelse(x %in% Specials, paste0("\\", x), x)
    paste0("^", paste0("(?=.*", x, ")", collapse=""))
  }, character(1L)), grepl, logical(length(findIn)),
  findIn, perl = TRUE) * 1
  dimnames(out) <- list(findIn, findMe)
  out
}
