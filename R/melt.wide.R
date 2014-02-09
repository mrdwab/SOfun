#' melt wide data.frames into long data.frames
#' 
#' Reshapes double and tripple wide \code{data.frame}s to long
#' \code{data.frame}s
#' 
#' 
#' @param data The input \code{data.frame}
#' @param id.vars ID variables
#' @param new.names The new names for the resulting columns
#' @return A long \code{data.frame}
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
#' dcast(triplewide.long, ID + week + day ~ trial)
#' 
#' @export melt.wide
melt.wide = function(data, id.vars, new.names) {
  require(reshape2)
  require(stringr)
  data.melt = melt(data, id.vars=id.vars)
  new.vars = data.frame(do.call(
    rbind, str_extract_all(data.melt$variable, "[0-9]+")))
  names(new.vars) = new.names
  cbind(data.melt, new.vars)
}
