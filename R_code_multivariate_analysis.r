#R_code_multivariate_analysis.r

library(raster)
library(RStoolbox)

setwd("C:/lab/") # Windows

#Si procede caricando l'immagine con tutte e 7 le bande tramite la funzione brick
p224r63_2011 <-brick("p224r63_2011_masked.grd")
#Per vedere le informazioni delle immagini
p224r63_2011
#Per plottare le diverse bande 
plot(c)

#Si plottano i valori della banda blu contro i valori della banda 2 
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)
#dal grafico si vede che le 2 bande sono molto correlate, in statistica viene chiamata multicollinearità: l'informazione di un punto è molto simile 
#all'informazione dello stesso punto in un'altra banda.

#Invertendo le bande sulla x e sulla y, ovvero banda 2 nella x e banda 1 nella y, si ha lo stesso plot però si sono invertite le due bande
plot(p224r63_2011$B2_sre, p224r63_2011$B1_sre, col="red", pch=19, cex=2)

#Per plottare tutte le correlazioni possibili fra tutte le variabili del dataset si utilizza la funzione "pairs"
pairs(p224r63_2011)

