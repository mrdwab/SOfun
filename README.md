# SOfun

Functions I've written as answers to R questions on Stack Overflow. Destined to be the most important R package you have ever loaded in your R session. Filled with a very strongly cohesive set of functions, as indicated below:

1. `adjCombos`: Adjacent combinations.
1. `almostComplete`: Like `complete.cases`, but more flexible.
1. <s>`appendMe`: Like `rbind()` but adds the source in the process.</s> Just use `rbindlist` from "data.table" with the `idcol` argument instead. Much better....
1. `CharNumSplit`: Splits strings like "ABC123" into "ABC" and "123" or strings like "123ABC" into "123" and "ABC".
1. `clc`: Clear your workspace.
1. `col_flatten` and `col_flattenLong`: Likely replacements for `listCol_l` and `listCol_w` from "splitstackshape".
1. `completeVecs`: Like `complete.cases()` but for vectors.
1. <s>`concat.split.DT`: Work in progress on an `fread()` approach to `concat.split()` from "splitstackshape".</s> Now part of "splitstackshape" (since V1.4.0 and above).
1. `Diag`: A faster version of `diag()`.
1. <s>`expandRows`: Expand the rows of a `data.frame` by a column in the `data.frame` or by a specified vector.</s> Now a part of "splitstackshape".
1. `Factor`: Enhanced version of `factor()` that allows duplicated `levels` to be used more directly.
1. `findFirst`: Finds the position of the n<sup>th</sup> non-sequential specified value in a vector.
1. `ftable2df`: Converts the output of `ftable()` to a `data.frame`.
1. `getMyRows`: Extracts a range of rows from a `data.frame`.
1. `GroupedMedian`: Calculates the median of grouped data.
1. `helpExtract`: Extracts portions of R help files for use in Sweave or R-markdown documents.
1. `letterRep`: Wraps the `letters` constant making unique values.
1. `makemeNA`: Converts specific values in a `data.frame` into `NA`.
1. `melt_wide`: Reshapes double- and tripple-wide `data.table`s into longer `data.frame`s.
1. `moveMe`: Shuffles the order of a vector around using natural language statements.
1. `naLast`: Moves `NA` values in columns or rows to the end of their columns or rows.
1. `needleInHaystack`: Finds a needle in a haystack.
1. `read.mtable`: Reads files that have multiple tables in one go.
1. `Riffle`: Like the `riffle` function from Mathematica, sort of.
1. `SampleToSum`: Samples from a specified range for a vector of a specified length adding up to a specified value.
1. `shifter`: "Shifts" values in a vector.
1. `shuffler`: Shuffles the elements of a vector such that no single element is in the same place it was before.
1. `sortEnds`: Selects the top-n highest or lowest values in a vector.
1. `TabulateInt`: Modifies tabulate to work with non-positive integers too.
1. `tidyHTML`: Downloads and parses a page after the page has been sent to the online HTML Tidy web service.
1. `toColClasses`: Converts `data.frame` columns to specified column classes.
1. `TriIndex`: Given the number of rows in a symmetric matrix, calculate the row and column indices of the upper or lower triangles.
1. `TrueSeq`: Convert the `TRUE` values in a vector into a sequence by groups of values.
1. `vec2symmat`: Converts a `vector` to a symmetric matrix (if possible).
1. `write.Hmisc.SPSS`: Writes SPSS files with label information (when using the Hmisc package).

Don't ask me why I did this.