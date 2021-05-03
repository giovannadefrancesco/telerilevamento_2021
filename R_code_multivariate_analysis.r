#R_code_multivariate_analysis.r

library(raster)
library(RStoolbox)

setwd("C:/lab/") # Windows

#Si procede caricando l'immagine con tutte e 7 le bande tramite la funzione brick che serve per caricare direttamente un pacchetto di dati
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

#per ridurre la dimensione dell'immagine diminuendo la sua risoluzione si utilizza la funzione aggregate. Resampling-->ricampionamento
p224r63_2011res <- aggregate(p224r63_2011, fact=10)

#Per vedere le informazioni riguardanti la diminuzione di un fattore 10 il pixel non sarà più di 30m ma di 300m. 
#Aumentare la grandezza del pixel significa diminuire la risoluzione, maggiore è il dettaglio, più fitta è la risoluzione
p224r63_2011res

#per plottare le due immagini e metterle a confronto
par(mfrow=c(2,1))
#immagine 30x30 pixel
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
#immagine 300x300 pixel ed è la più sgranata 
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

#La funzione per fare la PCA ("Principal Components Analysis)che consiste nel prendono i  dati originali e passiamo in asse lungo 
#la variabilità maggiore e l'altro asse lungo la variabilità minore, è rasterPCA-->prende il pacchetto di dati e va a compattarli in un numero minore di bande
p224r63_2011res_pca <-rasterPCA(p224r63_2011res)

#La funzione summay ci dà un sommario del modello 
summary(p224r63_2011res_pca$model)

plot(p224r63_2011res_pca$map)
#da questo plot si ottiene che la prima componente ha tanta deformazione, quindi tanta variabilità mentre l'ultima componente ha il residuo.

#dev.off()
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")
#immagine con tutte e 3 le componenti

#per plottare una singola componente
plot(p224r63_2011res_pca$map$PC1, p224r63_2011res_pca$map$PC2)

#per vedere tutti i blocchi del file e quali informazioni possono dare sulla struttura informatica del file
str(p224r63_2011res_pca)

