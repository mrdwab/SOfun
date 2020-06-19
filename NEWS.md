# SOfun 1.76

Added `list_reduction` function.

# SOfun 1.75

Not really sure whether this package warrants a NEWS section, so maybe I'll just use this for any major changes.

## Functions that have disappeared

Sometimes functoins disappear for a good reason. Here are some that have gone missing.

1. <s>`appendMe`: Like `rbind()` but adds the source in the process.</s> Just use `rbindlist` from "data.table" with the `idcol` argument instead. Much better....
1. <s>`concat.split.DT`: Work in progress on an `fread()` approach to `concat.split()` from "splitstackshape".</s> Now part of "splitstackshape" (since V1.4.0 and above). 
1. <s>`expandRows`: Expand the rows of a `data.frame` by a column in the `data.frame` or by a specified vector.</s> Now a part of "splitstackshape".

## Functions that aren't really missing

1. [<s>`ftable2df`</s> `ftable2dt`](../reference/ftable2dt.html): Converts the output of `ftable()` to a `data.table`. *NOTE: Changed from `data.frame` to `data.table`.*