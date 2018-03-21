#' @name dailyCalendar
#' @rdname dailyCalendar
#' @title Creates a Calendar in R
#' 
#' @description Creates a daily calendar in R.

#' @return A vector, a `data.frame`, or a `list`, depending on which function is 
#' called with what arguments.
#' @author Ananda Mahto
NULL

#' @rdname dailyCalendar
#' @param startOn The day of the week to start on. Defaults to `"Monday"`.
#' @param abbreviate Logical. Should the result be the abbreviated weekday name?
#' Defaults to `FALSE`.
#' @examples
#' WeekDays()
#' WeekDays("Thursday", TRUE)
#' @export
#' @aliases WeekDays
WeekDays <- function(startOn = "Monday", abbreviate = FALSE) {
  WD <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
  x <- match(startOn, WD)
  WD <- WD[c(x:7, setdiff(1:7, x:7))]
  if (isTRUE(abbreviate)) {
    substring(WD, 0, 3)
  } else WD
}
NULL

#' @rdname dailyCalendar
#' @param startDate What should be the first date in the calendar? Defaults to
#' `Sys.Date()`.
#' @param days How many days do you want in your calendar? Defaults to `30`.
#' @param fancy Logical. Should a more nicely formatted version of the calendar
#' be displayed? Defaults to `FALSE`.
#' @examples
#' dailyCalendar(startDate = "2013-12-27", days = 10)
#' dailyCalendar(startDate = "2013-12-27", days = 10, startOn = "Friday")
#' dailyCalendar(days = 40, fancy = TRUE)
#' @export
#' @aliases dailyCalendar
dailyCalendar <- function(startDate = Sys.Date(), days = 30, startOn = "Monday", fancy = FALSE) {
  inDailyTs <- ts(as.character(seq(as.Date(startDate), length.out = days, by = 1)), frequency = 7)
  weekday <- NULL
  temp <- data.table::data.table(
    weekday = factor(weekdays(as.Date(as.character(inDailyTs))), WeekDays(startOn)),
    date = inDailyTs, 
    month = format(as.Date(as.character(inDailyTs)), "%B"),
    day = format(as.Date(as.character(inDailyTs)), "%d"),
    year = format(as.Date(as.character(inDailyTs)), "%Y"))
  temp[, week := cumsum(weekday == startOn)]

  if (isTRUE(fancy)) {
    A <- paste(temp$month, temp$year)
    X <- split(temp, factor(A, unique(A), ordered=TRUE))
    lapply(X, function(y) {
      data.table::dcast(y, week ~ weekday, value.var = "day", fill = "", drop=FALSE)[, week := NULL][]
    })
  } else {
    data.table::dcast(temp, week ~ weekday, value.var = "date", fill = "")[, week := NULL][]
  }
}
NULL