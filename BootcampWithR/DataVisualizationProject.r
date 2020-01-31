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
> library(ggthemes)

# Import data
df <- read.csv('BootcampWithR/Economist_Assignment_Data.csv', sep=',')

print(head(df))

# Use ggplot() + geom_point() to create a scatter plot object called pl. You will need to specify x=CPI and y=HDI and color=Region as aesthetics
> pl <- ggplot(df, aes(x = CPI, y = HDI, color = Region)) + geom_point(shape = 1, size = 4)

# We want to further edit this trend line. Add the following arguments to geom_smooth (outside of aes):
#
# Smoothing method (function) to use, accepts either a character vector, e.g. "auto", "lm", "glm", "gam", "loess" or a function, e.g. MASS::rlm or mgcv::gam, stats::lm, or stats::loess.
# method = 'lm'
#
# Formula to use in smoothing function, eg. y ~ x, y ~ poly(x, 2), y ~ log(x)
# formula = y ~ log(x)
#
# Display confidence interval around smooth? (TRUE by default, see level to control.)
# se = FALSE 
#
# color = 'red'
pl2 <- pl + geom_smooth(formula = y ~ log(x), color = "red", method = "lm", se = FALSE)

# Add labels
> p2 + geom_text(aes(label=Country))

> pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                "India", "Italy", "China", "South Africa", "Spane",
                "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                "New Zealand", "Singapore")

> pl3 <- pl2 + geom_text(aes(label = Country), color = "gray20", data = subset(df, df$Country %in% pointsToLabel), check_overlap=TRUE)              

# Change theme
> pl4 <- pl3 + theme_bw() 

# Add scale_x_continuous()
> pl5 <- pl4 + scale_x_continuous(name = "Corruption Perception Index, 2011 (10 = least corrupt)", limits = c(.9, 10.5), breaks=1:10)

# Add scale_y_continous()
> pl6 <- pl5 + scale_y_continuous(name = "Human Development Index, 2011 (1=Best)", limits = c(0.2, 1.0))

# Add graphic title 
# To center: theme(plot.title = element_text(hjust = 0.5))
> pl7 <- pl6 + ggtitle(label = "Corruption and Human development") + theme_economist_white() + theme(plot.title = element_text(hjust = 0.5))