# 
# Don't complain; just work harder! Dan Stanford
# 
# Our responsibility is to do what we can, learn what we can, improve the solutions, and pass them on. RF
# 
# @author: me@andreagirardi.it
# @since: Sat Jan 25 19:36:21 CET 2020
# @project: RExercises
# @module: ggplot2 samples
# @desc: 
#
# @prerequisite
#   library(ggplot)
#   mtcars

> install.package('dplyr')
> library(dplyr)

> install.packages("devtools")
> library(devtools)
> install_github("quantide/mapIT")

> df2015 <-read.csv(file = 'ElezReg2015/veneto.csv', header=TRUE, sep=';')
> df2015_verona <- filter(df2015, CIRCREGIONALE == 'VERONA')
> df2015_verona_zaia <- select(filter(df2015, CIRCREGIONALE == 'VERONA', LISTACIRC %in% c('LEGA NORD','ZAIA')), COMUNE, COGNOME, NOME, PREFERENZE)

> filter(df2015_verona_lnlz, COMUNE == 'MINERBE')
> valbusa <- filter(df2015_verona_lnlz, COGNOME == 'VALBUSA')

# Compare two candidates
> compare <- select(filter(df2015_verona_lnlz, COGNOME %in% c('MONTAGNOLI', 'VALBUSA')), COGNOME, COMUNE, PREFERENZE)

> ggplot(compare, aes(x = PREFERENZE, group = COMUNE, fill = COMUNE)) + geom_histogram()