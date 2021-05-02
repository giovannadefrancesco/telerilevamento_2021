# R_code_classification.r

#Le librerie che ci servono:
library(raster)
library(RStoolbox)

#Si sceglie la cartella da dove si andranno a leggere i dati
setwd("C:/lab/") # Windows

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


#dev.off()

#Gran Canyon
#https://landsat.visibleearth.nasa.gov/view.php?id=80948
#When John Wesley Powell led an expedition down the Colorado River and through the Grand Canyon in 1869, he was confronted with a daunting landscape. 
#At its highest point, the serpentine gorge plunged 1,829 meters (6,000 feet) from rim to river bottom, making it one of the deepest canyons in the United States.
#In just 6 million years, water had carved through rock layers that collectively represented more than 2 billion years of geological history, nearly half of the 
#time Earth has existed.

#Le librerie che ci servono:
library(raster)
library(RStoolbox)

#Si sceglie la cartella da dove si andranno a leggere i dati
setwd("C:/lab/") # Windows

#Si procede con il caricare l'immagine assegnadola ad un nome
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
#per visualizzare l'immagine
plotRGB(gc, r=1, g=2, b=3, stretch="lin")
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

# Si utlizza la funzione unsuperClass per classificare
gcc2 <- unsuperClass(gc, nClasses=2)
#per vedere le informazioni
gcc2
#per vedere il plot dell'immagine
plot(gcc2$map)

#Si aggiunge il numero delle classi
gcc4 <- unsuperClass(gc, nClasses=4)
#per vedere le informazioni
gcc4
#per vedere il plot dell'immagine
plot(gcc4$map)


