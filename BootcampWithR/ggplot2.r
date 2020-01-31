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


# Histogram of hwy mpg values - histogram is frequency count so, on aes, one single value is passed
> ggplot(mpg, aes(x = hwy)) + geom_histogram(fill ="red", alpha = 0.5, bins = 30)

# Barplot of car counts per manufacturer with color fill defined by cyl count
# NOTE: X axis is not a continous variable, it is a discrete one meanings we have different groups of manufacturer
> ggplot(mpg, aes(x = mpg$manufacturer)) + geom_bar(aes(fill=factor(mpg$cyl)))

# Create a scatterplot of volume versus sales. Afterwards play around with alpha and color arguments to clarify information.
> head(txhousing)
> ggplot(txhousing, aes(x = txhousing$sales, y=txhousing$volume)) + geom_point(color = "blue", alpha = 0.5)

# Add a smooth fit line to the scatterplot from above. Hint: You may need to look up geom_smooth()
> ggplot(txhousing, aes(x = txhousing$sales, y=txhousing$volume)) + geom_point(color = "blue", alpha = 0.5) + geom_smooth(color = "red")