# @author: me@andreagirardi.it
# @since Sat Apr 10 13:52:20 CEST 2021
# @project: RExercises
# @module: COVID19
# @desc: 
# 
# https://www.r-graph-gallery.com/index.html
# 
#

# Load deployer 
library(dplyr)

# Load xlsx package
library(xlsx)

# Load ggplot value
library(ggplot2)
library(hrbrthemes)

# Global initialization
aggregateData <- NULL
municipality <- 'Minerbe'
fileName <- '20210228_Casi_per_COMUNE.xlsx'

#
# Extract data function
#
extractData <- function(fileName, aggregateData) {

    date <- gsub('.*data/ *(.*?) *_.*', '\\1', fileName)
    as.Date(date, format = '%Y%m%d') -> date

    daily <- read.xlsx(file = fileName, 1, startRow = 3, header = TRUE)
    rowMunicipality <- filter(daily, COMUNE == municipality) 

    if ( 'contatto.stretto' %in% colnames(rowMunicipality) ) {
        contattoStretto <- rowMunicipality$contatto.stretto
    } else {
        contattoStretto <- NA
    }

    if ( 'casi.positivi' %in% colnames(rowMunicipality) ) {
        casiPostivi <- rowMunicipality$casi.positivi
    } else {
        casiPostivi <- NA
    }

    if ( 'indagine.epid.' %in% colnames(rowMunicipality) ) {
        indEpidemiolgica <- rowMunicipality$indagine.epid.
    } else {
        indEpidemiolgica <- NA
    }

    if ( 'ricoverato' %in% colnames(rowMunicipality) ) {
        ricoverato <- rowMunicipality$ricoverato
    } else {
        ricoverato <- NA
    }

    if ( 'viaggiatori' %in% colnames(rowMunicipality) ) {
        viaggiatori <- rowMunicipality$viaggiatori
    } else {
        viaggiatori <- NA
    }

    if ( 'contatto.scolastico' %in% colnames(rowMunicipality) ) {
        scolastici <- rowMunicipality$contatto.scolastico
    } else {
        scolastici <- NA
    }

    if ( 'Totale.casi.Positivi.su..Popolazione.per.mille' %in% colnames(rowMunicipality) ) {
        positiviSuMille <- rowMunicipality$Totale.casi.Positivi.su..Popolazione.per.mille
        meanSuPopolazione <- mean(daily$Totale.casi.Positivi.su..Popolazione.per.mille, na.rm = TRUE)
        maxSuPopolazione <- max(daily$Totale.casi.Positivi.su..Popolazione.per.mille, na.rm = TRUE)
        interestingValues <- select(filter(daily, Totale.casi.Positivi.su..Popolazione.per.mille > 0), Totale.casi.Positivi.su..Popolazione.per.mille)
        minSuPopolazione <- min(interestingValues, na.rm = TRUE)
    } else {
        meanPopolazione <- NA
        maxSuPopolazione <- NA
        minSuPopolazione <- NA
    }

    rbind(aggregateData, data.frame(date, casiPostivi, contattoStretto, ricoverato, viaggiatori, scolastici, indEpidemiolgica, positiviSuMille, meanSuPopolazione, maxSuPopolazione, minSuPopolazione)) -> aggregateData

    return (aggregateData)

}

files <- list.files(path="data", pattern="*.xlsx", full.names=TRUE, recursive=FALSE)

for ( fileName in files ) {
    print (paste0('Extracting data from file: ', fileName))
    extractData(fileName, aggregateData) -> aggregateData
}

print ('############ ############### ############ ')
print ('############ AGGREGATED DATA ############ ')
print ('############ ############### ############ ')

write.csv(aggregateData,"aggregate.csv", row.names = FALSE)

# https://www.datanovia.com/en/blog/how-to-create-a-ggplot-with-multiple-lines/
# https://www.r-graph-gallery.com/279-plotting-time-series-with-ggplot2.html
# 
ggplot(aggregateData, aes(x = as.Date(date))) +
    scale_colour_manual(name='', values=c("Numero positivi" = "darkgray", "Positivi su 1000 abitanti" = "steelblue", "Positivi su 1000 abitanti (Provincia)" = "#69b3a2", "Contatti scolastici" = "coral2")) +
    geom_line(aes(y = casiPostivi, color="Numero positivi")) + 
    geom_point(aes(y = casiPostivi, color="Numero positivi"), shape=21, fill="#69b3a2", size = 2) + 
    # stat_smooth(aes(y = casiPostivi), method = "lm", formula = y ~ x + I(x^2) + I(x^3) + I(x^4) + I(x^5), se = FALSE, color = "lightred", size = 0.7) +   
    stat_smooth(aes(x = as.Date(date), y = casiPostivi), formula = y ~ x, inherit.aes = FALSE, se = FALSE, color = "darkorange2", size = 0.2) +
    # geom_smooth(aes(y = casiPostivi), method = "lm", formula = y ~ x + I(x^2) + I(x^3) + I(x^4) + I(x^5), color = "black", fill = "firebrick")  +
    # geom_line(aes(y = maxSuPopolazione, color="Max Positivi su 1000 abitanti (Provincia)")) +
    geom_line(aes(y = scolastici, color="Contatti scolastici")) +
    geom_line(aes(y = meanSuPopolazione, color="Positivi su 1000 abitanti (Provincia)")) +
    geom_line(aes(y = positiviSuMille, color = "Positivi su 1000 abitanti")) +
    scale_x_date(date_breaks = "4 day", date_labels = "%d-%m") +
    theme_ipsum(plot_margin = margin(30, 30, 30, 30)) +
    labs(x = "Linea temporale - Anno 2021", y = "Numero casi", title = "Evoluzione contagi COVID19", subtitle = "Comune di Minerbe", caption = "Data source: ULSS9 Scaligera") +
    theme(
        axis.text.x = element_text(angle=45, hjust=1, face=3, color="black"), 
        axis.text.y = element_text(color="black"), 
        # legend.position=c(-.8500,-.10), 
        legend.position='top', 
        legend.justification='left',
        legend.direction='horizontal',
        panel.background = element_rect(colour = "black", size = 0.2)        
    )


# Working - out of the script
# aggregateData <- read.xlsx(file = 'data/20210309_Casi_per_COMUNE.xlsx', 1, startRow = 3, header = TRUE)

# aggregateData <- read.csv(file = 'aggregate.csv') 


# Warning messages:
# 1: In simpleLoess(y, x, w, span, degree = degree, parametric = parametric,  :
#   pseudoinverse used at 898.05 447.96 297.93
# 2: In simpleLoess(y, x, w, span, degree = degree, parametric = parametric,  :
#   neighborhood radius 5.5422
# 3: In simpleLoess(y, x, w, span, degree = degree, parametric = parametric,  :
#   reciprocal condition number  5.6183e-16
# 4: In simpleLoess(y, x, w, span, degree = degree, parametric = parametric,  :
#   There are other near singularities as well. 21.741
# 5: In simpleLoess(y, x, w, span, degree = degree, parametric = parametric,  :
#   Chernobyl! trL>n 4.7371e+09
# 6: In simpleLoess(y, x, w, span, degree = degree, parametric = parametric,  :
#   Chernobyl! trL>n 4.7371e+09
# 7: In sqrt(sum.squares/one.delta) : Si è prodotto un NaN
