#R code vegetation indices.r

library(raster)
library(RStoolbox) # for vegetation indices calculation
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

#PRIMA SITUAZIONE
#difference vegetation index
dvi1 <- defor1$defor1.1 - defor1$defor1.2
#questo plot evidenzia molto bene la difference di vegetazione
plot (dvi1)

dev.off()
# specifying a color scheme
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl, main="DVI at time 1")


#SECONDA SITUAZIONE
#difference vegetation index
dvi2 <- defor2$defor2.1 - defor2$defor2.2
#questo plot evidenzia molto bene la difference di vegetazione
plot (dvi2)

# specifying a color scheme
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi2, col=cl, main="DVI at time 2")

par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

difdvi <- dvi1 - dvi2
#dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld)

#ndvi
#(NIR-RED)/ (NIR+RED)
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1, col=cl)

#Si può utilizzare anche un ltro metodo
#ndiv <- div1 / (defor1$defor1.1 + defor1$defor2.2 )
#plot (ndiv2, col=cl)

# RStoolbox::spectralIndices
vi <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot(vi, col=cl)


vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)

difndvi <- ndvi1 - ndvi2
# dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difndvi, col=cld)




