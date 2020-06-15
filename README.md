# SOfun

Functions I've written as answers to R questions on Stack Overflow. Destined to be the most important R package you have ever loaded in your R session. 

## Installation

```
source("http://news.mrdwab.com/install_github.R")
install_github("mrdwab/SOfun")
```

## Contents

The "SOfun" package is filled with a very strongly cohesive set of functions, as indicated below:

1. [`adjCombos`](/R/adjCombos.R): Adjacent combinations.
1. [`almostComplete`](/R/almostComplete.R): Like `complete.cases`, but more flexible.
1. <s>`appendMe`: Like `rbind()` but adds the source in the process.</s> Just use `rbindlist` from "data.table" with the `idcol` argument instead. Much better....
1. [`arrayExtractor`](/R/arrayExtractor.R): Extracts data from an array.
1. [`CharNumSplit`](/R/CharNumSplit.R): Splits strings like "ABC123" into "ABC" and "123" or strings like "123ABC" into "123" and "ABC".
1. [`clc`](/R/clc.R):Clear your workspace.
1. [`col_flatten` and `col_flattenLong`](/R/col_flatten.R): Likely replacements for `listCol_l` and `listCol_w` from "splitstackshape".
1. [`completeVecs`](/R/completeVecs.R): Like `complete.cases()` but for vectors.
1. <s>`concat.split.DT`: Work in progress on an `fread()` approach to `concat.split()` from "splitstackshape".</s> Now part of "splitstackshape" (since V1.4.0 and above).
1. [`dailyCalendar` and `WeekDays`](/R/dailyCalendar.R): Creates a daily calendar in R.
1. [`Diag`](/R/Diag.R): A faster version of `diag()`.
1. [`dist2df`](/R/dist2df.R): Converts "dist" objects to `data.frame`s.
1. [`dupe_thresh`](/R/dupe_thresh.R): Filters a vector according to the number of duplicates in the vector.
1. <s>`expandRows`: Expand the rows of a `data.frame` by a column in the `data.frame` or by a specified vector.</s> Now a part of "splitstackshape".
1. [`Factor`](/R/Factor.R): Enhanced version of `factor()` that allows duplicated `levels` to be used more directly.
1. [`findFirst`](/R/findFirst.R): Finds the position of the n<sup>th</sup> non-sequential specified value in a vector.
1. [<s>`ftable2df`</s> `ftable2dt`](/R/ftable2dt.R): Converts the output of `ftable()` to a `data.table`. *NOTE: Changed from `data.frame` to `data.table`.*
1. [`fwf2csv`](/R/fwf2csv.R): Uses awk to convert a fixed-width file to a CSV based on stacks of whitespace.
1. [`getMyRows`](/R/getMyRows.R): Extracts a range of rows from a `data.frame`.
1. [`GroupedMedian`](/R/GroupedMedian.R): Calculates the median of grouped data.
1. [`grouped_stem`](/R/grouped_stem.R): Creates a grouped stem-and-leaf plot.
1. [`helpExtract`](/R/helpExtract.R): Extracts portions of R help files for use in Sweave or R-markdown documents.
1. [`lengthener`](/R/lengthener.R): Lengthens a dataset by the combination of its columns.
1. [`letterRep`](/R/letterRep.R): Wraps the `letters` constant making unique values.
1. [`list_unlister`](/R/list_unlister.R): Unlists columns of lists by row creating combinations of values in the process.
1. [`makemeNA`](/R/makemeNA.R): Converts specific values in a `data.frame` into `NA`.
1. [`mc_tribble`](/R/mc_tribble.R): A dput-like output for a "tribble" for those living in the tidyverse.
1. [`melt_wide`](/R/melt_wide.R): Reshapes double- and tripple-wide `data.table`s into longer `data.frame`s.
1. [`moveMe`](/R/moveMe.R): Shuffles the order of a vector around using natural language statements.
1. [`mySOreputation`](/R/mySOreputation.R): Parse your reputation page from any of the Stack Exchange sites.
1. [`naLast`](/R/naLast.R): Moves `NA` values in columns or rows to the end of their columns or rows.
1. [`needleInHaystack`](/R/needleInHaystack.R): Finds a needle in a haystack.
1. [`ragged`](/R/ragged.R): Displays a `data.frame` with ragged keys/grouping variables.
1. [`read.mtable`](/R/read.mtable.R): Reads files that have multiple tables in one go.
1. [`ReshapeLong`](/R/ReshapeLong.R): Reshapes data with multiple measurements in a wide format into a long format with one column per measurement type.
1. [`Riffle`](/R/Riffle.R): Like the `riffle` function from Mathematica, sort of.
1. [`SampleToSum`](/R/SampleToSum.R): Samples from a specified range for a vector of a specified length adding up to a specified value.
1. [`shifter`](/R/shifter.R): "Shifts" values in a vector.
1. [`shuffler`](/R/shuffler.R): Shuffles the elements of a vector such that no single element is in the same place it was before.
1. [`sortEnds`](/R/sortEnds.R): Selects the top-n highest or lowest values in a vector.
1. [`TabulateInt`](/R/TabulateInt.R): Modifies tabulate to work with non-positive integers too.
1. [`this_by_n`](/R/this_by_n.R): Applies a function by every n values to a vector minus the first value.
1. [`tidyHTML`](/R/tidyHTML.R): Downloads and parses a page after the page has been sent to the online HTML Tidy web service.
1. [`toColClasses`](/R/toColClasses.R): Converts `data.frame` columns to specified column classes.
1. [`TriIndex`](/R/TriIndex.R): Given the number of rows in a symmetric matrix, calculate the row and column indices of the upper or lower triangles.
1. [`TrueSeq`](/R/TrueSeq.R): Convert the `TRUE` values in a vector into a sequence by groups of values.
1. [`unlist_by_row` and `unlist_by_col`](/R/unlist_by_row.R): Unlists a rectangular dataset by row or column.
1. [`vec2symmat`](/R/vec2symmat.R): Converts a `vector` to a symmetric matrix (if possible).
1. [`vectorBind`](/R/vectorBind.R): Binds named vectors into a matrix.
1. [`word_value`](/R/word_value.R): Uses the numeric position of the letters in a word to create a numeric value for a word.
1. [`write.Hmisc.SPSS`](/R/write.Hmisc.SPSS.R): Writes SPSS files with label information (when using the Hmisc package).

Don't ask me why I did this.