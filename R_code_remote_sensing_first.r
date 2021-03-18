# My first code in R for remote sensing
# Il mio primo codice in R per il telerilevamento!

# install.packages("raster")
library(raster)

#Per Windows
setwd("C:/lab/")

#Questa funzione serve ad importare un'immagine satellitare
#infatti, la funzione brick serve per importare tutto il pacchetto elle immagini satellitari
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011
#Questo comando serve per plottare le varie immagini
plot(p224r63_2011)

# B1: blue
# B2: green
# B3: red
# B4: NIR

#colour change
cl<-colorRampPalette(c("black","grey","light grey"))(100)
plot(p224r63_2011, col=cl)

#colour change -> new
cl<-colorRampPalette(c("blue","green","grey","red","magenta","yellow"))(100)
plot(p224r63_2011, col=cl)
