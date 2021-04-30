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
# library(ggplot2)
# library(hrbrthemes)

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

    print (paste0(date,' - meanSuPopolazione: ', meanSuPopolazione, ' maxSuPopolazione: ', maxSuPopolazione))

    rbind(aggregateData, data.frame(date, casiPostivi, contattoStretto, ricoverato, viaggiatori, scolastici, indEpidemiolgica, positiviSuMille, meanSuPopolazione, maxSuPopolazione, minSuPopolazione)) -> aggregateData

    return (aggregateData)

}

files <- list.files(path="data", pattern="*.xlsx", full.names=TRUE, recursive=FALSE)

for ( fileName in files ) {
    # print (paste0('Extracting data from file: ', fileName))
    extractData(fileName, aggregateData) -> aggregateData
}

print ('############ ####################### ############ ')
print ('############ WRITING AGGREGATED DATA ############ ')
print ('############ ####################### ############ ')

write.csv(aggregateData,"aggregate.csv", row.names = FALSE)


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
