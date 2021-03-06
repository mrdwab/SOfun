% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/findFirst.R
\name{findFirst}
\alias{findFirst}
\title{Find the First, Second, n Non-sequential Position of a Value in a Vector}
\usage{
findFirst(invec, value, event)
}
\arguments{
\item{invec}{The input vector.}

\item{value}{The value you are looking for.}

\item{event}{The desired position to be returned.}
}
\value{
A vector of length 1.
}
\description{
This function returns the location of the first, second, third (and so on)
occurrence of a specified non-sequential value in a vector.
}
\examples{

set.seed(1)
a <- sample(LETTERS[1:5], 20, TRUE)
a

## Note the difference between the following.
## The value "2" is skipped because it is sequential.
which(a == "B")

findFirst(a, "B", 2)

}
\references{
\url{http://stackoverflow.com/q/22049035/1270695}
}
\author{
Ananda Mahto
}
