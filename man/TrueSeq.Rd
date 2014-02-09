\name{TrueSeq}
\alias{TrueSeq}
\title{Convert TRUE values in a vector to a grouped sequence}
\usage{
TrueSeq(inLogi, zero2NA = FALSE)
}
\arguments{
  \item{inLogi}{The input logical vector.}

  \item{zero2NA}{Logical. Should the zeroes in the result
  be converted to \code{NA}. Defaults to \code{FALSE}.}
}
\value{
A numeric vector
}
\description{
Convert the \code{TRUE} values in a vector into a sequence
by groups of values.
}
\examples{
set.seed(1)
x <- sample(c(TRUE, FALSE), 100, TRUE)

TrueSeq(x)
}
\author{
Ananda Mahto
}
\references{
\url{http://stackoverflow.com/a/21328046/1270695}
}

