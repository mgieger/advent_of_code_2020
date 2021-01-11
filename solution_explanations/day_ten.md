# Adapter Array
```mix day_ten``` 

## Part 1
```mix day_ten --part-one``` 

### Solution
Sorting the list of adapters gets the order in which they will be linked. Then this list can be used to create two lists: one with a 0 added as the first element (the starting effective joltage rating), and the second list with an element of +3 value greater than the last element added at the end (the device joltage).

The difference between corresponding elements will return the difference in joltage between each adapter. These values can be obtained by zipping the lists together, and subtracting the smaller value from the larger value. 
