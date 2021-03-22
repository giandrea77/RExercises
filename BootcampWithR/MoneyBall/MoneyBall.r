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
> select(salaries, playerID, teamID, yearID, salary) %>% arrange(desc(salary)) %>% head(5) 

# reassign batting to only contain data from 1985 and onwards
> salaries <- subset(salaries, yearID >= 1985)
> batting <- subset(batting, yearID >= 1985)

# Merge the batting and sal data frames by c('playerID','yearID')
> combo <- merge(batting, salaries, by = c('playerID', 'yearID'))

# Analyzing the Lost Players
# Use the subset() function to get a data frame called lost_players from the combo data frame consisting of those 3 players. 
# Hint: Try to figure out how to use %in% to avoid a bunch of or statements!
> lostPlayer <- subset(combo, playerID %in% c('giambja01', 'saenzol01', 'damonjo01'))

# Use subset again to only grab the rows where the yearID was 2001.
> lostPlayer <- subset(lostPlayer, yearID %in% c('2001'))
> lostPlayer <- select(lostPlayer, playerID, H, X2B, X3B, HR, OBP, SLG, BA, AB)

# Altenrnative
# lostPlayer <- lostPlayer[, c('playerID', 'H', 'X2B', 'X3B', 'HR', 'OBP', 'SLG', 'BA', 'AB')]

# Replacement Players
# Find Replacement Players for the key three players we lost! However, you have three constraints:
# The total combined salary of the three players can not exceed 15 million dollars.
# Their combined number of At Bats (AB) needs to be equal to or greater than the lost players.
# Their mean OBP had to equal to or greater than the mean OBP of the lost players
# Use the combo dataframe you previously created as the source of information! Remember to just use the 2001 subset of that dataframe. 
# There's lost of different ways you can do this, so be creative! It should be relatively simple to find 3 players that satisfy the requirements, 
# note that there are many correct combinations available!
#
# Requirements:
#       1469 AB         486 each
#       AVG 0.365 OBP
#       15 millions
#
#        playerID   H X2B X3B HR       OBP       SLG        BA  AB
# 5141  damonjo01 165  34   4  9 0.3235294 0.3633540 0.2562112 644
# 7878  giambja01 178  47   2 38 0.4769001 0.6596154 0.3423077 520
# 20114 saenzol01  67  21   1  9 0.2911765 0.3836066 0.2196721 305
#
> combo <- subset(combo, yearID == '2001')

> ggplot(combo, aes(x=OBP, y=salary)) + geom_point(size = 10)

# Remove not relevalt or too high payrol (i.e. peopble went on base 0% or 100%)
> combo <- subset(combo, salary < 8000000 & OBP > 0)
> combo <- subset(combo, AB >= 450)

# Find replace players
> select(combo, playerID, OBP, AB) %>% arrange(desc(OBP)) %>% head(10) 