#' Clear your workspace
#' 
#' A slightly more elaborate version of \code{rm(list = ls())} to clear your
#' workspace.
#' 
#' 
#' @param all Logical. Should hidden objects also be removed? Defaults to
#' \code{FALSE}.
#' @return Nothing
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/20389913/1270695}
#' @examples
#' 
#' \dontrun{
#' clc()      # Will not affect hidden files
#' clc(TRUE)  # Will affect hidden files
#' }
#' 
#' @export clc
clc <- function(all = FALSE) {
  rm(list = ls(.GlobalEnv, all = all), envir = .GlobalEnv)
}
