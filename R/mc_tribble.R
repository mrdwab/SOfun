#' Like `dput` for Those Confined to the Tidyverse
#' 
#' Creates a `dput`-like pasteable format that can be used to create small tables.
#' 
#' @param indf The input `data.frame`.
#' @param indents The number of spaces to indent each line of output. Defaults 
#' to `4`.
#' @param mdformat Logical. Whether or not to add 4 spaces before every line in 
#' order to format as a code block. Defaults to `TRUE`.
#' @author Ananda Mahto. Name courtesy of [Frank](https://stackoverflow.com/users/1191259/frank).
#' @references <http://stackoverflow.com/q/42839626/1270695>
#' @examples
#' 
#' \dontrun{
#' short_iris <- head(iris)
#' mc_tribble(short_iris)
#' }
#' 
#' @export mc_tribble
mc_tribble <- function(indf, indents = 4, mdformat = TRUE) {
  name <- as.character(substitute(indf))
  name <- name[length(name)]
  cols <- paste0("~", names(indf), collapse = ", ")
  
  meat <- paste0(
    paste(rep(" ", indents), collapse = ""),
    c(cols, capture.output(
      data.table::fwrite(indf, quote = TRUE, col.names = FALSE, sep = ","))))

  if (mdformat) meat <- paste0("    ", meat)
  obj <- paste(name, " <- tribble(\n", paste(meat, collapse = ",\n"), ")", sep = "")
  if (mdformat) obj <- paste0("    ", obj)
  writeClip(obj)
  cat(obj)
}