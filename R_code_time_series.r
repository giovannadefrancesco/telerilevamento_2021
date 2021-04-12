#Time series analysis: analisi di serie multitemporale di dati da satellite
#Greenland increase of temperature, ovvero il potenziale aumento di temperatura in Groenlandia 
#Data and code from Emanuela Cosma

# install.packages("raster")
library(raster)

setwd("C:/lab/greenland") # Windows

#raster-->la funzione per caricare singoli dati, quindi singoli "strati" e NON un pacchetto di "strati"

#PRIMA IMMAGINE
#Si assegna la funzione raster all'oggetto lst_2000.tif, a sua volta si assegna un nome
lst_2000 <- raster ("lst_2000.tif")
#Viene plottata la prima immagine
plot(lst_2000)

#SECONDA IMMAGINE
lst_2005 <- raster ("lst_2005.tif")
#Viene plottata la seconda immagine
plot(lst_2005)

#maggiore sarà il digital number, maggiore sarà il valore di temperatura 

#TERZA IMMAGINE
lst_2010 <- raster ("lst_2010.tif")
#Viene plottata la prima immagine
plot(lst_2010)

#QUARTA IMMAGINE
lst_2015 <- raster ("lst_2015.tif")
#Viene plottata la prima immagine
plot(lst_2015)

dev.off()
#Si crea un multi-pannel con le 4 immagini 
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#Metodo per importare tutte le immaginin insieme
#lapplay: si può applicare una certa funzione a una lista di file
#Si procede creando una lista tramite la funzione list.files
#list of files
rlist <- list.files(pattern="lst") #pattern sarebbe la parte in comune
rlist

#Si applica la funzione raster a tutta la lista tramite lapply
import<-lapply(rlist,raster)
import

# Si procede con il costruire il pacchetto di file con la funzione stack
TGr<-stack(import)
plot(TGr)




