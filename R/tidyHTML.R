#' Try to "tidy" untidy HTML pages
#' 
#' Sometimes, web pages need a little "HTML Tidy" treatment before they can be
#' successfully used by the parsers in the XML package. This function tries to
#' tidy them using the online web service for HTML Tidy before parsing it.
#' 
#' 
#' @param URL The problematic URL
#' @return A parsed URL, ready to be used with \code{readHTMLTable} from the
#' \code{XML} package.
#' @note Still no guarantee it will work! \code{:-)}
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/12761741/1270695}
#' @examples
#' 
#' ## Can't find an actual example. The URL from the
#' ##   question is no longer online to test it with.
#' 
#' Page <- "http://en.wikipedia.org/wiki/List_of_countries_by_population"
#' u <- tidyHTML(Page)
#' tables <- readHTMLTable(u)
#' str(tables)
#' 
#' @export tidyHTML
tidyHTML <- function(URL) {
  require(XML)
  URL = gsub("/", "%2F", URL)
  URL <- gsub(":", "%3A", URL)
  URL <- paste("http://services.w3.org/tidy/tidy?docAddr=", URL, sep = "")
  htmlParse(URL)
}
