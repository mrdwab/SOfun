#' Move All \code{NA} Values to the End of the Rows or Columns of a Matrix
#' 
#' Moves all of the \code{NA} values in the rows or columns of a matrix to the
#' end of the respective rows or columns.
#' 
#' 
#' @param inmat The input matrix.
#' @param by Should be either \code{"row"} or \code{"col"}, depending on if you
#' want to shift non-\code{NA} values left or up.
#' @param outList Logical. Do you just want a \code{list} of the non-\code{NA}
#' values? Defaults to \code{FALSE}.
#' @param fill While you're at it, do you want to replace \code{NA} with some
#' other value?
#' @return Either a \code{matrix} with the same dimensions as the input matrix
#' or a \code{list} with the same number of rows or columns as the input matrix
#' (depending on the choice made in \code{by}).
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/q/23008142/1270695}
#' @examples
#' 
#' set.seed(1)
#' m <- matrix(sample(25, 20, TRUE), ncol = 4,
#'             dimnames = list(letters[1:5], LETTERS[1:4]))
#' m[sample(prod(dim(m)), prod(dim(m)) * .6)] <- NA
#' 
#' m
#' 
#' naLast(m, by = "row")
#' naLast(m, by = "col")
#' naLast(m, by = "col", outList = TRUE)
#' 
#' @export naLast
naLast <- function(inmat, by = "row", outList = FALSE, fill = NA) {
  A <- dim(inmat)
  M <- matrix(fill, nrow = A[1], ncol = A[2])
  dimnames(M) <- dimnames(inmat)
  switch(by, 
         row = {
           myFun1 <- function(x) { y <- inmat[x, ]; y[!is.na(y)] }
           B <- sequence(A[1])
         },
         col = {
           myFun1 <- function(x) { y <- inmat[, x]; y[!is.na(y)] }
           B <- sequence(A[2])
         },
         stop("'by' must be either 'row' or 'col'"))
  
  myList <- lapply(B, myFun1)
  if (isTRUE(outList)) {
    myList
  } else {
    Len <- vapply(myList, length, 1L)
    switch(by,
           row = {
             IJ <- cbind(rep(sequence(A[1]), Len), sequence(Len))
           },
           col = {
             IJ <- cbind(sequence(Len), rep(sequence(A[2]), Len))
           },
           stop("'by' must be either 'row' or 'col'"))
    M[IJ] <- unlist(myList, use.names=FALSE)
    M
  }
}
NULL
