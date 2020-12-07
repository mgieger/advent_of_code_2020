# Password Philosophy

## Part 1
Given a list of values in the format ```1-3 a: abcde``` find the number of valid passwords. 

Each line gives the password policy and then the password. The password policy indicates the lowest and highest number of times a given letter must appear for the password to be valid. For example, 1-3 a means that the password must contain a at least 1 time and at most 3 times.

### Solution
```mix day_three```

## Part 2
Each policy actually describes two positions in the password, where 1 means the first character, 2 means the second character, and so on. (Be careful; Toboggan Corporate Policies have no concept of "index zero"!) Exactly one of these positions must contain the given letter. Other occurrences of the letter are irrelevant for the purposes of policy enforcement.

### Solution
```mix day_three --part-two```
