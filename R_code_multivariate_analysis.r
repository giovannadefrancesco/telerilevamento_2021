#R_code_multivariate_analysis.r

library(raster) #Viene caricato il pacchetto raster.
library(RStoolbox) #Viene caricato il pacchetto RStoolbox.

#Si sceglie la cartella da dove si andranno a leggere i dati. Serve per impostare 
#la cartella di lavoro, nella quale verranno salvati/cercati di default i file.
setwd("C:/lab/") # Windows

#Si procede caricando l'immagine con tutte e 7 le bande tramite 
#la funzione "brick" che serve per caricare direttamente un pacchetto di dati, a 
#cui viene associato un nome (p224r63_2011):
p224r63_2011 <-brick("p224r63_2011_masked.grd")
#Per vedere le informazioni delle immagini:
p224r63_2011
#Si plotta l'immagine da cui vengono fuori le 7 bande:
plot(p224r63_2011)

#Le varie bande di LANDSAT sono distribuite in questo modo:
# B1: blu (blue) 
# B2: verde (green)
# B3: rosso (red)
# B4: NIR,  infrarosso vicino
# B5: infrarosso medio 
# B6: infrarosso termico o lontano 
# B7: infrarosso medio 

#Si plottano i valori della banda 1 (blu) contro i valori della banda 2 del verde
#in questo modo:
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)
#Per mettere in evidenza il plot si utilizza il rosso, il "pch" si intende il 
#simbolo che si vuole utilizzare e "cex" indica la dimensione del parametro grafico
#che si è scelto.

#Dal grafico si vede che le 2 bande sono molto correlate, in statistica
#viene chiamata multicollinearità: l'informazione di un punto è molto simile 
#all'informazione dello stesso punto in un'altra banda.

#Invertendo le bande sulla x e sulla y, ovvero banda 2 nella x e banda 1 nella y
#si ha lo stesso plot però si sono invertite le due bande:
plot(p224r63_2011$B2_sre, p224r63_2011$B1_sre, col="red", pch=19, cex=2)

#Per plottare tutte le correlazioni possibili fra tutte le variabili del dataset 
#si utilizza la funzione "pairs":
pairs(p224r63_2011)
#Dai vari plot, nella parte alta della diagonale dove sono tutte le bande esce 
#un indice, sottoforma di numero, chiamato di correlazione di Pearson che varia
#tra -1 e 1. Se si è positivamente correlati in modo perfetto questo indice va a 1, 
#se invece si è negativamente correlabili (all'aumentare di uno diminuisce l'altro)
#l'indice va a meno 1.

#La PCA è un'analisi piuttosto impattante, ovvero ci vuole molto tempo per portarla
#a termine, quindi un modo più semplice sarebbe quello di ricampionare il dato.
#Per ridurre la dimensione dell'immagine diminuendo la sua risoluzione, si utilizza 
#la funzione "aggregate". 
#RESAMPLING-->ricampionamento:
p224r63_2011res <- aggregate(p224r63_2011, fact=10)
#Per vedere le informazioni riguardanti la diminuzione si utilizza un fattore di 
#ricampionamento (ovvero quante volte si vuole diminuire la risoluzione oppure 
#quante volte si vuole aumentare la grandezza del pixel) pari a 10.
#Il pixel non sarà più di 30m ma di 300m -->aumentare la grandezza del pixel 
#significa diminuire la risoluzione. Maggiore è il dettaglio, più fitta è la risoluzione.
p224r63_2011res

#Per plottare le due immagini e metterle a confronto si utilizza il comando par:
par(mfrow=c(2,1))
#Si plotta con RGB l'immagine 30x30 pixel (si riporta l'immagine originale (p224r63_2011),
#alla componente rossa si mette la banda dell'infrarosso, a quella verde si mette
#il rosso e su quella blu si imposta la verde. Infine, si aggiunge un stretch lineare.
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
#Si fa la stessa cosa con l'immagine 300x300 pixel, la quale è più sgranata.
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

#La funzione PCA ("Principal Components Analysis) consiste nel prendere i 
#dati originali e si passa un asse lungo la variabilità maggiore e l'altro asse
#lungo la variabilità minore.
#La "rasterPCA"-->prende il pacchetto di dati e va a compattarli in un numero 
#minore di bande.
#Alla funzione "rasterPCA" si fa seguire l'immagine che si è appena ricampionata
#e la si associa ad un nuovo nome/oggetto (p224r63_2011res_pca).
p224r63_2011res_pca <-rasterPCA(p224r63_2011res)

#La funzione "summay" ci dà un sommario del modello. Alla funzine "summary", si fa 
#seguire il nome di quello che si è appena generato e lo si lega con il simbolo 
#del dollaro al modello.
summary(p224r63_2011res_pca$model)
#Importance of components:
#                          Comp.1      Comp.2       Comp.3       Comp.4       Comp.5       Comp.6       Comp.7
#Standard deviation     1.2050671 0.046154880 0.0151509516 4.575220e-03 1.841357e-03 1.233374e-03 7.595367e-04
#Proportion of Variance 0.9983595 0.001464535 0.0001578135 1.439091e-05 2.330990e-06 1.045814e-06 3.966085e-07
#Cumulative Proportion  0.9983595 0.999824022 0.9999818357 9.999962e-01 9.999986e-01 9.999996e-01 1.000000e+00

#Questo risultato afferma che la PC1 spiega il 99,83% della variabilità del sistema.
#Mentre con tutte le bande si arriverà al 100%. 

#Si esegue il plot dell'immagine (p224r63_2011res_pca) legata alla mappa.
plot(p224r63_2011res_pca$map)
#Da questo plot si ottiene che la prima componente ha tanta deformazione
#quindi, con tanta variabilità mentre l'ultima componente ha il residuo.
#Il PC1 ha tutte le informazioni: si vede bene la foresta, la parte agricola;
#la PC7 non si distingue più nulla.
#SINTESI: La prima componente è quella che spiega più variabilità.

#Si hanno tutte le informazioni:
p224r63_2011res_pca
#$call
#rasterPCA(img = p224r63_2011res)

#$model
#Call:
#princomp(cor = spca, covmat = covMat[[1]])
#Standard deviations:
#      Comp.1       Comp.2       Comp.3       Comp.4       Comp.5       Comp.6       Comp.7 
#1.2050671362 0.0461548802 0.0151509516 0.0045752199 0.0018413569 0.0012333745 0.0007595367 
#7  variables and  41233 observations.

#$map
#class      : RasterBrick 
#dimensions : 150, 297, 44550, 7  (nrow, ncol, ncell, nlayers)
#resolution : 300, 300  (x, y)
#extent     : 579765, 668865, -522735, -477735  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
#source     : memory
#names      :         PC1,         PC2,         PC3,         PC4,         PC5,         PC6,         PC7 
#min values : -1.96808463, -0.30213565, -0.07212306, -0.02976086, -0.02695826, -0.01712903, -0.00744772 
#max values : 6.065280099, 0.142898206, 0.114509980, 0.056825410, 0.008628344, 0.010537390, 0.005594290 
dev.off()#funzione che serve per chiudere la finestra precedente.

#Si esegue un plotRGB con le prime 3 componenti principali:
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")
#immagine con tutte e 3 le componenti.
#Questa è l'immagine finale derivante da un'analisi della componente principale (PC1).

#Per plottare una singola componente, nel senso che si è plottata la prima PC1 
#contro la PC2 per vedere se fossero correlate tra loro e si nota che non c'è 
#nessuna correlazione. 
plot(p224r63_2011res_pca$map$PC1, p224r63_2011res_pca$map$PC2)

#Per vedere tutti i blocchi del file e quali informazioni possono dare sulla 
#struttura informatica del file si utilizza il comando "str":
str(p224r63_2011res_pca)
