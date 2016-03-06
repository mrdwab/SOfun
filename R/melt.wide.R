#' Melt Wide data.tables into Long data.tables
#' 
#' Reshapes double and tripple wide \code{data.table}s to long
#' \code{data.table}s
#' 
#' 
#' @param data The input \code{data.frame}
#' @param id.vars ID variables
#' @param new.names The new names for the resulting columns
#' @return A long \code{data.table}
#' @author Ananda Mahto
#' @references \url{http://stackoverflow.com/a/10170630/1270695}
#' @examples
#' 
#' triplewide <- structure(list(ID = 1:4,
#'                              w1d1t1 = c(4L, 3L, 2L, 2L),
#'                              w1d1t2 = c(5L, 4L, 3L, 3L),
#'                              w1d2t1 = c(6L, 5L, 5L, 4L),
#'                              w1d2t2 = c(5L, 4L, 5L, 2L),
#'                              w2d1t1 = c(6L, 5L, 4L, 3L),
#'                              w2d1t2 = c(5L, 4L, 5L, 5L),
#'                              w2d2t1 = c(6L, 3L, 6L, 3L),
#'                              w2d2t2 = c(7L, 4L, 3L, 2L)),
#'                              .Names = c("ID", "w1d1t1", "w1d1t2",
#'                              "w1d2t1", "w1d2t2", "w2d1t1", "w2d1t2",
#'                              "w2d2t1", "w2d2t2"),
#'                              class = "data.frame",
#'                              row.names = c(NA, -4L))
#' triplewide
#' triplewide.long <- melt.wide(triplewide, id.vars="ID",
#'                             new.names=c("week", "day", "trial"))
#' triplewide.long
#' data.table::dcast(triplewide.long, ID + week + day ~ trial)
#' 
#' @export melt.wide
melt.wide = function(data, id.vars, new.names) {
  if (!data.table::is.data.table(data)) data <- data.table::as.data.table(data)
  data.melt = data.table::melt(data, id.vars=id.vars)
  data.melt[, (new.names) := data.table::transpose(
    stringr::str_extract_all(variable, "[0-9]+"))][]
}
