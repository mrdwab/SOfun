

#' Functions written while answering Stack Overflow questions
#' 
#' A collection of functions I've written while answering questions on Stack
#' Overflow.
#' 
#' \tabular{ll}{ Package: \tab SOfun\cr Type: \tab Package\cr Version: \tab
#' 1.72\cr Date: \tab 2018-03-21\cr License: \tab CC0\cr }
#' 
#' @name SOfun-package
#' @aliases SOfun SOfun-package
#' @docType package
#' @author Ananda Mahto
#' 
#' Maintainer: <ananda@@mahto.info> Ananda Mahto
#' @keywords package
#' @examples
#' 
#' adjCombos(letters[1:5])
#' 
#' cvA <- c(12, 8, 11, 9); cvB <- c(NA, 7, NA, 10)
#' completeVecs(cvA, cvB)
#' 
#' fx <- c("Y", "Y", "Yes", "N", "No", "H")
#' Factor(fx, list(Yes = c("Yes", "Y"), No = c("No", "N")))
#' 
#' moveA <- letters[1:10]
#' moveMe(moveA, "a last; b, e, g before d; c first; h after j")
#' 
#' letterRep(20:40)
#' 
#' Riffle(1:6, "x")
#' Riffle(1:6, c("x", "y"))
#' 
#' set.seed(1)
#' SampleToSum()
#' 
#' shiftX <- c(1, 4, 5, 2, 3, 6, 7, 8, 10, 9)
#' shifter()[shiftX]
#' 
#' shuffler(letters[1:10])
#' 
NULL



