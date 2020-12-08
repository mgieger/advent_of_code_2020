# Passport Processing

## Part 1
Given a list of passports in a format like this:

ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in

Count the number of valid passports.
A passport is valid if it contains these seven fields:
- byr (Birth Year)
- iyr (Issue Year)
- eyr (Expiration Year)
- hgt (Height)
- hcl (Hair Color)
- ecl (Eye Color)
- pid (Passport ID)

Optional fields:
- cid (Country ID)

### Solution
```mix day_four```

The first problem to solve is getting each passport into one row so we can then process the passports. Splitting the data input on `\n\n` ensures we have a list of values where each value is all of the information for one passport. Replacing the remaining `\n` characters merges all the passport information into one row.

