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

# Per cambiare i colori si utilizza un'altra colorRampPalette
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd3, col=clsd)
# dove si hanno colori tendenti al rosso e al giallo si ha una deviazione standard più alta
# verde e blu un pò più bassa ed è presente nelle zone più omogenee dove c'è la roccia nuda
# mentre aumenta, quindi è più verde, nelle zone dove si passa da roccia nuda alla parte
# vegetata, poi la deviazione standard ritorna ad essere omogenea su tutte le parti vegetate

# Per calcolare la MEDIA della biomassa
# mean ndvi with focal
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvimean3, col=clsd)
# valori molto alti per la parte semi naturale (boschi, coniferi e latifoglie)
# valori più bassi per quanto riguarda la roccia nuda

# Per cambiare la grandezza della griglia (per farla divenare 13x13)
ndvisd13 <- focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(ndvisd13, col=clsd)

# Per cambiare la grandezza della griglia (per farla divenare 5x5)
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(ndvisd5, col=clsd

# La funzione rasterPCA calcola la PCA in modalità R e restituisce un RasterBrick
# con più livelli di punteggi PCA  
sentpca <- rasterPCA(sent)
plot(sentpca$map)
  
# Summary del modello 
summary(sentpca$model)
# Importance of components: 
#                          Comp.1     Comp.2     Comp.3    Comp.4
# Standard deviation     77.3362848 53.5145531 5.765599616      0
# Proportion of Variance  0.6736804  0.3225753 0.003744348      0
# Cumulative Proportion   0.6736804  0.9962557 1.000000000      1

# The first PCA contains explains 67.36804 % of the original information
