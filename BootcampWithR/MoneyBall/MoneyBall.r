# 
# Don't complain; just work harder! Dan Stanford
# 
# Our responsibility is to do what we can, learn what we can, improve the solutions, and pass them on. RF
# 
# @author: me@andreagirardi.it
# @since: Wed Jan 22 17:29:30 CET 2020
# @project: RExercises
# @module: ggplot2 samples
# @desc: 
#
# @prerequisite
#   install.packages('ggplot2')
#   library(ggplot2)
#   library(ggthemes)
#   mtcars

> library(ggplot2)
> library(dplyr) 

# Import data
> setwd('BootcampWithR/MoneyBall')
> batting <- read.csv('Batting.csv')
> salaries <- read.csv('Salaries.csv')

# Use head() to check out the batting
> head(batting)

# Use str() to check the structure.
> str(batting)

# Call the head() of the first five rows of AB (At Bats) column
> head(batting[,'AB'])

# Call the head of the doubles (X2B) column
> head(batting[,'X2B'])

# ### Feature Engineering ###

# Create a new column called BA and add it to our data frame with Batting Average (Hits / AtBat)
> batting$BA <- batting$H / batting$AB

# Check the last 5 entries of the BA column of your data frame and it should look like this
> tail(batting$BA,5)

# Select TOP 100 
> select(batting, playerID, yearID, H, AB, BA) %>% filter(BA > 0 & BA < 1) %>% arrange(desc(BA)) %>% head(100) 

# onBase percentage (H + BB + HBP) / (AB + BB + HBP + SF)
> batting$OBP <- (batting$H + batting$BB + batting$HBP) / (batting$AB + batting$BB + batting$HBP + batting$SF)

# Select TOP 5 
> select(batting, playerID, yearID, H, AB, BA, OBP) %>% filter(OBP > 0 & OBP < 1) %>% arrange(desc(OBP)) %>% head(5) 

# Create X1B (Singles)
# Subtracting doubles,triples, and home runs from total hits (H): 1B = H-2B-3B-HR
> batting$X1B <- (batting$H - batting$X2B - batting$X3B - batting$HR)

# Create Slugging Average (SLG) : Slugging percentage represents the total number of bases a player records per at-bat.
# Forumula:  (1B + 2Bx2 + 3Bx3 + HRx4)/AB
> batting$SLG <- (batting$X1B + ( batting$X2B * 2) + ( batting$X3B * 3) + (batting$HR * 4) ) / batting$AB

# Select TOP 5 
> select(batting, playerID, yearID, H, AB, BA, OBP, SLG) %>% filter(SLG > 0 & SLG < 1) %>% arrange(desc(SLG)) %>% head(5) 

# Merging Salary Data with Batting Data
> select(salaries, playerID, teamID, year, salary) %>% arrange(desc(salary)) %>% head(5) 
