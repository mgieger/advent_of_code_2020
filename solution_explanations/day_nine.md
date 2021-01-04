# Encoding Error
```mix day_nine``` to run both parts.

## Part 1
```mix day_nine --part-one``` 

### Solution
Use `Enum.chunk_every/4` to separate the input data into lists of 25 (designated sequence length) and zip these lists with the input data (dropping the sequence length) becomes a list of tuples `{[numbers], next_index}`. Using a slightly modified version of `find_value/3` from the Day One puzzle will allow the target value to be obtained.

## Part 2
```mix day_nine --part-two```

### Solution
Use recursive function `find_value` to create consecutive value sequences from the input data and determine if the sequence sums to the target value.
