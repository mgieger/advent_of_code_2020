# Custom Customs

## Part 1
Given a list of groups of custom forms determine the unique number of questions which each group answered 'yes'.

### Solution
```mix day_six```

First the input file is split into groups by splitting on `\n\n`, this puts each group into one element of a list. Then removing the `\n` characters within each group condenses all the group responses to one line. Each line can be turned into a list and the unique values of each line can be counted. Returning the sum of these counts is the answer.

## Part 2
Only count the 'yes' responses if all of the members of a group respond 'yes' to a question.

### Solution
```mix day_six --part-two```

Using Map sets for each respondant per group, the individual graphemes (questions) can be intersected to determine all questions for which all group respondants responded 'yes'. The main difference with this solution is the way the input data is parsed. Splitting on `\n` and then chunking by `""` allows for each group to be separated into lists while also removing all of the `\n` characters in all of the group member's responses.

## Note
Another way I would like to come back and solve this section with would be to separate each groups responses. Then per group: 
* Get a count of the number of members per group
* Use a map to count the frequency of each character's appearance (using `Enum.frequencies`)
* Count the number of characters whose frequency for a group is equal to the number of group members
Then sum these values.