#' Extracting Information from an Array
#' 
#' Uses a \code{list} of the same length as the dimensions of an array to extract
#' information, similar to using matrix indexing.
#' 
#' @param inarray The input array.
#' @param valslist A list of vectors to use to extract data. A value of \code{NULL}
#' for any of the list elements will return all values for that dimension.
#' @return An array.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/q/34795331/1270695}
#' @note The \code{list} used for \code{valslist} must be the same length as the
#' number of dimensions in the array. It must also be specified in the same order
#' as you would normally reference the dimensions of an array. For instance, in
#' the example, the array has row dimensions, column dimensions, and a third
#' dimension. 
#' @examples
#' 
#' my_array <- structure(1:12, .Dim = c(2L, 3L, 2L), 
#'   .Dimnames = list(c("D_11", "D_12"), 
#'   c("D_21", "D_22", "D_23"), c("D_31", "D_32")))
#' my_array
#' 
#' arrayExtractor(my_array, list("D_11", NULL, NULL))
#' arrayExtractor(my_array, list(NULL, "D_21", "D_32"))
#' arrayExtractor(my_array, list(NULL, c("D_21", "D_22"), NULL))
#' 
#' @export arrayExtractor
arrayExtractor <- function(inarray, valslist) {
  x <- sapply(valslist, is.null)
  valslist[x] <- dimnames(inarray)[x]
  temp <- as.matrix(expand.grid(valslist))
  `dimnames<-`(`dim<-`(inarray[temp], lengths(valslist)), valslist)
}
NULL
