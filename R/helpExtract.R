#' Extract portions from R help files for use in documents
#' 
#' Extracts specified portions of R help files for use in Sweave or R-markdown
#' documents.
#' 
#' The \code{type} argument accepts: \itemize{ \item \code{"m_code"}: For use
#' with markdown documents in instances where highlighted code is expected, for
#' example the "Usage" section. \item \code{"m_text"}: For use with markdown
#' documents in instances where regular text is expected, for example the
#' "Description" section. \item \code{"s_code"}: For use with Sweave documents
#' in instances where highlighted code is expected, for example the "Usage"
#' section. \item \code{"s_text"}: For use with Sweave documents in instances
#' where regular text is expected, for example the "Description" section. } To
#' insert a chunk into a markdown document, use something like:
#' 
#' \verb{```{r, echo=FALSE, results='asis'}} \verb{cat(helpExtract(cor), sep =
#' "\n")} \verb{```}
#' 
#' To insert a chunk into a Sweave document, use something like:
#' 
#' \verb{\Sexpr{knit_child(textConnection(helpExtract(cor, type = "s_code")),
#' options = list(tidy = FALSE, eval = FALSE))}}
#' 
#' @param Function The function that you are extracting the help file from.
#' @param section The section you want to extract. Defaults to \code{"Usage"}.
#' @param type The type of character vector you want returned. Defaults to
#' \code{"m_code"}. See \emph{Details}
#' @param \dots Other arguments passed to \code{getHelpFile}.
#' @return A character vector to be used in a Sweave or R-markdown document.
#' @author Ananda Mahto
#' @references %% ~put references to the literature/web site here ~
#' @examples
#' 
#' cat(helpExtract(cor), sep = "\n")
#' 
#' cat(helpExtract(cor, type = "m_text"))
#' 
#' cat(helpExtract(cor, type = "m_text", section="Description"))
#' 
#' @export helpExtract
helpExtract <- function(Function, section = "Usage", type = "m_code", ...) {
  A <- deparse(substitute(Function))
  x <- capture.output(tools:::Rd2txt(utils:::.getHelpFile(utils::help(A, ...)),
                                     options = list(sectionIndent = 0)))
  B <- grep("^_", x)                    ## section start lines
  x <- gsub("_\b", "", x, fixed = TRUE) ## remove "_\b"
  X <- rep(FALSE, length(x))
  X[B] <- 1
  out <- split(x, cumsum(X))
  out <- out[[which(sapply(out, function(x) 
    grepl(section, x[1], fixed = TRUE)))]][-c(1, 2)]
  while(TRUE) {
    out <- out[-length(out)]
    if (out[length(out)] != "") { break }
  } 
  
  switch(
    type,
    m_code = c("```r", out, "```"),
    s_code = c("<<>>=", out, "@"),
    m_text = paste("    ", out, collapse = "\n"),
    s_text = c("\\begin{verbatim}", out, "\\end{verbatim}"),
    stop("`type` must be either `m_code`, `s_code`, `m_text`, or `s_text`")
  )
}
