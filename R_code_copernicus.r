#R_code_Copernicus.r
#Visualizing Copernicus data

#install.packages("raster") #serve per installare il pacchetto raster.
library(raster) #Viene caricato il pacchetto raster, non vengono messe le virgolette 
                #perchè è già in R.

#install.packages("ncdf4") #serve per installare il pacchetto ncdf4 ed è la 
#libreria per leggere netCDF, si tratta di un formato di dati.
library(ncdf4) #Viene caricato il pacchetto ncdf4, non vengono messe le virgolette 
               #perchè è già in R.

#Si sceglie la cartella da dove si andranno a leggere i dati.Servirà per impostare 
#la cartella di lavoro, nella quale verranno salvati/cercati di default i file.      
setwd("C:/lab/") # Windows

#Si assegna un nome da dare al dataset a cui viene associato la funzione
#raster perchè si tratta di un singolo layer.
albedo <-raster("c_gls_ALBH_202006130000_GLOBE_PROBAV_V1.5.1.nc")

#Si vedono tutte le informazioni del dataset:
albedo

#Si assegnano dei colori tramite un ColorRamPalette
cl <- colorRampPalette(c('light blue','green','red','yellow'))(100) 
#Plot della variabile albedo
plot(albedo, col=cl)
#Dal plot si nota che la zona rossa è dove viene riflessa più energia solare
#(ovviamente la parte dei deserti è quella che riflette di più, in qunato il 
#suolo è tutto esposto).

#Fase di RESAMPLING (ricampionamento):
#Questo dato è possibile ricampionarlo, ovvero diminuire la risoluzione con dei 
#pixel un pò più grandi. E' un metodo che viene adottato per velocizzare i tempi 
#di test di alcune analisi.
#Questo è possibile farlo utilizzando la funzione "aggregate" della variabile originale
#albedo con un certo fattore di ricampionamento (100), la quale poi viene assegnata 
#al nome albedores.
albedores <- aggregate(albedo, fact=100)
#si è utilizzato un fattore 100, quindi un accorpamento di 10 000 volte il dato 
#originale, avendo così dei file in uscita molto più grezzi.

#Si esegue il plot con i colori precedenti:
plot(albedores, col=cl)
