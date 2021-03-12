# My first code in R for remote sensing
# Il mio primo codice in R per il telerilevamento!

# install.packages("raster")
library(raster)

#Per Windows
setwd("C:/lab/")

p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)
