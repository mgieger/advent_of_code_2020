# Binary Boarding

## Part 1
Given a list of strings representing boarding passes, calculate the maximum value of all boarding passes using the equation `row * 8 + col`.

### Solution
```mix day_five```

This solution uses a binary search to determine the boarding pass values. It takes the key to determine the row and column value and a range of the possible remaining values for the row or column being calcuted. Using recursion, the range can be narrowed down to the last value, which represents the row or column of that boarding pass.

## Part 2

### Solution
```mix day_five --part-two```

This solution adds a function header for ```find_your_seat_id/2``` to find the user's seat id. This function takes the list of all of the boarding ids, sorts them, and converts the list into a list of `{value, index}` tuples. 

The missing seat id is found by dropping all of the elements from the list whose value is equal to one less than the next element of the list. The first tuple to not be dropped will be the seat id before the user's id (since the problem states the seat -1 and +1 are present on the plane). 

Adding 1 to the value of the seat id before the user's will return the correct seat id.