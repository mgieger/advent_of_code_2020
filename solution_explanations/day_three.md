# Toboggan Trajectory

## Part 1
Given a repeating sequence in the format: 
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#

From your starting position at the top-left, check the position that is right 3 and down 1. Then, check the position that is right 3 and down 1 from there, and so on until you go past the bottom of the map.

Count the number of "#" spaces you would land on. 

### Solution
```mix day_three```

The first row is removed since we know our beginning index and tree count are 0 and 0. Then a reduce function with a two element tuple accumulator is used to maintain track of the index and tree count.

## Part 2
Given a set of coordinates representing different starting points, traverse the map and count the number of trees encountered.

### Solution
```mix day_three --part-two```

This solution adds a second header function to ```toboggan_run``` for when then "down" value is greater than one. In this situation, the extra rows which are skipped over in the "down" movement are removed from the data using ```Utils.DataParser.keep_every/3```. This allows for the same implementation of ```determine_spot_and_increment_count/2``` to be used to calculate the number of trees. 