

# Set folder
> setwd('BootcampWithR/MoneyBall')

# Info about R
> R.version

# dplyr command
# Select only columns x and y
$ dplyr::select(df2, c(x, y))  

# Remove columns x and y
$ dplyr::select(df2, -c(x, y))  

# Clear R environment
$ ls()
# [1] "covidSource"       "covidSourceVeneto" "dataframe"        
# [4] "date21"            "date22"            "date23"           
# [7] "last"              "s"                 "x"      

$ rm(list = ls())