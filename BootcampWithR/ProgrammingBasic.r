# 
# Don't complain; just work harder! Dan Stanford
# 
# Our responsibility is to do what we can, learn what we can, improve the solutions, and pass them on. RF
# 
# @author: me@andreagirardi.it
# @since: Wed Jan 15 18:34:22 CET 2020
# @project: RExercises
# @module: Programming basic lesson
# @desc: 
#
#
# Exercises

## 
#### Standard deviation and Geometric mean
## 

print ('#### Standard deviation and Geometric mean ####')
temps <- c(32, 32, 31, 28, 29, 31, 39, 32, 32, 35, 26, 29)

mean <- mean(temps)
num_items <- length(temps)
squared_differences <- rep(0, num_items)
products <- 1
index <- 1
geometric_mean <- 0

for ( temp in temps ) {
    products <- products * temp
    geometric_mean <- products ^ (1. / num_items)
    squared_differences[index] <- (temp - mean) ^ 2
    index <- index + 1
}

# Calculate VARIANCE
average_squared_difference <- mean(squared_differences)

# Calculate standard deviation
standard_deviation <- sqrt(average_squared_difference)

paste0 ('mean:                  ', mean)
paste0 ('variance:              ', average_squared_difference)
paste0 ('standard_deviation:    ', standard_deviation)
paste0 ('geometric mean:        ', geometric_mean)