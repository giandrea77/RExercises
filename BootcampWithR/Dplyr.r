# 
# Don't complain; just work harder! Dan Stanford
# 
# Our responsibility is to do what we can, learn what we can, improve the solutions, and pass them on. RF
# 
# @author: me@andreagirardi.it
# @since: Wed Jan 22 17:29:30 CET 2020
# @project: RExercises
# @module: Dplyr lesson
# @desc: Perform the following operations using only the dplyr library. We will be reviewing the following operations:
#   filter() (and slice())
#   arrange()
#   select() (and rename())
#   distinct()
#   mutate() (and transmute())
#   summarise()
#   sample_n() and sample_frac()
#
# @prerequisite
#   library(dplyr)
#   mtcars

# Exercises

# Return rows of cars that have an mpg value greater than 20 and 6 cylinders.
> filter(mtcars, mpg > 20, cyl == 6)
   mpg cyl disp  hp drat    wt  qsec vs am gear carb
1 21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
2 21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
3 21.4   6  258 110 3.08 3.215 19.44  1  0    3    1

# Reorder the Data Frame by cyl first, then by descending wt.
> head(arrange(mtcars, cyl, desc(wt)))
   mpg cyl  disp  hp drat    wt  qsec vs am gear carb
1 24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
2 22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
3 21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
4 21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
5 22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
6 32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1

# Select the columns mpg and hp
> head(select(mtcars, mpg, hp))
                   mpg  hp
Mazda RX4         21.0 110
Mazda RX4 Wag     21.0 110
Datsun 710        22.8  93
Hornet 4 Drive    21.4 110
Hornet Sportabout 18.7 175
Valiant           18.1 105

# Select the distinct values of the gear column.
> distinct(select(mtcars, gear))
  gear
1    4
2    3
3    5

# Create a new column called "Performance" which is calculated by hp divided by wt.
> head(mutate(mtcars, Performance = hp / wt))
   mpg cyl disp  hp drat    wt  qsec vs am gear carb Performance
1 21.0   6  160 110 3.90 2.620 16.46  0  1    4    4    41.98473
2 21.0   6  160 110 3.90 2.875 17.02  0  1    4    4    38.26087
3 22.8   4  108  93 3.85 2.320 18.61  1  1    4    1    40.08621
4 21.4   6  258 110 3.08 3.215 19.44  1  0    3    1    34.21462
5 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2    50.87209
6 18.1   6  225 105 2.76 3.460 20.22  1  0    3    1    30.34682

# Find the mean mpg value using dplyr.
> summarise(mtcars, avg_mpg = mean(mpg))
   avg_mpg
1 20.09062

> mtcars %>% filter(cyl == 6) %>% summarise(avg_hp = mean(hp))
    avg_hp
1 122.2857

# Use pipe operators to get the mean hp value for cars with 6 cylinders.
> mtcars %>% filter(cyl == 6) %>% summarise(avg_mpg = mean(hp))
   avg_mpg
1 122.2857