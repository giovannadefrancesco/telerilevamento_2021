#DAY 1
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

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

#colour change
cl<-colorRampPalette(c("black","grey","light grey"))(100)
plot(p224r63_2011, col=cl)

##DAY 2
#colour change -> new
cl<-colorRampPalette(c("blue","green","grey","red","magenta","yellow"))(100)
plot(p224r63_2011, col=cl)

cl <- colorRampPalette(c("red","pink","orange","purple"))(200)
plot(p224r63_2011, col=cl)

###DAY 3

#dev.off will clean the current graph
dev.off()
plot(p224r63_2011$B1_sre, col=cl)

cl <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot(p224r63_2011$B1_sre, col=cl)

dev.off()
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#1 row, 2 colums
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#2 row, 1 columns
par(mfrow=c(2,1)) #if you are using colums first: (mfocol...)
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#plot the first four bands of Landsat
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)


# a quadrat of bands...:
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

# a quadrat of bands...:
par(mfrow=c(2,2))

clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c("dark red","red","pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)

clnir <- colorRampPalette(c("red","orange","yellow")) (100)
plot(p224r63_2011$B4_sre, col=clnir)

####DAY 4
#Visualizing data by RGB plotting
library(raster)
setwd("C:/lab/")

p224r63_2011 <- brick("p224r63_2011_masked.grd")
# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

#RGB--> Red, Blue, Green, rappresentano i colori primari da cui escono gli altri

plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#mount a 2X2 multiframe
pdf("il_mio_primo_pdf.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") #stretch lineare
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

#par natural colours, flase colour and false colours with histogram stret
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

#####DAY 5
#Multitemporal set
# 1988 image
# p224r63_1988_masked
p224r63_1988 <- brick("p224r63_1988_masked.grd")
p224r63_1988 #serve per vedere le informazioni riguardanti l'immagine del 1988
plot(p224r63_1988) #plotta le singole bande dell'immagine
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
dev.off()


pdf("multitemp.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
dev.off()




