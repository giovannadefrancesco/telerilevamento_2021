e#Time series analysis: analisi di serie multitemporale di dati da satellite
#Greenland increase of temperature, ovvero il potenziale aumento di temperatura in Groenlandia 
#Data and code from Emanuela Cosma

# install.packages("raster")
library(raster)
# install.packages("rasterVis")
library(rasterVis)

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

#Si applica la funzione raster a tutta la lista e per importarli si è utilizzata la funzione lapply
import<-lapply(rlist,raster)
import

# Si procede con il costruire il pacchetto di file con la funzione stack
TGr<-stack(import)
plot(TGr)

#File dove ci sono i valori dei vari anni
plotRGB(TGr, 1, 2, 3, stretch="lin")
#nel livello Red, si mette il file 1 (2000), nel livello Green il file 2(2005) e nel livello Blue il file 3(2010)

plotRGB(TGr, 2, 3, 4 stretch="lin")
#nel livello Red, si mette il file 2 (2005), nel livello Green il file 3 (2010) e nel livello Blue il file 4(2015)

plotRGB(TGr, 4, 3, 2, stretch="lin")
#nel livello Red, si mette il file 4 (2015), nel livello Green il file 3 (2010) e nel livello Blue il file 2(2005)

#Questa funzione disegna grafici di livello e grafici di contorno.
levelplot(TGr)#grafico con tutte e 4 le mappe 
levelplot(TGr$lst_2000)#grafico con una singola mappa di come varia la temperatura nell'area in esame

#Per cambiare i colori per abbelire il plot
cl<- colorRampPalette(c("blue","light blue", "pink","red"))(100)
#Per cambiare il colore della mappa finale
levelplot(TGr, col.regions=cl)
#La differenza tra plot e levelplot è la compattezza, le coordinate sono messe solo su alcuni assi,
#la legenda è unica e i colori sono migliori

#Per cambiare i titoli delle immagini
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

# Si imposta come titolo generale la variazione del LST nel tempo
levelplot(TGr,col.regions=cl, main="LST variation in time",
          names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

# Melt, dati in riferimento allo scioglimento dei ghiacciai
#Si crea una lista 
meltlist <- list.files(pattern="melt")
#Si importano i file con la funzione lapplay
melt_import <- lapply(meltlist,raster)
#Si raggruppano tutti i file con la funzione stack, mettendoli tutti insieme
melt <- stack(melt_import)
#Per vedere informazioni più specifiche dei dati
melt

#Si esegue un level plot con i dati melt
levelplot(melt)
#Vengono rappresentati i valori di scioglimento dei ghiacci: più è alto 
#il valore maggiore sarà lo scioglimento.

#Si esegue la sottrazione tra il primo dato e il secondo a cui si associa un nome
#Per legare i due tipi di dati si mette il $
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt

#Si crea un'altra ColorRampPalette
clb <- colorRampPalette(c("blue","white","red"))(100)
#I colori + bassi sono in blu, i colori medi in bianco, i colori alti in rosso

#Si esegue prima un plot
plot(melt_amount, col=clb)

#e poi un level plot
levelplot(melt_amount, col.regions=clb)
 

