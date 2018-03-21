#' Converts a Vector of Words to Numeric Values Based on Letter Positions
#' 
#' Uses the numeric position of the letters in a word to create a numeric value
#' for a word.
#' 
#' @param words The input vector of words.
#' @param dtOut Logical. Should the output be a \code{data.table} comprising
#' the words and the values. Defaults to \code{FALSE}.
#' @return A named numeric vector or a \code{data.table}.
#' @author Ananda Mahto and \href{http://stackoverflow.com/users/640595/jota}{Jota}.
#' @references \url{http://stackoverflow.com/q/36097446/1270695}
#' @details The function converts the input to lowercase, removes anything that
#' is not between the letters "a" and "z", and transliterates accented characters
#' to their ASCII equivalent before converting the word to a numeric value.
#' @examples
#' 
#' myvec <- c("and", "dad", "cat", "fox", "mom", 
#'            "add", "dan", "naive", "non-descript")
#' word_value(myvec)
#' word_value(myvec, TRUE)
#' 
#' @export word_value
word_value <- function(words, dtOut = FALSE) {
  offset <- utf8ToInt("a") - 1
  stripped <- iconv(tolower(gsub("[^a-z]", "", words)), to = "ASCII//TRANSLIT")
  out <- vapply(stripped, function(ii)
    sum(utf8ToInt(ii) - offset), numeric(1L))
  if (isTRUE(dtOut)) setnames(data.table(as.table(out)), c("word", "value"))[]
  else out
}
NULL
