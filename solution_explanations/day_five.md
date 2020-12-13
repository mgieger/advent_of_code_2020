# Binary Boarding

## Part 1
Given a list of strings representing boarding passes, calculate the maximum value of all boarding passes using the equation `row * 8 + col`.

### Solution
```mix day_five```

This solution uses a binary search to determine the boarding pass values. It takes the key to determine the row and column value and a range of the possible remaining values for the row or column being calcuted. Using recursion, the range can be narrowed down to the last value, which represents the row or column of that boarding pass.