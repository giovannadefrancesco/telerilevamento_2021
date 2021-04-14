# R_code_copernicus.r
# Visualizing Copernicus data

# install.packages("raster")
library(raster)
# install.packages("ncdf4")
library(ncdf4)

#Si sceglie la cartella da dove si andranno a leggere i dati
setwd("C:/lab/") # Windows

#Si assegna un nome da dare al dataset a cui viene associato la funzione
#raster perchè si tratta di un singolo layer
albedo <-raster("c_gls_ALBH_202006130000_GLOBE_PROBAV_V1.5.1.nc")
#Si vedono tutte le informazioni del dataset
albedo

#Si assegnano dei colori
cl <- colorRampPalette(c('light blue','green','red','yellow'))(100) 
#Plot della variabile
plot(albedo, col=cl)


# resampling
#la funzione aggregate della variabile originale albedo con un certo fattore 100
#viene assegnata al nome albedores
albedores <- aggregate(albedo, fact=100)
# si diminuiscolo le informazioni di 10 000 volte
#Si esegue il plot
plot(albedores, col=cl)
