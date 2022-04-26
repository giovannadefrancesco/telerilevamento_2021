#R_code_NO2.r

#Si richiamano i pacchetti da installare e le librerie di cui si ha bisogno:
#install.packages("raster") #Viene installato il pacchetto raster.
library(raster) #Viene caricato il pacchetto raster. 

#install.packages("RStoolbox") #Viene installato il pacchetto RStoolbox per 
#l'analisi multivariata.
library(RStoolbox)#Viene caricato il pacchetto RStoolbox

#1.Set the working directory EN.
#Si sceglie la cartella da dove si andranno a leggere i dati. Serve per impostare 
#la cartella di lavoro, nella quale verranno salvati/cercati di default i file.
setwd("C:/lab/EN") # Windows

#2.Import the first image (single band)
#We will select band 1, but the raster function enables to select other single-band

#Visto che siamo interessati a caricare una sola banda si utilizzerà la 
#funzione raster che ha bisogno dell'installazione del pacchetto a cui appartiene: 
EN01<- raster("EN_0001.png")

#3.Plot the first importaed image with your preferred ColorRampPalette
#Si crea una ColorRampPalette:
cls<-colorRampPalette(c("red","pink","orange","yellow"))(200)
#Si esegue il plot:
plot(EN01, col=cls)
#Dal plot esce fuori che dove ci sono le zone in giallo significa che in Gennaio
#si aveva una presenza di N02 alto.

#4.Import the last (13th) and plot it with the previous ColorrampPalette:
#Si importa la tredicesima immagine e viene plottata con la precedente 
#ColorRampPalette:
EN0013<- raster("EN_0013.png")
cls<-colorRampPalette(c("red","pink","orange","yellow"))(200)
plot(EN0013, col=cls)
#Dal plot si nota che a da i primi di Gennaio alla fine di Marzo, la situazione
#è migliorata.

#5.Make the difference between the two images and plot it.
#Si esegue la differenza fra le due immagini, la si associa ad un oggetto e infine 
#viene plottata:
#Marzo VS Gennaio 
ENdif1<-EN0013-EN01
plot(ENdif1, col=cls)
#In questo caso si è eseguita una differenza tra marzo che ha valori bassi e gennaio 
#che invece aveva valori più alti.

#E' possibile fare anche il contrario:
#Gennaio VS Marzo
ENdif2<-EN01-EN0013
plot(ENdif2, col=cls)
#Dove ci sono differenze più forti di diminuzione tra gennaio e marzo, il colore
#tende ad essere più giallo.

#6.Plot everything, altogether
#Si passa a plottare tutte e tre le immagini che si sono prodotte:
#Tramite il comando "par" le immagini vengono posizionate in 3 righe e una singola colonna:
par(mfrow=c(3,1))
plot(EN01, col=cls, main="NO2 in January") #si aggiunge il titolo
plot(EN0013, col=cls, main="NO2 in March")
plot(ENdif1, col=cls, main="Difference (March-January)")

#7.Import the whole set
#Si vuole importare tutto il set di immagini (13) insieme:
#Per prima cosa si costruisce una lista dei files:
rlist <-list.files(pattern = "EN") #nel senso tutte le immgini hanno in comune "EN".
#Per vedere le informazioni di questa lista appena creata:
rlist

#A questo punto si applica la funzione raster tramite la funzione "lapply" a tutta 
#la lista che si è realizzata e la si associa a un oggetto:
import <-lapply(rlist,raster)
#Si vedono le informazioni di questo nuovo oggetto
import
#vengono visualizzati a video tutti i singoli layer importati.

#A questo punto è possibile fare uno "stack" di tutti questi layer:
EN <- stack(import)
#e infine si esegue il plot:
plot(EN, col=cls) #si utilizza sempre il colore della ColorRampPalette scelta in 
                  #precedenza.
#Per vedere le informazioni di EN
EN

#8. Replicate the plot of images 1 and 13.
#Si esegue la replica del plot dell'immagine 1 e 13:
par(mfrow=c(2,1))
plot(EN$EN_0001, col=cls) 
plot(EN$EN_0013, col=cls) 
#Si tratta dello stesso meccanismo che si è fatto precedentemente però, mettendo
#le due immagini prese direttamente dallo "stack" e non dall'importazione
#iniziale.

#9. Compute a PCA over the 13 images.
#Si esegue un'analisi multivariata di questo set.
#Si ha un set composto da 13 bande e lo si diminuisce facendo una PCA:
#Si esegue la PCA:
ENpca <- rasterPCA(EN)
#il summary:
summary(ENpca$model)
#Importance of components:
# Comp.1      Comp.2      Comp.3      Comp.4      Comp.5     Comp.6      Comp.7
#Standard deviation     163.5712335 38.08295072 31.80383638 30.29988935 25.16267825 23.7453996 21.33981833
#Proportion of Variance   0.8142581  0.04413767  0.03078274  0.02794025  0.01926912  0.0171596  0.01385893
#Cumulative Proportion    0.8142581  0.85839573  0.88917847  0.91711872  0.93638784  0.9535474  0.96740637
#Comp.8       Comp.9      Comp.10      Comp.11    Comp.12     Comp.13
#Standard deviation     18.70124275 17.213091323 12.202732705 10.813131729 9.86088656 7.867219452
#Proportion of Variance  0.01064361  0.009017081  0.004531713  0.003558371 0.00295924 0.001883609
#Cumulative Proportion   0.97804999  0.987067068  0.991598781  0.995157151 0.99811639 1.000000000

dev.off()
#e infine il plotRGB:
plotRGB(ENpca$map, r=1,g=2,b=3, stretch="lin") #si utilizza uno strech lineare.
#Tutto quello che appare rosso sarebbe quello che si è mantenuto piuttosto stabile 
#nel tempo.

#Dal "summary" si vedono le varie componenti e si nota che con la pirma si 
#ha tutta la varianza del sistema.

#10. Compute the local variability (local standard deviation) of the first PCA. 
#Si esegue un calcolo della variabilità sulla prima componente della PCA.
#Si esegue un calcolo della standard deviation sulla prima componente:
PC1sd <- focal(ENpca$map$PC1, w=matrix(1/9, nrow=3, ncol=3), fun=sd) #fun=sd-->deviazione standard
#Dato che ENpca$PC1 non è esattamente una mappa, in quanto PC1 è dentro il Raster
#Brick che a sua volta è ENpca$map.

#Si esegue il plot:
plot(PC1sd, col=cls)
