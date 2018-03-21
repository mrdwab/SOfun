#' Subset a `data.frame` by Completeness of Rows or Columns
#' 
#' An alternative to [stats::complete.cases()] that lets you specify the
#' percentage of completeness desired.
#' 
#' When `n` is specified and `rowPct` and `colPct` are `NULL`, the function 
#' calculates the number of `NA` values by row and column. By default, it then 
#' drops the rows and columns with the highest number of missing values. With 
#' the dataset in the *Examples* section, if you use `n = 2`, the function will 
#' remove rows 1, 3, and 6 and columns A, B, C, and F. Compare this behavior 
#' with the results of `rowSums(is.na(mydf))` and `colSums(is.na(mydf))`.
#' 
#' @param dataset The input `data.frame`
#' @param rowPct The maximum percent of `NA` values in rows, as a decimal.
#' @param colPct The maximum percent of `NA` values in columns, as a decimal.
#' @param n When `rowPct` and `colPct` are `NULL`, the function will drop at 
#' least the number of rows and columns specified here, by "rank", if any 
#' contain `NA`. See "Details".
#' @return A `data.frame`
#' @author Ananda Mahto
#' @references <http://stackoverflow.com/a/20475029/1270695>
#' @examples
#' 
#' mydf <- read.csv(text="
#' SampleID,A,B,C,D,E,F
#' x1,NA,x,NA,x,NA,x
#' x2,x,x,NA,x,x,NA
#' x3,NA,NA,x,x,x,NA
#' x4,x,x,x,NA,x,x
#' x5,x,x,x,x,x,x
#' x6,NA,NA,NA,x,NA,NA
#' x7,x,x,x,NA,x,x
#' x8,NA,NA,x,x,x,x
#' x9,x,x,x,x,x,NA
#' x10,x,x,x,x,x,x
#' x11,NA,x,x,x,x,NA")
#' 
#' ## What do the data look like?
#' ## How many NAs are there per column and row?
#' mydf
#' colSums(is.na(mydf))
#' rowSums(is.na(mydf))
#' 
#' ## What does complete.cases do?
#' mydf[complete.cases(mydf), ]
#' 
#' ## Drop whichever row and column have
#' ## the highest percentage of NA values
#' almostComplete(mydf, NULL, NULL)
#' 
#' ## Drop the rows and columns which have
#' ## more than the second highest percentage of NA values
#' almostComplete(mydf, NULL, NULL, n = 2)
#' 
#' ## Set one threshold value for both rows and columns.
#' almostComplete(mydf, .7)
#' 
#' ## Specify row and column threshold values separately.
#' almostComplete(mydf, rowPct = .2, colPct = .5)
#' 
#' @export almostComplete
almostComplete <- function(dataset, rowPct, colPct = rowPct, n = 1) {
  if (sum(is.na(dataset)) == 0) out <- dataset
  else {
    CS <- colSums(is.na(dataset))/ncol(dataset)
    RS <- rowSums(is.na(dataset))/nrow(dataset)
    if (is.null(rowPct)) rowPct <- head(sort(unique(RS), 
                                             decreasing=TRUE), n)[n]
    if (is.null(colPct)) colPct <- head(sort(unique(CS), 
                                             decreasing=TRUE), n)[n]
    
    dropCols <- which(CS >= colPct)
    dropRows <- which(RS >= rowPct)
    out <- dataset[setdiff(sequence(nrow(dataset)), dropRows),
                   setdiff(sequence(ncol(dataset)), dropCols),
                   drop = FALSE]
  }
  out
}
