#' Parse Your Reputation Page From Any of the Stack Exchange Sites
#' 
#' It is very easy to \emph{view} a detailed account of your reputation at any
#' of the Stack Exchange sites by visiting \code{http://"sitename"/reputation}
#' (obviously substituting "sitename" for the actual site of interest, for
#' example, \url{http://stackoverflow.com/reputation}).  However, that format
#' is not very user-friendly if you want to do any analysis with it. This
#' function parses that page into an R \code{data.frame}.
#' 
#' 
#' @param rep_file The path to a text version of your reputation page. Windows
#' and Linux users can copy the text on the page with select all + copy, and
#' simply use "clipboard" instead of saving the contents to a local file.
#' @author Paul Hiemstra provided the base parser. Built upon by Ananda Mahto.
#' @references Values for the "actions" variable determined after visiting
#' \url{http://meta.stackexchange.com/a/43005/214964}.
#' There is one value not mentioned at that page, coded as \code{action_id ==
#' 99} and \code{action == Bonus} that corresponds to the bonus that a user
#' gets when they have above a certain reputation and are active on multiple
#' Stack Exchange sites.
#' @examples
#' 
#' ## This is a real reputation file,
#' ##    but the "question_id" variable is
#' ##    made up.
#' rep_file <- system.file("soreputation.txt", package = "SOfun")
#' readLines(rep_file, 15)
#' mydf <- mySOreputation(rep_file = rep_file)
#' head(mydf, 15)
#' str(mydf)
#' plot(mydf$date, cumsum(mydf$rep_change))
#' 
#' \dontrun{
#' library(xts)
#' mydfx <- xts(mydf$rep_change, mydf$date)
#' apply.monthly(mydfx, sum)
#' plot(apply.monthly(mydfx, sum))
#' }
#' 
#' 
#' @export mySOreputation
mySOreputation <- function(rep_file) {
  all_data <- readLines(rep_file) 
  if (isTRUE(grepl("^total votes", all_data[1]))) { all_data <- all_data[-1] }
  else all_data <- all_data
  all_data <- gsub("-- bonuses\\s+(.*)", " 99  NA      \\1", all_data)
  
  date_entries <- grep("^-", all_data) 
  actions_per_day <- c(date_entries[1], diff(date_entries)) - 1 
  
  dat <- read.table(
    text = all_data[-c(date_entries, 
                       date_entries[length(date_entries)]:length(all_data))]) 
  names(dat) <- c("action_id", "question_id", "rep_change") 
  dat$rep_change <- as.numeric(gsub("\\(|\\)|\\[|\\]", "", dat$rep_change)) 
  
  dat$date <- rep(all_data[date_entries], times = actions_per_day) 
  dat$date <- as.Date(gsub("-- (.*) rep.*", "\\1", dat$date))
  
  actions <- as.character(dat$action_id)
  actions[dat$action_id == 1] <- with(
    dat[dat$action_id == 1, ], 
    ifelse(rep_change == 15, "YourAnswerAccepted", "AnswerAcceptedByYou"))
  actions[dat$action_id == 3] <- with(
    dat[dat$action_id == 3, ],
    ifelse(rep_change == -1, "YouDownvoted", "YouWereDownvoted"))
  dat$actions <- factor(
    actions, levels = c("AnswerAcceptedByYou", "YourAnswerAccepted", 2, 
                        "YouDownvoted", "YouWereDownvoted", 4, 8, 9, 12, 16, 99),
    labels = c("AnswerAcceptedByYou", "YourAnswerAccepted", "Upvote", "YouDownvoted", 
               "YouWereDownvoted", "Penalty-Offensive", "BountyOffered", 
               "BountyReceived", "Penalty-Spam", "EditApproved", "Bonus"))
  
  dat$action_id <- factor(dat$action_id, c(1:4, 8, 9, 12, 16, 99))
  dat
} 