#' @import Hmisc
NULL

#' @import data.table
NULL

#' @import stringr
NULL

#' @import utils
NULL

#' @importFrom stats ave embed ftable runif setNames ts
NULL

.id <- rn <- value <- writeClipboard <- NULL

#' Read Clipboard Regardless of OS
#' 
#' Different operating systems have different ways of handling the clipboard. 
#' Given the frequency with which text is copied to the clipboard to place in
#' an answer on StackOverflow, this utility is provided.
#' 
#' @return character string containing text on the clipboard.
#' 
readClip <- function() {
  OS <- Sys.info()["sysname"]
  cliptext <- switch(
    OS,
    Darwin = {
      con <- pipe("pbpaste")
      text <- readLines(con)
      close(con)
      text
    },
    Windows = readClipboard(),
    Linux = {
      if (Sys.which("xclip") == "") {
        mess <- c("Clipboard on Linux requires 'xclip'. Try using:", 
                  "sudo apt-get install xclip")
        message(paste(mess, collapse = "\n"))
      } 
      con <- pipe("xclip -o -selection clipboard")
      text <- readLines(con = con)
      close(con)
      text
    },
    stop("Reading from clipboard not yet supported on your OS"))
  cliptext
}

#' Write to Clipboard on Multiple OSes
#' 
#' This function works on Windows, Mac and Linux. It copies a 
#' character string or vector of characters to the clipboard and interprets
#' a vector of characters as one character with each element being newline
#' separated. If using Linux, xclip is used as the clipboard. So for the
#' function to work, xclip must be installed.
#' 
#' @param object character. Character to be copied to the clipboard
#' 
#' @return Returns nothing to R. Returns character string to the clipboard
#' 
#' @details If using Linux, xclip will be used as the clipboard. To paste from 
#' xclip, either use middle click or the command \code{xclip -o} in the shell.
#' 
writeClip <- function(object) {
  OS <- Sys.info()["sysname"]
  if(!(OS %in% c("Darwin", "Windows", "Linux"))) {
    stop("Copying to clipboard not yet supported on your OS")
  } 
  switch(
    OS, 
    Darwin = {
      con <- pipe("pbcopy", "w")
      writeLines(object, con=con)
      close(con)
    },
    Windows = writeClipboard(object, format = 1),
    Linux = {
      if (Sys.which("xclip") == "") {
        if (Sys.which("xclip") == "") {
          mess <- c("Clipboard on Linux requires 'xclip'. Try using:", 
                    "sudo apt-get install xclip")
          message(paste(mess, collapse = "\n"))
        } 
      }
      con <- pipe("xclip -selection clipboard -i", open = "w")
      writeLines(object, con=con)
      close(con)
    })
}

getDots <- function(...) sapply(substitute(list(...))[-1], deparse)
NULL