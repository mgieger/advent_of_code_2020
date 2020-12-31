# Handheld Halting
```mix day_eight```

## Part 1
Given a list of instructions representing commands, execute the commands until a command will be executed a second time.

## Solution
Put the commands into a list and add a `visited` flag to each command to determine if a command is about to be executed a second time. Use a recursive function `execute_command` with multiple function headers determine the operation and what should be modified. The base / stopping case is when an operation's `visited` flag is `true`.