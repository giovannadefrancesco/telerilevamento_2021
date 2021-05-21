# R_code_variability.r

# Si caricano le librerie di cui si ha bisogno
library(raster)
library(RStoolbox)

# Si sceglie la cartella dove si andranno a leggere i dati
setwd("C:/lab/") # Windows

# Viene importata l'immagine a cui si assegna un nome 
sent <- brick("sentinel.png")

# Sapendo che: NIR 1, RED 2, GREEN 3
# Si plotta l'immagine con tre livelli di default: r=1, g=2, b=3
plotRGB(sent, stretch="lin")
# pltRGB (sent, r=1, g=2, b=3, stretch="lin")

# Si plotta l'immagine con tre livelli
plotRGB(sent, r=2, g=1, b=3, stretch="lin")
# Tutta la roccia (calcare) è in fucsia mentre la vegetazione è 
#in verde fluorescente, l'acqua è rappresentata in nero

# Bisogna trovare come si chiamano le bande dell'immagine sentinel
# Per vedere le informazioni dell'immagine 
sent
# Banda numero 1 è il near infra-red
nir <- sent$sentinel.1
# Banda numero 2 è il red
red <- sent$sentinel.2

# Per fare il calcolo del ndvi 
ndvi <- (nir-red) / (nir+red)
# Per plottare il calcolo appena eseguito
plot(ndvi)

# Per cambiare i colori si utilizza una colorRampPalette
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100)
plot(ndvi,col=cl)
 
# Per calcolare la variabilità di questa immagine , quindi la deviazione standard  
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(ndvisd3)
