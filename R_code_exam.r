# Esame di telerilevamento 2022

# Area di studio: Lago Powell
# Tema di studio: Abbassamento del livello di acqua nel Lago Powell dal 2017 al 2021
# Fonti immagini: Landsat 8
# Data immagini: 1 settembre 2017 - 27 Agosto 2021
 
# A cavallo del confine tra il sud-est dello Utah e il nord-est dell'Arizona, 
# il lago Powell è il secondo bacino idrico per capacità degli Stati Uniti. 
# Le immagini osservate da Landsat 8 a colori naturali mostrano il lago Powell 
# alla fine dell'estate del 2017 e del 2021.
# L'immagine del settembre 2017 è stata scelta perché rappresenta il livello 
# d'acqua più alto dell'ultimo decennio. 

# Si richiamano i pacchetti da installare e le librerie di cui si ha bisogno:
# install.packages("raster") # Viene installato il pacchetto raster.
library(raster) # Viene caricato il pacchetto raster.

# install.packages("RStoolbox") # Viene installato il pacchetto RStoolbox per 
                                # eseguire la classificazione.
library(RStoolbox) # Viene caricato il pacchetto RStoolbox

# install.packages("ggplot2") #Viene installato il pacchetto ggplot2.
library(ggplot2) # Viene caricato il pacchetto ggplot2.

# install.packages("gridExtra") #Viene installato il pacchetto gridExtra.
library(gridExtra) # Viene caricato il pacchetto gridExtra per la disposizione 
                   # della griglia.

#install.packages("viridis") #Viene installato il pacchetto gridExtra.
library(viridis) # Viene caricato il pacchetto raster.

# install.packages("rgdal") #Viene installato il pacchetto rgdal.
library(rgdal) # Viene caricato il pacchetto rgdal

# Si sceglie la cartella da dove si andranno a leggere i dati. 
# Serve per impostare la cartella di lavoro, nella quale verranno salvati/cercati
# di default i file.
setwd("C:/Lago_Powell")

###############################  2017 VS 2021  ################################
# Passaggi per il codice
# Carico con la funzione "brick" l'intero set di bande riferito all'immagine del 
# Lago Powell del 2017 creando un RasterBrick (blocco di diversi raster messi tutti 
# insieme) e lo assegno ad un nome:
powell2017 <- brick("lakepowell_2017.jpg")

# Eseguo la stessa cosa con l'immagine del lago Powell del 2021:
powell2021 <- brick("lakepowell_2021.jpg")

# Per avere informazioni sulla variabile del 2017:
powell2017
# Si osserva che le bande presenti nel RasterBrick sono divise in questo modo:
# lakepowell_2017.1,          lakepowell_2017.2,         lakepowell_2017.3 
#       [NIR],                      [red],                   [green]

# Faccio lo stesso con la variabile del 20121:
powell2021
#  lakepowell_2021.1, lakepowell_2021.2, lakepowell_2021.3 
#      [NIR],              [red],             [green]

# Per questo progetto si sono utilizzate immagini prese da Landsat, in cui le 
# bande sono divise in questo modo:
# B1=NI; 
# B2=red; 
# B3=green-

# Decido di plottare le immagini con il "plot" della funzione ggRGB.
ggRGB(powell2017, r=1, g=2, b=3, stretch="lin") # si utilizza uno strech lineare.
# Assegno il ggRGB a una variabile e utilizzo uno strech lineare:
p1 <- ggRGB(powell2017, r=1, g=2, b=3, stretch="lin") +labs(title="Lago Powell 2017")

# Decido di plottare anche l'immagine del 2021 con il "plot" della funzione ggRGB.
ggRGB(powell2021, r=1, g=2, b=3, stretch="lin") # si utilizza uno strech lineare.
# Assegno il ggRGB a una variabile e utilizzo uno strech lineare:
p2 <- ggRGB(powell2021, r=1, g=2, b=3, stretch="lin") +labs(title="Lago Powell 2021")

# Utilizzo la funzione "grid arrange" per mostrare entrambe le immagini su un' unica riga.
# Creo una figura unica che contiene le due immagini (RGB e IR).
grid.arrange(p1,p2,nrow=1,top="Confronto Lago Powell tra il 2017 e il 2020") 

# Decido di importare la prima immagine del 2017 tramite la funzione "raster" che 
# serve a caricare i singoli dati e non un pacchetto di dati e la associo a un 
# nome di variabile
rpowell2017<- raster("lakepowell_2017.jpg")
# Eseguo il plot normale:
plot(rpowell2017)

# Faccio lo stesso per l'immagine del 2021:
rpowell2021<- raster("lakepowell_2021.jpg")
# Eseguo il plot normale:
plot(rpowell2021)

# Decido di creare una colorRampPalette.
# ColorRampPalette--> stabilisce la variazione dei colori (i colori che si vedono
# sono numeri, ovvero valori di riflettanza in una certa lunghezza d'onda).
# La "c" prima delle parentesi indica una serie di elementi (vettore o array).
# Il numero 100 tra parentesi indica quanti livelli diversi dei 3 colori 
# scelti si vuole inserire nella scala di colori.
# A tale funzione si associa un nome di variabile.
cl <- colorRampPalette(c("black", "purple", "violetred", "orange", "seashell")) (100)
# Plotto le immagini del 2017 e del 2021 disposti su una riga e due colonne:
par(mfrow=c(1,2))
plot(rpowell2017, col=cl, main="Lago Powell 2017") # aggiungo un titolo 
plot(rpowell2021, col=cl, main="Lago Powell 2021") #aggiungo un titolo

dev.off() #funzione che serve per chiudere la finestra precedente.

# Eseguo la differenza tra le due immagini (2017-2021)
powell_dif <- rpowell2021-rpowell2017
# Decido di fare un'altra colorRampPalette 
cldif <- colorRampPalette(c("blue","white","red"))(100)
# Eseguo il plot:
plot(powell_dif, col=cldif, main="Differenza tra il 2021 e il 2017")

#########################  UnsuperClass classification  ########################

# "UnsuperClass classification"--> classificzione non supervisionata, ovvero non 
# c'è nessun impatto da parte dell'utente di definire a monte le classi. 
# Si lascia al software definire i "training sets" direttamente sulla base delle
# riflettanze.
# Si tratta di una funzione che è all'interno di RStoolbox e opera sulla classificazione 
# non supervisionata.

# UnsuperClass dell'immagine 2017
# Rendo le classi discrete, in modo che la classificazione sia sempre la stessa.
set.seed(42) 
# Applico la funzione UnsuperClass utilizzando 3 classi:
clasimm2017<-unsuperClass(powell2017, nClasses=3)
# Assegno una nuova colorRampPalette per vedere come sono state distribuite le classi
cl2017<-colorRampPalette(c("sandybrown", "dodgerblue","brown"))(100)
# L'assegnazione delle classi cambia ogni volta che si esegue un run.
# Mostro a video la conta dei pixel per ogni classe:
freq(clasimm2017$map) 
#     value   count
#[1,]     1 2338884  # altopiano formato da materiale più chiaro
#[2,]     2  980022  # a questa classe associo l'acqua del lago
#[3,]     3 1677944  # altopiano formato da materiale più scuro
# Plotto la mappa delle classi con la colorRampPalette assegnata in precedenza
# e decido di far vedere le zone bagnate
plot(clasimm2017$map, col=cl2017)

# Creo un dataframe con i pixel categorizzati:
df1<-data.frame(freq(clasimm2017$map))
# Vedo le informazioni del dataframe:
df1
#  value   count
#1     1 2338884
#2     2  980022
#3     3 1677944
# Passo a sommare tutta la colonna dei count:
sum2017<-sum(df1$count)
sum2017
#[1] 4996850
# Decido di esprimere il dataframe in percentuali:
df1$perc_2017<-(df1$count/sum2017)*100
# Mostro a video le percentuali:
df1$perc_2017
#[1]46.80717 19.61280 33.58004

# Decido di migliorare il dataframe apportando delle modifiche:
# Rinomino le righe:
rownames(df1)<-c("classe_1","classe_2","classe_3") 
# Rinomino le colonne:
colnames(df1)<-c("classe","count","perc_2017")
# Aggiungo un vettore "classe" al dataframe:
df1$classe<-c("Classe 1","Classe 2","Classe 3")

# Eseguo un grafico con "ggplot" per il 2017, più precisamente un grafico a barre:
ggplot(df1,aes(x=classe,y=perc_2017, fill=classe))+
  geom_bar(stat="identity", color="black")+   ##"geom_bar" mi indica il tipo di grafico
  labs(x="Classi",y="Percentuale",title="Percentuale per Classe 2017")+
  # "labs" sono i labels degli assi
  theme(legend.position="bottom")
# theme" mi dà delle opzioni su come posizionare la legenda.
# Per facilità associo il plot appena eseguito ad una varibile:
p9<-ggplot(df1,aes(x=classe,y=perc_2017, fill=classe))+
  geom_bar(stat="identity", color="black")+
  labs(x="Classi",y="Percentuale",title="Percentuale per Classe 2017")+
  theme(legend.position="bottom")


# UnsuperClass dell'immagine 2021 (prosciugamento del Lago Sawa)
# Anche in questo caso per fare in modo che una classificazione sia sempre la 
# stessa, si utilizza la funzione "set.seed".
# Quindi, rendo le classi discrete:
set.seed(42)
# Applico la funzione UnsuperClass utilizzando 3 classi:
clasimm2021<-unsuperClass(powell2021, nClasses=3)
# Utilizzo la stessa colorRampPalette precedente ma le assegno una nuova variabile:
cl2021<-colorRampPalette(c("dodgerblue", "sandybrown"," brown"))(100)
# L'assegnazione delle classi cambia ogni volta che si esegue un run.
# Mostro a video la conta dei pixel per ogni classe:
freq(clasimm2021$map)
#     value  count
#[1,]     1  675626  # a questa classe associo l'acqua del lago
#[2,]     2 2459724  # altopiano formato da materiale più chiaro
#[3,]     3 1861500  # altopiano formato da materiale più scuro
# Eseguo il plot da cui si vedrà l'area prosciugata del lago:
plot(clasimm2021$map, col=cl2021) 
# Creo un dataframe con i pixel categorizzati:
df2<-data.frame(freq(clasimm2021$map))
# Vedo le informazioni del dataframe:
df2
#  value   count
#1     1  675626
#2     2 2459724
#3     3 1861500
# Passo a sommare tutta la colonna dei count:
sum2021<-sum(df2$count)
# Decido di esprimere il dataframe in percentuali:
df2$perc_2021<-(df2$count/sum2021)*100 
# Mostro a video le percentuali:
df2$perc_2021
#[1] 13.52104 49.22549 37.25347

# Decido di migliorare il dataframe apportando delle modifiche:
# Rinomino le righe:
rownames(df2)<-c("classe_1","classe_2","classe_3")
# Rinomino le colonne:
colnames(df2)<-c("classe","count","perc_2021") 
# Aggiungo un vettore "classe" al dataframe:
df2$classe<-c("Classe 1","Classe 2","Classe 3")

# Eseguo un grafico con "ggplot" per il 2021, più precisamente un grafico a barre:
ggplot(df2,aes(x=classe,y=perc_2021, fill=classe))+
  geom_bar(stat="identity", color="black")+
  labs(x="Classi",y="Percentuale",title="Percentuale per Classe 2021")+
  theme(legend.position="bottom")

# Per facilità associo il plot appena eseguito ad una varibile:
p10<-ggplot(df2,aes(x=classe,y=perc_2021, fill=classe))+
  geom_bar(stat="identity", color="black")+
  labs(x="Classi",y="Percentuale",title="Percentuale per Classe 2021")+
  theme(legend.position="bottom")

# Creo un multiframe, disponendo le immagine del 2017 e del 2021 in una riga e
# 2 colonne:
par(mfrow=c(1,2))
plot(clasimm2017$map, col=cl2017)
plot(clasimm2021$map, col=cl2021)

# Plotto le unsuperclass del 2017 e del 2021 in un'unica figura:
grid.arrange(p9,p10,nrow=1,top="Confronto tra unsuperClass del 2017 e 2021") 

# Mostro a video come sono costituiti i dataframe 
df1
#             classe     count  perc_2017
#classe_1   Classe 1   2338884   46.80717
#classe_2   Classe 2    980022   19.61280 # a questa classe associo l'acqua del lago
#classe_3   Classe 3   1677944   33.58004

df2
#             classe     count  perc_2021
#classe_1   Classe 1    675626   13.52104 # a questa classe associo l'acqua del lago
#classe_2   Classe 2   2459724   49.22549
#classe_3   Classe 3   1861500   37.25347

# Calcolo la percentuale di riduzione dell'area bagnata rispetto al 2017.
# Agisco  sulla prima riga, terza colonna del df1 e sulla prima riga, terza colonna del df2.
diff_perc<-(((df1[2,3])-(df2[1,3]))/df1[2,3])*100 
# Mostro a video il valore di percentuale che mi serve:
diff_perc
#[1] 31.06012 #Percentuale di riduzione dell'area bagnata rispetto al 2017
.

dev.off() #funzione che serve per chiudere la finestra precedente.


##################  Normalized Difference Water Index (NDWI) ###################

# L'NDWI viene utilizzato per monitorare i cambiamenti relativi al contenuto 
# idrico nei corpi idrici. Poiché i corpi idrici assorbono fortemente la luce nello
# spettro elettromagnetico da visibile a infrarosso, NDWI utilizza le bande del verde 
# e del vicino infrarosso per evidenziare i corpi idrici. 
# È sensibile ai terreni edificati e può causare una sovrastima dei corpi idrici.

# Per prima cosa si sceglie una colorRampPalette per visualizzare meglio l'indice 
# di acqua differenziale normalizzato:
cndwi<-colorRampPalette(c("green","magenta","dodgerblue","white"))(100)

# NDWI2017 normalized difference water index 2017
# NDWI = (GREEN - NIR) / (GREEN + NIR)
# Acquisisco le varie bande separatamente e ognuna la associo a una variabile
# Banda verde:
green2017<-powell2017$lakepowell_2017.3
# Banda dell'infrarosso:
nir2017 <- powell2017$lakepowell_2017.1
# Calcolo dell'NDWI del 2017:
ndwi2017<-(green2017-nir2017)/(green2017+nir2017)

# Eseguo il plot utilizzando la colorRampPalette decisa inizialmente e aggiungo
# un titolo:
plot(ndwi2017, col=cndwi, main="NDWI del 2017")

# NDWI2021 normalized difference water index 2021
# Per Sentinel-2 NDWI = (GREEN - NIR) / (GREEN + NIR)
# Acquisisco le varie bande separatamente e ognuna la associo a una variabile
# Banda verde:
green2021<-powell2021$lakepowell_2021.3 
# Banda dell'infrarosso:
nir2021 <- powell2021$lakepowell_2021.1
# Calcolo dell'NDWI del 2021:
ndwi2021<-(green2021-nir2021)/(green2021+nir2021)
# Eseguo il plot utilizzando la colorRampPalette decisa inizialmente e aggiungo
# un titolo:
plot(ndwi2021, col=cndwi, main="NDWI del 2021")

# Plotto NDWI del 2017 e NDWI del 2021 disposti su una riga e due colonne:
par(mfrow=c(1,2))
plot(ndwi2017,col=cndwi, main="NDVI del 2017") # main serve per aggiungere un titolo
plot(ndwi2021,col=cndwi, main="NDVI del 2021") # main serve per aggiungere un titolo

dev.off() #funzione che serve per chiudere la finestra precedente

# Calcolo la differenza dei due NDWI:
# NDWI2021-NDWI2017
# Eseguo la differenza dell'indice:
ndwi_diff<- ndwi2017-ndwi2021
#Eseguo il plot a cui aggiungo un titolo:
plot(ndwi_diff, col=cldif, main="Differenza tra NDWI del 2017 e NDWI del 2021")
dev.off() #funzione che serve per chiudere la finestra precedente.


############################# Soil-Adjusted Vegetation Index (SAVI) ###################################### 

# Metodo SAVI
# L'indice Soil-Adjusted Vegetation Index (SAVI) è un indice di vegetazione che 
# tenta di ridurre l'influenza della luminosità del terreno utilizzando un apposito 
# fattore di correzione. Spesso viene usato in regioni aride dove la copertura 
# vegetativa è scarsa.

# SAVI = ((NIR - Red) / (NIR + Red + L)) x (1 + L)

# NIR e Rossa si riferiscono alle bande associate a tali lunghezze d'onda. 
# Il valore L varia a seconda della quantità di copertura di vegetazione verde.
# In linea generale, nelle aree senza copertura di vegetazione verde, L=1; 
# nelle aree a moderata copertura di vegetazione verde, L=0,5; nelle aree a elevata
# copertura di vegetazione verde, L=0.

# In questo caso specifico, dato che il lago Powell non è presente vegetazione, 
# uso L=1

# Decido di scegliere una nuova colorRampPalette per visualizzare quest'altro indice:
csavi<-colorRampPalette(c("yellow","orange","green","black","white"))(100)
# SAVI 2017
# Banda dell'infrarosso:
nir2017<-powell2017$lakepowell_2017.1
# Banda del rosso:
red2017<-powell2017$lakepowell_2017.2
# Calcolo SAVI del 2017:
savi2017<-((nir2017-red2017)*(1+1))/(nir2017+red2017+1)
# Eseguo il plot utilizzando la colorRampPalette decisa inizialmente e aggiungo
# un titolo:
plot(savi2017, col=csavi, main="SAVI 2017")

# SAVI 2021
# Banda dell'infrarosso:
nir2021<-powell2021$lakepowell_2017.1
# Banda del rosso:
red2021<-powell2021$lakepowell_2021.2
# Calcolo SAVI del 2021:
savi2021<-((nir2021-red2021)*(1+1))/(nir2021+red2021+1)
# Eseguo il plot utilizzando la colorRampPalette decisa inizialmente e aggiungo
# un titolo:
plot(savi2021, col=csavi,main="SAVI 2021")

# Plotto SAVI del 2017 e SAVI del 2021 disposti su una riga e due colonne:
par(mfrow=c(1,2))
plot(savi2017, col=csavi, main="SAVI 2017")
plot(savi2021, col=csavi, main="SAVI 2021")

dev.off() #funzione che serve per chiudere la finestra precedente

# Calcolo la differenza dei due SAVI:
# SAVI 2021-SAVI 2017
# Decido di asseganre  una nuova colorRampalette per far vedere meglio le 
# differenze fra il 2021 e il 2017
# Eseguo la differenza dell'indice:
savi_diff<- savi2017-savi2021
#Eseguo il plot a cui aggiungo un titolo:
plot(savi_diff, col=cldif, main="Differenza tra SAVI del 2017 e SAVI del 2021")

dev.off() #funzione che serve per chiudere la finestra precedente
#################################  PCA  ########################################

# Per prima cosa visualizzo i dettagli delle immagini:
powell2017
powell2021 

# Scelgo una nuovacolorRampPalette e plotto le tre bande di ogni immagine:
clpca <- colorRampPalette(c("blue","purple","magenta","orange","yellow")) (100)
plot(powell2017, col=clpca)
plot(powell2021, col=clpca)

#Essendo le bande  divise in questo modo:
# B1=NI; 
# B2=red; 
# B3=green-

# Dato che sono le bande che ho già a disposizione nel dataset, in quanto mi sono 
# serviti per calcolare i due indici di sopra, decido di plottare:
# -i valori della banda 1 del 2017 (near infra-red) contro i valori 
# della banda 3 (green) sempre del 2017 e
# -i valori della banda 1 del 2021 (near infra-red) contro i valori 
# della banda 3 (green) sempre del 2021.
# Decido di disporli, tramite un "par" in 2 righe e una colonna
par(mfrow=c(2,1))
plot(nir2017, green2017, col="red", pch=19, cex=1)
plot(nir2021, green2021, col="red", pch=19, cex=1)
#Per mettere in evidenza il plot si utilizza il rosso, il "pch" si intende il 
#simbolo che si vuole utilizzare e "cex" indica la dimensione del parametro grafico
#che si è scelto.

# Decido di plottare tutte le correlazioni possibili fra tutte le variabili 
#del dataset e per fare questo Si utilizza la funzione "pairs". 
pairs(powell2017)
# La correlazione fra le tre bande del 2017 è del 84%
pairs(powell2021)
# La correlazione fra le tre bande del 2021 è del 78%

# Si procede con l' analisi PCA
# La funzione PCA ("Principal Components Analysis) consiste nel prendere i 
# dati originali e si fa passare un asse lungo la variabilità maggiore e l'altro asse
# lungo la variabilità minore.
# La "rasterPCA"-->prende il pacchetto di dati e va a compattarli in un numero 
# minore di bande.
# Alla funzione "rasterPCA" si fa seguire l'immagine e la si associa ad una nuova 
# variabile
powell2017_pca <- rasterPCA(powell2017)
powell2021_pca <- rasterPCA(powell2021)

# La funzione "summay" mi dà un sommario del modello. Alla funzine "summary", si fa 
# seguire il nome di quello che si è appena generato e lo si lega con il simbolo 
# del dollaro al modello.
summary(powell2017_pca$model)
# Importance of components:
#                             Comp.1     Comp.2      Comp.3
# Standard deviation     108.0645372 23.2573965 4.964194970
# Proportion of Variance   0.9538081  0.0441791 0.002012761
# Cumulative Proportion    0.9538081  0.9979872 1.000000000
# Questo risultato afferma che la PC1 spiega il 95,38% della variabilità del sistema.
# Mentre con la seconda banda si arriverà al 99% e la terza banda al 100%. 

# Si esegue il plot dell'immagine2017_pca legata alla mappa.
plot(powell2017_pca$map) 
# Da questo plot si ottiene che la prima componente ha tanta deformazione
# quindi, con tanta variabilità mentre l'ultima componente ha il residuo.
# Il PC1 ha tutte le informazioni: si vede il lago e la parte degli altopiani 
# del gran Canyon mentre la PC3 non si distingue più nulla.
# SINTESI: La prima componente è quella che spiega più variabilità.

# Names      :        PC1,        PC2,        PC3 
# min values : -225.67711,  -93.59984,  -52.14022 
# max values :  186.15028,   96.89894,   31.99906 

#Faccio lo stesso per l'immagine del 2021:
summary(powell2021_pca$model)
#Importance of components:
#                            Comp.1      Comp.2      Comp.3
# Standard deviation     94.6110896 25.15438628 5.003193942
# Proportion of Variance  0.9315462  0.06584878 0.002605043
 #Cumulative Proportion   0.9315462  0.99739496 1.000000000

# Si esegue il plot dell'immagine2021_pca legata alla mappa.
plot(powell2021_pca$map)
powell2021_pca$map
# names      :        PC1,        PC2,        PC3 
# min values : -246.61865,  -93.04823,  -34.78544 
# max values :  170.92637,   91.99455,   44.33611 

# Eseguo il plot di ggRGB dell'analisi sfruttando le componenti principali e decido 
# di utilizzare un stretch lineare
c1 <-ggRGB(powell2017_pca$map, r=1,g=2,b=3, stretch="lin")
c2 <-ggRGB(powell2021_pca$map, r=1,g=2,b=3, stretch="lin") 
# Tramite la funzione "grid arrange" dispongo le immagini una affianco all'altra:
grid.arrange(c1, c2, nrow=1)

############################  Variabilità locale  ##############################
# Passo a calcolare la variabilità locale, quindi la deviazione standard, unendo
# l'immagine del 2017 alla mappa e alla prima componente (PC1), infine si associa
# ad una variabile:
pc1_2017 <- powell2017_pca$map$PC1
# Si misura la deviazione standard e si sceglie come grandezza della griglia (5x5):
pc1sd5_2017 <- focal(pc1_2017 , w=matrix(1/25, nrow=5, ncol=5), fun=sd)

# Faccio la stessa cosa con l'immagine del 2021: calcolo la variabilità locale, 
# quindi la deviazione standard, unendo l'immagine del 2021 alla mappa e alla 
# prima componente (PC1) e infine si associa ad una variabile:
pc1_2021 <- powell2021_pca$map$PC1
# Si misura la deviazione standard e si sceglie come grandezza della griglia (3x3):
pc1sd5_2021 <- focal(pc1_2021, w=matrix(1/25, nrow=5, ncol=5), fun=sd)

# Decido di plottare tramite "ggplot" i dati, quindi prima cosa da fare è creare 
# una finestra vuota tramite la funzione ggplot, poi si definisce il tipo di geometria 
# tramite il comando "geom_raster" che in questo caso sarà rettangolare e infine si passano 
# a definire le estetiche (ovvero cosa si vuole plottare) che in questo caso sono
# la x e la y-->le coordinate geografiche e come "fill", ovvero il valore di riempimento, 
# metto lo strato/layer. Dentro c'è il valore della deviazione standard.
 ggplot() +
  geom_raster(pc1sd5_2017, mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "turbo")  +
  ggtitle("Standard deviation of PC1_2017")

ggplot() +
  geom_raster(pc1sd5_2021, mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "turbo")  +
  ggtitle("Standard deviation of PC1_2021")
dev.off
#Decido di associare questi ggplot a delle variabili in modo da poterli visualizzare
# insieme uno accanto all'altro:
sd1 <- ggplot() +
  geom_raster(pc1sd5_2017, mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "turbo")  +
  ggtitle("Standard deviation of PC1_2017")

sd2 <- ggplot() +
  geom_raster(pc1sd5_2021, mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "turbo")  +
  ggtitle("Standard deviation of PC1_2021")
# Tramite la funzione "grid arrange" dispongo le immagini una affianco all'altra:
grid.arrange(sd1,sd2, nrow = 1)

dev.off() #funzione che serve per chiudere la finestra precedente.

#########################  Spectral signature  ################################
# Prima di concentrarmi sulle firme spettrali, eseguo un plot dell'immagine 2017:
plotRGB (powell2017, r=1, g=2, b=3, stretch="lin")#tramite uno strech lineare
#oppure
plotRGB (powell2017, r=1, g=2, b=3, stretch="his")#facendo un histogram strech
#che invece di utilizzare una linea per trasformare e ampliare la gamma dei 
#valori, utilizza una curva (chiamata curva logistica),che aumenta la pendenza
#e quindi le differenze tra i due plot saranno molto più accentuate. 

#La funzione per creare firme spettrali si chiama "click" che è contenuta 
#nel pacchetto "rgdal". Serve per cliccare sulla mappa e avere a disposizione 
#qualsiasi informazione (in questo caso informazioni relative alla riflettanza).
click(powell2017, id=T, xy=T, cell=T, type="o", pch=16, col="magenta")

#Results:
#Cliccando sulla mappa una zona di altopiani del gran canyon si ottiene:
#       x     y      cell   lakepowell_2017.1   lakepowell_2017.2   lakepowell_2017.3
#1 1403.5 361.5   4007098                 234                 183                 118
#Si nota che la prima banda corrispondente al NIR ha un valore molto alto di 
#riflettanza, nella seconda banda che corrisponde al red si ha un valore medio
#in quanto assorbe e nella terza banda che sarebbe quella del green si ha un 
#valore basso.

#Invece, cliccando su una zona dove è presente acqua si ottengono i seguenti risultati:
#       x     y      cell   lakepowell_2017.1   lakepowell_2017.2   lakepowell_2017.3
#1 1584.5 932.5   2443881                   2                  19                  37
#Si nota una riflettanza bassissima in NIR, una rifrettanza medio bassa in rosso e 
#alta nel verde.

#Si passa a creare un dataframe.
#Per creare un dataframe si fa uno storage dei dati.

#Si farà una tabellina con tre colonne: nella prima si inseriranno il numero delle
#bande, nella seconda la componente degli altopiani e nella terza la componente acqua.

#Define the columns of dataset.
#Si definiscono le colonne del dataset:
band <- c(1,2,3) #banda 1,2,3
altopiani <- c(234,183,118) #si inseriscono i valori riportati prima per gli altopiani
acqua <- c(2,19,37) #si inseriscono i valori riportati prima per l'acqua

#La funzione per fare la tabella è data.frame:
spectrals <- data.frame(band, altopiani, acqua)
#Per visualizzare la tabella:
spectrals 
#da cui si visualizzerà a video la tabella:
#band altopiani acqua
#1    1       166     1
#2    2       108    22
#3    3        84    41

#Plot the spectral sign
#A questo punto si esegue un plot con ggplot2.
ggplot(spectrals, aes(x=band))+ #per il grafico si mette sull'asse delle x le bande e 
  #sull'asse y le riflettanze degli altopiani e dell'acqua.
  geom_line(aes(y = altopiani), color ="brown") + #geom_line connette le osservazioni
  #che si hanno a seconda del dato 
  #che si è definito sulla x.
  geom_line(aes(y = acqua), color ="blue") + #da cui esce che l'acqua ha un comportamento
  #diametralmente opposto rispetto alla vegetazione.
  labs(x="band",y="reflectance") #si aggiungono le etichette agli assi.

#################################  MULTITEMPORAL  #############################
# Termino il programma facendo un'analisi multitemporale delle due immagini:

# Eseguo un plot dell'immagine 2017
plotRGB (powell2017, r=1, g=2, b=3, stretch="lin")#tramite uno strech lineare

# Utilizzo la funzione per "click" per creare firme spettrali si chiama
click(powell2017, id=T, xy=T, cell=T, type="o", pch=16, col="magenta")

# Decido di cliccare dei punti sull'immagine 2017, dove successivamente nell'iimagine
# del 2021 vedrò il ritiro dell'acqua
#      x     y    cell lakepowell_2017.1 lakepowell_2017.2 lakepowell_2017.3
#1 163.5 672.5 3154340                 8                35                52
#      x     y    cell lakepowell_2017.1 lakepowell_2017.2 lakepowell_2017.3
#1 568.5 227.5 4373155                 6                25                42
#       x      y   cell lakepowell_2017.1 lakepowell_2017.2 lakepowell_2017.3
#1 1612.5 1734.5 248033                 5                28                42
#       x     y    cell lakepowell_2017.1 lakepowell_2017.2 lakepowell_2017.3
#1 1331.5 881.5 2583266                 7                26                43
#       x     y    cell lakepowell_2017.1 lakepowell_2017.2 lakepowell_2017.3
#1 1941.5 686.5 3117786                 4                21                37

# Eseguo un plot dell'immagine 2021
plotRGB (powell2021, r=1, g=2, b=3, stretch="lin")#tramite uno strech lineare

# Utilizzo la funzione per "click" per creare firme spettrali si chiama
click(powell2021, id=T, xy=T, cell=T, type="o", pch=16, col="magenta")

# Decido di cliccare circa gli stessi punti dell'immagine precedente
#      x     y    cell lakepowell_2021.1 lakepowell_2021.2 lakepowell_2021.3
#1 171.5 679.5 3135182               210               194               169
#      x      y    cell lakepowell_2021.1 lakepowell_2021.2 lakepowell_2021.3
#1 575.5 245.5 4323878               235               199               151
#       x      y   cell lakepowell_2021.1 lakepowell_2021.2 lakepowell_2021.3
#1 1620.5 1745.5 217923               200               179               160
#       x     y    cell lakepowell_2021.1 lakepowell_2021.2 lakepowell_2021.3
#1 1327.5 921.5 2473742               209               166               132
#       x     y    cell lakepowell_2021.1 lakepowell_2021.2 lakepowell_2021.3
#1 1938.5 711.5 3049333               246               213               172

#creo il dataset definiamo le colonne del dataset
band <- c(1,2,3)
time2017_p1<- c(8,35,52)
time2017_p2<- c(6,25,42)
time2017_p3<- c(5,28,42)
time2017_p4<- c(7,26,43)
time2017_p5<- c(4,21,37)
time2021_p1 <- c(210,194,169)
time2021_p2 <- c(235,199,151)
time2021_p3 <- c(200,179,160)
time2021_p4 <- c(209,166,132)
time2021_p5 <- c(246,213,172)

spectralst2 <- data.frame(band,time2017_p1,time2017_p2,time2017_p3,time2017_p4,time2017_p5,time2021_p1,time2021_p2,time2021_p3,time2021_p4,time2021_p5)
spectralst2

ggplot(spectralst2, aes(x=band)) + 
  geom_line(aes(y = time2017_p1), color = "red",lty=5,lwd=1.3)+
  geom_line(aes(y = time2017_p2), color = "dodgerblue",lty=5,lwd=1.3) +
  geom_line(aes(y = time2017_p3), color = "mediumspringgreen",lty=5,lwd=1.3) +
  geom_line(aes(y = time2017_p4), color = "purple",lty=5,lwd=1.3) +
  geom_line(aes(y = time2017_p5), color = "gold",lty=5,lwd=1.3) +
  geom_line(aes(y = time2021_p1), color = "red",lwd=1.3)+ 
  geom_line(aes(y = time2021_p2), color = "dodgerblue",lwd=1.3)+
  geom_line(aes(y = time2021_p3), color = "mediumspringgreen",lwd=1.3)+
  geom_line(aes(y = time2021_p4), color = "purple", lwd=1.3)+
  geom_line(aes(y = time2021_p5), color = "gold",lwd=1.3)+
  labs(x="band", y="reflectance")
