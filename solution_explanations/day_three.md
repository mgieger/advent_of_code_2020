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
