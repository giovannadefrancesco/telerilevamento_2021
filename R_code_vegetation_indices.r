#R code vegetation indices.r

library(raster)
library(RStoolbox) #for vegetation indices calculation
# install.packages("rasterdiv")
library(rasterdiv) # for the worldwide NDVI)
library(rasterVis)

#Si sceglie la cartella da dove si andranno a leggere i dati
setwd("C:/lab/") # Windows

defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

#b1=NIR, b2=red, b3= green

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#Per visualizzare le informazioni delle immagini
defor1
defor2

#Calcolare l'indice di vegetazione:
#PRIMA SITUAZIONE
#difference vegetation index
dvi1 <- defor1$defor1.1 - defor1$defor1.2
#questo plot evidenzia molto bene la differenza di vegetazione

#dev.off()
plot (dvi1)

# specifying a color scheme
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl, main="DVI at time 1")


#SECONDA SITUAZIONE
#difference vegetation index
dvi2 <- defor2$defor2.1 - defor2$defor2.2
#questo plot evidenzia molto bene la difference di vegetazione
plot (dvi2)

#Specifying a color scheme
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi2, col=cl, main="DVI at time 2")

par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

#Differenza dell'indice di vegetazione tra le 2 situazioni
difdvi <- dvi1 - dvi2
#dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)

#Calcolo di ndvi per le 2 situazioni:
#(NIR-RED)/ (NIR+RED)
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1, col=cl)

#Si può utilizzare anche un altro metodo:
#ndiv <- div1 / (defor1$defor1.1 + defor1$defor2.2 )
#plot (ndiv1, col=cl)

ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl)

# RStoolbox:spectralIndices
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot(vi1, col=cl)

vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)

difndvi <- ndvi1 - ndvi2
#dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difndvi, col=cld)

# worldwide NDI
plot(copNDVI)

#mappa dell'NDI a scala globale
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)

levelplot(copNDVI)
