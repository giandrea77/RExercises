# @author: me@andreagirardi.it
# @since Sat May  8 10:29:42 CEST 2021
# @project: RExercises
# @module: COVID19
# @desc: 
# 
# https://www.r-graph-gallery.com/index.html
# 
#

install.packages("pdftools")
library(pdftools)
data <- pdf_text("data/20210501_Vaccinati_x_Comune.pdf")