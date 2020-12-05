# Report Repair

Given a report containing a list of values, find the two values whose sum equals 2020


## Solutions
I've generated two solutions to this problem which perform a different number of comparisons. 

Both solutions read in the data file, convert the file data into a list of integers, and use a tail recursive function to search the data. 

### Brute force
```mix report_repair --brute-force```

Max number of comparisons: 40000 (n^2)

This solution performs searches through the data space by comparing each element against all other elements in the data until a match is found. This is much like a nested for loop solution which would be more commonly used in a non-functional programming language.

### Bucket Comparisons
```mix report_repair```

Number of comparisons: ~4020 (with a uniform distribution of values)

This solution first separates the data into ten buckets, where each bucket contains all values with the same digit in the 'ones' place (value modulo 10). We then can reduce the search space by comparing each bucket to only one other bucket. This reduction is possible because we know that two numbers sum should equal 2020. This means there are only six groupings by the 'ones' digit that can sum to 2020. These groupings 'ones' digits must add up to 0 or 10 in order for the sum 'ones' digit to be 0.

Numbers ending in:
0 - sum with other numbers ending in 0

1 - sum with other numbers ending in 9

2 - sum with other numbers ending in 8

3 - sum with other numbers ending in 7

4 - sum with other numbers ending in 6

5 - sum with other numbers ending in 5

The `generate_and_fill_buckets` function uses a setup similar to that of a Radix sort to create, partition, and fill the buckets with data. (But it stops there and does not sort the data and leaves the buckets of data intact.)