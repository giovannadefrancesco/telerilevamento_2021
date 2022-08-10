#R code vegetation indices.r

library(raster) #Viene caricato il pacchetto raster.
library(RStoolbox) #Viene caricato il pacchetto RStoolbox per calcolare l'indice 
                   #di vegetazione.

#install.packages("rasterdiv") #serve per installare il pacchetto rasterdiv.
library(rasterdiv) #Viene caricato il pacchetto rasterdiv per l'NDVI mondiale.
library(rasterVis) #Viene caricato il pacchetto rasterVis.

#Si sceglie la cartella da dove si andranno a leggere i dati. Serve per impostare 
#la cartella di lavoro, nella quale verranno salvati/cercati di default i file.
setwd("C:/lab/") # Windows

#Si utilizza la funzione "brick" che serve a caricare un pacco di dati.
#Prima immagine:
defor1 <- brick("defor1.jpg")
#Seconda immagine:
defor2 <- brick("defor2.jpg")

#Le bande sono divise in questo modo:
#B1=NIR,infrarosso vicino;
#B2=red;
#B3=green.

#Vengono plottate le immagini con plotRGB e vengono disposte tramite la funzione
#"par" su due righe e 1 colonna:
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin") #si utilizza uno strech lineare
plotRGB(defor2, r=1, g=2, b=3, stretch="lin") #si utilizza uno strech lineare
#Rispetto alla prima immagine, nella seconda immagine si vede che in questa
#zona c'è stato un considerevole impatto dell'agricoltura.
#Inoltre si nota che il fiume nell'imagine sopra aveva molti più solidi disciolti
#e quindi il colore appare molto diverso rispetto a quella di sotto, dove molto
#probabilmente in quel momento aveva meno solidi disciolti.

#Per visualizzare le informazioni delle immagini:
defor1
defor2

#Calcolo dell'indice di vegetazione:
#PRIMA SITUAZIONE
#difference vegetation index
#Per calcolare questo indice bisogna fare la differenza tra il near infrared 
#della defor1, (ovvero defor1.1 ) meno il red della defor1 (defor1.2).
dvi1 <- defor1$defor1.1 - defor1$defor1.2
dev.off() #per togliere la disposizione del par precedente.

#Questo plot evidenzia molto bene quanta e in che stato di salute è la vegetazione:
plot (dvi1)
#Tutta la parte del fiume e dei primi punti agricoli sono molto chiare, tendenti 
#al giallino/marronicio mentre tutta la parte della vegetazone della Foresta
#Amazzonica è molto verde.

#Specifying a color scheme
#Si sceglie una nuova colorRampPalette per rendere ancora meglio l'idea di questo
#indice di vegetazione.
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
#Si effettua il plot:
plot(dvi1, col=cl, main="DVI at time 1") #"main" serve per aggiungere il titolo al plot.
#Tutto quello che è rosso fortissimo è vegetazione mentre tutto quello che è 
#giallo sono le coltivazioni.

#SECONDA SITUAZIONE
#difference vegetation index
#Si fa la stessa cosa ma per DVI2:
dvi2 <- defor2$defor2.1 - defor2$defor2.2
#Il plot evidenzia molto bene la differenza di vegetazione
plot (dvi2)

#Specifying a color scheme
#Si sceglie una nuova colorRampPalette per rendere ancora meglio l'idea di questo
#indice di vegetazione.
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
#Si effettua il plot:
plot(dvi2, col=cl, main="DVI at time 2")
#La parte gialla indica la parte in cui NON c'è più vegetazione, quindi i campi coltivati
#mentre il rosso indica ciò che rimane della foresta.

#Tramite la funzione par si mettono a confronto gli ultimi due plot (dvi1 e dvi2):
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

#Si effettua una differenza dell'indice di vegetazione fra i 2 DVI:
difdvi <- dvi1 - dvi2
dev.off() #per togliere la disposizione del par precedente

#Si sceglie una nuova colorRampPalette:
cld <- colorRampPalette(c('blue','white','red'))(100)
#Si effettua il plot:
plot(difdvi, col=cld)
#Dove si hanno valori di differenza più alti, si ha il colore rosso mentre dove
#la differenza è più bassa si hanno le parti bianche e le parti celesti. 
#La restituzione di questa mappa dice quali sono i punti dove c'è stata una 
#"sofferenza", si intende la deforestazione da parte della vegetazione nel tempo.

#Calcolo di NDVI, ovvero si normalizza dvi, per le 2 situazioni:
#NDVI1=(NIR-RED)/(NIR+RED), con NDVI si possono paragonare immagini che hanno
#risoluzione radiometrica diversa in entrata, cioè qualsiasi tipo di immagine.
#Il range del NDVI varia tra -1 e 1.

#Calcolo del NDVI1:
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
#Si effettua il plot:
plot(ndvi1, col=cl)

#Si può utilizzare anche un altro metodo:
#ndiv <- div1 / (defor1$defor1.1 + defor1$defor2.2)
#plot (ndiv1, col=cl)

#Calcolo del NDVI2 con lo stesso procedimento di prima:
ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
#Si effettua il plot:
plot(ndvi2, col=cl)
#Dal plot si nota che le zone più chiare c'è stata una perdita di vegetazione.

#Per fare in modo che si effettuino questi calcoli in modo più speditivo, è
#possibile utilizzare nel pacchetto RStoolbox una funzione che si chiama 
#"spectralIndices" che calcola direttamente diversi indici, come appunto NDVI oppure 
#il SAVI che riguarda i suoli etc.

#RStoolbox:spectralIndices che si imposta in questo modo e si esegue per entrambe
#le immagini: defor1 e defor2.
#PRIMA IMMAGINE (defor1):
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
#Si effettua il plot:
plot(vi1, col=cl)

#SECONDA IMMAGINE (defor2):
vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
#Si effettua il plot:
plot(vi2, col=cl)

#Si effettua una differenza dell'indice di vegetazione fra i 2 NDVI:
difndvi <- ndvi1 - ndvi2
#Si sceglie una nuova colorRampPalette:
cld <- colorRampPalette(c('blue','white','red'))(100)
#Si effettua il plot:
plot(difndvi, col=cld)
#Con il rosso si hanno le aree dove c'è stata maggior perdita di vegetazione.

#Worldwide NDVI-->NDVI mondiale
plot(copNDVI)
#In questo plot è presente anche l'acqua (rappresentata in celeste), quindi bisogna 
#trovare il modo di toglierla. A tal proposito esiste una funzione per cambiare
#dei valori in altri valori e si chiama "reclassify" che serve a trasformare i 
#pixels con i valori 253,254 e 255 (acqua) in non valori. 
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
#Si effettua il plot:
plot(copNDVI)
#Si nota che all'equatore, nella parte del Nord Europa e nel Nord America si ha 
#NDVI più alto mentre è più basso in corrispondenza dei deserti. 

#La funzione "levelplot" serve per vedere la media dei valori sulle righe e sulle 
#colonne e si trova all'interno del pacchetto "rasterVis".
levelplot(copNDVI) 
#Questo plot è una rappresentazione dei valori medi di come respira la terra dal 
#1999 al 2017: i valori più alti sono quelli della foresta amazzonica, delle foreste
#del centro Africa, del Nord Europa, del Nord Asia e del Nord America.
#Tutto il resto è molto basso come valore e si trovano dove si hanno i deserti 
#e le grandi distese di neve.
