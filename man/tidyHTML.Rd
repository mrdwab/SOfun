% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tidyHTML.R
\name{tidyHTML}
\alias{tidyHTML}
\title{Try to "Tidy" Untidy HTML Pages}
\usage{
tidyHTML(URL)
}
\arguments{
\item{URL}{The problematic URL}
}
\value{
A parsed URL, ready to be used with \code{readHTMLTable} from the
\code{XML} package.
}
\description{
Sometimes, web pages need a little "HTML Tidy" treatment before they can be
successfully used by the parsers in the XML package. This function tries to
tidy them using the online web service for HTML Tidy before parsing it.
}
\note{
Still no guarantee it will work! \code{:-)}
}
\examples{

\dontrun{
## Can't find an actual example. The URL from the
##   question is no longer online to test it with.

Page <- "http://en.wikipedia.org/wiki/List_of_countries_by_population"
u <- tidyHTML(Page)
tables <- readHTMLTable(u)
str(tables)
}

}
\references{
\url{http://stackoverflow.com/a/12761741/1270695}
}
\author{
Ananda Mahto
}
