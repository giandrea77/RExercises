# @author: me@andreagirardi.it
# @since: Wed Mar 24 14:46:09 CET 2021
# @project: RExercises
# @module: COVID19
# @desc: 
# 
# R(t) : The number of people who become infected per infectious person at time 𝑡
#
# Install package COVID19
# https://cran.r-project.org/web/packages/COVID19/COVID19.pdf

# Dati positiv per provincia: https://github.com/pcm-dpc/COVID-19/tree/master/dati-province

> install.packages('COVID19')

> library('dplyr')
> library('CODID19')

# Select all data for Veneto region
# RAW = false (add NA in case of missing data, this won't generate a wrong chart)
> covidSource <- covid19('Italy', level=3, start="2020-11-01", raw = FALSE)

> covidSourceVeneto <- select(covidSource, id, date, population, school_closing, vaccines, tests, confirmed, deaths, hosp, administrative_area_level_1, administrative_area_level_2, administrative_area_level_3) %>% filter(administrative_area_level_2 == 'Veneto') 
> g <- ggplot(covidSourceVeneto, aes(x = covidSourceVeneto$date) ) + geom_line(aes(y = covidSourceVeneto$confirmed), color = "red") + geom_line(aes(y = covidSourceVeneto$hosp), color = "green") + geom_line(aes(y = covidSourceVeneto$deaths), color = "blue")

> covidSourceVerona <- select(covidSource, id, date, confirmed, deaths, hosp, administrative_area_level_3, administrative_area_level_2) %>% filter(administrative_area_level_3 == 'Verona') 
> ggplot(covidSourceVerona, aes(x = date)) + geom_line(aes(y = confirmed), color = "blue") + geom_line(aes(y = deaths), color = "red")

### Altro data source ####
> date21 <- read.csv(url('https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-province/dpc-covid19-ita-province-20210322.csv'))
> date22 <- read.csv(url('https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-province/dpc-covid19-ita-province-20210322.csv'))
> date23 <- read.csv(url('https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-province/dpc-covid19-ita-province-20210323.csv'))

> dataframe <- rbind(date21, date22, date23)
> select(dataframe, data, sigla_provincia, totale_casi) %>% filter(sigla_provincia == 'VR')

# How to Calcualte R(t)
# https://github.com/k-sys/covid-19/blob/master/Realtime%20R0.ipynb
# https://www.scienzainrete.it/articolo/metodo-lo-studio-dellandamento-provinciale-dellepidemia/roberto-battiston/2021-02-03
# Tutorial : https://www.datacamp.com/community/tutorials/replicating-in-r-covid19 
# 