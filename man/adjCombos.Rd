\name{adjCombos}
\alias{adjCombos}
\title{Create adjacent combinations, varying length}
\usage{
adjCombos(invec)
}
\arguments{
  \item{invec}{The input vector}
}
\value{
A \code{list} of vectors
}
\description{
Create adjacent combinations of the elements of a vector,
varying the length with each iteration.
}
\examples{
adjCombos(letters[1:5])
}
\author{
Ananda Mahto
}
\references{
\url{http://stackoverflow.com/a/20157957/1270695}
}

