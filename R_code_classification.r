# R_code_classification.r

#Si sceglie la cartella da dove si andranno a leggere i dati
setwd("C:/lab/") # Windows

#La libreria che ci serve
library(raster)
library(RStoolbox)
#La funzione brick crea un oggetto RasterBrick, il quale è un è un oggetto raster multistrato.
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

#Per vedere i livelli
so

#Per visualizzare i vari livelli si utilizza seguito dal nome dell'immagine
plotRGB(so, 1, 2, 3, stretch="lin")
# Si vede un livello dove le esplosioni sono maggiori (a destra), un livello intermedio 
#e un livello più basso scuro a sinistra.

#UnsuperClass classification
soc <- unsuperClass(so, nClasses=3)
plot(soc$map)

# Unsupervised Classification with 20 classes
soe <- unsuperClass(so, nClasses=20)
cl <- colorRampPalette(c('blue','red','green'))(100)
plot(soe$map)


# Download an image from:
# https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
sun <- brick("sun.png")

# Unsupervised classification
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map)
