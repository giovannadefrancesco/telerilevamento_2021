#R code vegetation indices.r

library(raster)

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
plot(dvi2, col=cl, main="DVI at time 1")





