% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ftable2dt.R
\name{ftable2dt}
\alias{ftable2dt}
\title{Convert an \code{ftable} or an \code{array} Object to a \code{data.table}}
\usage{
ftable2dt(inarray, direction = "wide")
}
\arguments{
\item{inarray}{The input \code{ftable} or \code{array}.}

\item{direction}{Should the reslut be "wide" (with multiple measurement.
columns) or "long" (with a single measurement column)? Defaults to \code{"wide"}.}
}
\value{
A \code{data.table}
}
\description{
While convenient methods exist for converting \code{table}s and other
objects to \code{data.tables}s, such methods do not exist for converting an
\code{ftable} to a \code{data.table}. An \code{ftable} is essentially a \code{matrix} with
\code{attributes} for the rows and columns, which can be nested.
}
\note{
If the array has no \code{dimnames}, names would be added using the
\code{provideDimnames} function. Defaults to \code{\link[reshape2:melt]{reshape2::melt()}} if the input is a
simple matrix and not a multidimensional array.
}
\examples{

x <- ftable(Titanic, row.vars = 1:3)
x
ftable2dt(x)
ftable2dt(x, direction = "long")

\dontrun{
dims <- c(2, 1, 2, 3, 2)
set.seed(1)
M <- `dim<-`(sample(100, prod(dims), TRUE), dims)
N <- O <- `dimnames<-`(M, lapply(dims, function(x) 
                                 c(letters, LETTERS)[seq_len(x)]))
names(attributes(O)$dimnames) <- c("first", "second", "third", 
                                   "fourth", "fifth")

ftable2dt(M)
ftable2dt(N)
ftable2dt(O)
ftable2dt(M, "long")
ftable2dt(N, "long")
ftable2dt(O, "long")
}

}
\references{
\url{http://stackoverflow.com/a/11143126/1270695}
}
\author{
Ananda Mahto
}
