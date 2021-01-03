# Handheld Halting
```mix day_eight```

## Part 1
```mix day_eight --part-one```

Given a list of instructions representing commands, execute the commands until a command will be executed a second time.

### Solution
Put the commands into a list and add a `visited` flag to each command to determine if a command is about to be executed a second time. Use a recursive function `execute_command` with multiple function headers determine the operation and what should be modified. The base / stopping case is when an operation's `visited` flag is `true`.

## Part 2
```mix day_eight --part-two```

### Solution
Create a list of command sequences, where each command sequence is the initial sequence of commands but with one "nop" <-> "jmp". This list is then iterated over using `reduce_while` to stop execution when either the last command sequence in the list is run, or when the command sequence runs the last command in a command sequence (the part two stopping condition).

## Note 
It would be nice to reduce the number of arguments to `execute_command`. In particular, it would be nice to not need to pass in the list accumulator. Even better would be to not need a list accumulator at all. This would require changing the return `{:cont, [cmnd_value | acc]}` to `{:cont, acc}` and then ignoring the accumulator value on the next sequence iteration, effectively resetting the accumulator to 0 for each set of commands. This would allow both part one and part two to return one accumulated value which would be the correct value.