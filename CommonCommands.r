
# DATA
# Return the list of all instralled data packages
> data() 

# Set folder
> setwd('BootcampWithR/MoneyBall')

# Info about R
> R.version

# dplyr command
# Select only columns x and y
> dplyr::select(df2, c(x, y))  

# Remove columns x and y
> dplyr::select(df2, -c(x, y))  

# Clear R environment
> ls()
# [1] "covidSource"       "covidSourceVeneto" "dataframe"        
# [4] "date21"            "date22"            "date23"           
# [7] "last"              "s"                 "x"      

> rm(list = ls())


## ggplot2
# Update the default plot dimensions to 12 x 6.
> options(repr.plot.width = 12, repr.plot.height = 6)

# Define a custom theme updating background and labels 
> theme_custom <- function(base_size, ...){
    ggplot2::theme_gray(base_size = base_size, ...) +
    ggplot2::theme(
        plot.title = element_text(face = 'bold'),
        plot.subtitle = element_text(color = '#333333'),
        panel.background = element_rect(fill = "#EBF4F7"),
        strip.background = element_rect(fill = "#33AACC"),
        legend.position = "bottom"
    )
}

> ggplot2::theme_set(theme_custom(base_size = 20))
> ggplot2::update_geom_defaults("line", list(size = 1.5))

# #### RANDOMIZATION #####
# Generates a vector of random normal variables with n 
> rnorm(3) 
> rnorm(10, mean=50, sd=.1)

# Reproduce same set of random numbers (needs to be called before rnorm())
> set.seed(100)
> rnorm(50)

# Generates 
