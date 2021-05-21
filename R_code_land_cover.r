#R_code_land_cover.r

#Si richiamano le librerie di cui si ha bisogno:
library(raster)
#install.packages("RStoolbox") #classification
library(RStoolbox)
#install.packages("ggplot2")
library(ggplot2)
#install.packages("gridExtra")
library(gridExtra) #for grid arrange

#Si sceglie la cartella dove si andranno a leggere i dati
setwd("C:/lab/") # Windows

#b1=NIR, b2=red, b3= green
defor1 <-brick ("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")

defor2 <-brick ("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

# multiframe with ggplot2 and gridExtra
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2)

#1 IMMAGINE
#unsupervised classification--> classificazione non supervisionata
d1c <- unsuperClass(defor1, nClasses=2)
#per avere informazioni su quello che si è appena creato
d1c
#plottare dc1 insieme alla mappa
plot(d1c$map)
#dal plot esce fuori che la classe 1 indica la foresta tropicale 
#class 1: foresta
#classe 2: parte agricola

#2 IMMAGINE
#unsupervised classification--> classificazione non supervisionata
d2c <- unsuperClass(defor2, nClasses=2)
#per avere informazioni su dc2
d2c
#plottare dc1 insieme alla mappa
plot(d2c$map)
#classe 1: parte agricola
#classe 2: foresta

#Classificazione con 3 classi
d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)
#giallo parte residua di foresta
#la parte dell'agricola l'ha divisa in due classi 

#Si vuole calcolare la frequenza dei pixel di una certa classe per la prima immagine
freq(d1c$map)
#value  count
#[1,]     1 305616
#[2,]     2  35676

somma1 <- 305616 + 35676
somma1
#Per calcolare la proporzione
prop1 <- freq(d1c$map)/ somma1
prop1
#value     count
#[1,] 2.930042e-06 0.8954678 --> 89.54% di foresta
#[2,] 5.860085e-06 0.1045322 --> 10.45% di parte agricola

# Per fare la proporzione della seconda immagine si vedono le informazioni
defor2
# da cui esce fuori una somma di 342726
somma2 <-  342726
#Per calcolare la proporzione
prop2 <- freq(d2c$map)/ somma2
prop2
#value     count
#[1,] 2.917783e-06 0.4789861 --> 47.89% parte agricola
#[2,] 5.835565e-06 0.5210139 --> 52.10% foresta

#Si prosegue con il generare un dataframe
#Build a dataframe
cover <- c("Forest", "Agricolture")
percent_1992 <- c(89.54, 10.45)
percent_2006 <- c(52.10, 47.89)

percentages <- data.frame(cover, percent_1992, percent_2006 )
percentages
#cover percent_1992 percent_2006
#1      Forest        89.54        52.10
#2 Agricolture        10.45        47.89

#Si esegue un grafico con ggplot per il 1992, più precisamente il grafico a barre
#PRIMO PERIODO
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")

#plot del 2006
#SECONDO PERIODO
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

#Si associano i plot appena fatti ad un nome
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

#Funzione per assemblare più grafici su una pagina
grid.arrange(p1, p2, nrow=1)
