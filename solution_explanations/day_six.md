# Custom Customs

## Part 1
Given a list of groups of custom forms determine the unique number of questions which each group answered 'yes'.

### Solution
```mix day_six```

First the input file is split into groups by splitting on `\n\n`, this puts each group into one element of a list. Then removing the `\n` characters within each group condenses all the group responses to one line. Each line can be turned into a list and the unique values of each line can be counted. Returning the sum of these counts is the answer.