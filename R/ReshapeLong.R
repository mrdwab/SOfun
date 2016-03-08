#' @name ReshapeLong
#' @rdname ReshapeLong
#' @title Reshape Data into a Semi-Long Format
#' 
#' @description Reshapes data with multiple measurements in a wide format into 
#' a long format with one column per measurement type.
#' 
#' @param indt The input \code{data.table}.
#' @param stubs Character vector containing the uniquely identifying stub 
#' portion of the variable names.
#' @param sep Not presently used.
#' @return A \code{data.table}.
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/q/10468969/1270695}
#' @examples 
#' 
#' \dontrun{
#' library(foreign)
#' dadmom <- read.dta("http://www.ats.ucla.edu/stat/stata/modules/dadmomw.dta")
#' ReshapeLong(dadmom, c("name", "inc"))
#' }
#' 
#' @export
ReshapeLong <- function(indt, stubs, sep = NULL) {
  if (!data.table::is.data.table(indt)) indt <- data.table::as.data.table(indt)
  variable <- NULL
  mv <- lapply(stubs, function(y) grep(sprintf("^%s", y), names(indt)))
  levs <- unique(gsub(paste(stubs, collapse="|"), "", names(indt)[unlist(mv)]))
  if (!is.null(sep)) levs <- gsub(sprintf("^%s", sep), "", levs, fixed = TRUE)
  data.table::melt(indt, measure = mv, value.name = stubs)[
    , variable := factor(variable, labels = levs)][]
}
NULL
