# R_code_variability_temp.r

#Si richiamano i pacchetti da installare e le librerie di cui si ha bisogno:
#install.packages("raster") #Viene installato il pacchetto raster.
library(raster) #Viene caricato il pacchetto raster.

#install.packages("RStoolbox") #Viene installato il pacchetto RStoolbox per 
                               #eseguire la classificazione.
library(RStoolbox)#Viene caricato il pacchetto RStoolbox

#install.packages("ggplot2") #Viene installato il pacchetto ggplot2.
library(ggplot2) #Viene caricato il pacchetto ggplot2.

#install.packages("gridExtra") #Viene installato il pacchetto gridExtra.
library(gridExtra) #Viene caricato il pacchetto gridExtra per la disposizione 
                  #della griglia e serve per mettere insieme tanti plot di ggplot.

#install.packages("viridis") #Viene installato il pacchetto viridis per la gestione 
                            #dei colori.
library (viridis) #Viene caricato il pacchetto viridis per colorare i plot di ggplot.
 
#Si sceglie la cartella da dove si andranno a leggere i dati. Serve per impostare 
#la cartella di lavoro, nella quale verranno salvati/cercati di default i file.
setwd("C:/lab/") # Windows

#Viene importata l'immagine tramite la funzione "brick" a cui si assegna un nome: 
sent <- brick("sentinel.png")

#Le bande sono divise in questo modo:
#B1=NIR,infrarosso vicino;
#B2=red;
#B3=green

#Si plotta l'immagine con i tre livelli di default: r=1, g=2, b=3
plotRGB(sent, stretch="lin") #si utilizza uno strech lineare
#pltRGB (sent, r=1, g=2, b=3, stretch="lin")

#Si plotta l'immagine con tre livelli ordinati in modo diverso dal plot precedente:
plotRGB(sent, r=2, g=1, b=3, stretch="lin")
#Tutta la roccia (calcare) è in fucsia mentre la vegetazione è in verde fluorescente, 
#l'acqua è rappresentata in nero.

#Bisogna trovare come si chiamano le bande dell'immagine sentinel.
#Per vedere le informazioni dell 'immagine:
sent
#Si unisce l'immagine sentinel.1 all'immagine sent e la si associa ad un nome
#più semplice.
#Banda numero 1 è il near infra-red:
nir <- sent$sentinel.1
#Banda numero 2 è il red:
red <- sent$sentinel.2

#Si esegue il calcolo del NDVI:
ndvi <- (nir-red) / (nir+red)
#Si procede con il plottare il calcolo appena eseguito:
plot(ndvi)
#Dal plot si vede che dove c'è il bianco e il marroncino non c'è vegetazione (si tratta 
#di acqua, rocce e crepacci), le parti in giallino e verde più chiaro sono le 
#parti di bosco e le parti in verde scuro sono le praterie sommitali.

#Per cambiare i colori si utilizza una colorRampPalette:
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100)
#Si esegue il plot della nuova immagine:
plot(ndvi,col=cl)
 
#Si calcola la variabilità di questa immagine, quindi la deviazione standard
#e la si associa a un oggetto (ndvisd3) con una finestra mobile di 3x3 pixel:
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd) #fun=sd-->deviazione standard
#Si esegue il plot:
plot(ndvisd3)
#Per cambiare i colori si utilizza una nuova colorRampPalette:
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
#Si esegue il plot:
plot(ndvisd3, col=clsd)
#Dal plot si nota che dove si vedono colori tendenti al rosso e al giallo si ha
#una deviazione standard più alta mentre dove ci sonon il verde e blu un pò più
#bassa ed è presente nelle zone più omogenee dove c'è la roccia nuda mentre aumenta, 
#quindi è più verde nelle zone dove si passa da roccia nuda alla parte vegetata.
#Poi la deviazione standard ritorna ad essere omogenea su tutte le parti vegetate.
#Si hanno delle piccole zone a nord in rosa che hanno una deviazione standard 
#in aumento che corrispondono ai picchi più alti dei crepacci.

#Per calcolare la MEDIA della biomassa.
#Mean ndvi with focal:
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
#Si utilizza la stessa colorRampPalette di prima:
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
#Si esegue il plot:
plot(ndvimean3, col=clsd)
#Dal plot esce che i valori molto alti (colore giallo) si hanno nelle praterie 
#di alta quota, ovvero nella parte semi-naturale (boschi, coniferi e latifoglie)
#mentre i valori più bassi riguardano la roccia nuda.

#Si sceglie di utilizzare come grandezza della griglia (13x13)
ndvisd13 <- focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd)
#Si utilizza la stessa colorRampPalette:
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
#Si esegue il plot:
plot(ndvisd13, col=clsd)

#Si sceglie di utilizzare come grandezza della griglia (5x5)
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
#Si utilizza la stessa colorRampPalette:
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
#Si esegue il plot:
plot(ndvisd5, col=clsd)

#PCA
#Si prende un sistema a multibande, si calcola una PCA e si utilizza solo la 
#prima componente principale.
#La funzione "rasterPCA" che si trova nel pacchetto RStoolbox, calcola la PCA in
#modalità R e restituisce un RasterBrick con più livelli di punti PCA:
sentpca <- rasterPCA(sent)
#Si esegue il plot del modello insieme alla mappa:
plot(sentpca$map)
#La prima PCA è molto simile all'informazione originale mentre man mano che si 
#passa da una componente principale (PC) all'altra, diminuisce il numero di 
#informazioni.
#Per vedere le informazioni:
sentpca
  
#"Summary" del modello per vedere quanta variabilità iniziale indicano le singole
#componenti. Si vedrà qual è la proporzione di variabilità spiegata da ogni 
#singola componente. 
summary(sentpca$model)
#Importance of components: 
#                         Comp.1     Comp.2     Comp.3    Comp.4
#Standard deviation     77.3362848 53.5145531 5.765599616      0
#Proportion of Variance  0.6736804  0.3225753 0.003744348      0
#Cumulative Proportion   0.6736804  0.9962557 1.000000000      1

#Si è intorno al 67.36804% di variabilità dalla prima componente.
#The first PC contains explains 67.36804% of the original information.
  
#Si unisce l'immagine sentpca alla mappa e alla prima componente (PC1) e infine
#si associa ad un oggetto (pc1):
pc1 <-sentpca$map$PC1 
#Si misura la deviazione standard e si sceglie come grandezza della griglia (5x5):
pc1sd5 <- focal (pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
#Si utilizza la stessa colorRampPalette:
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
#Si esegue il plot di pc1sd5:
plot(pc1sd5, col=clsd)
#Tutte le parti blu indicano la parte di vegetazione legata alle praterie di alta quota ed 
#è quella più omogenea, mentre si ha un aumento di variabilià proprio in quelle zone dove c'è
#il verde, il rosa, ovvero quelle zone di roccia dove c'è un cambiamento più forte.

#La funzione "source" serve per richiamare un pezzo di codice che si è gia creato. 
#Deviazione standard di una finestra 7x7 pixel
#source ("source_test_lezione.r.txt")
#pc1 <-sentpca$map$PC1
#pc1sd7 <- focal (pc1, w=matrix(1/49, nrow=7, ncol=7), fun=sd)
#plot(pc1sd7)

#With the source function you can upload code from outside!
#Con la funzione sorgente è possibile caricare il codice dall'esterno!
source ("source_test_lezione.r.txt")
source ("source_ggplot.r.txt")

#https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html

#THE COLOR SCALES
#The package contains eight color scales: "viridis", the primary choice, and five
#alternatives with similar properties - "magma", "plasma", "inferno", "civids",
#"mako", and "rocket" -, and a rainbow color map - "turbo".

#Si vuole plottare tramite "ggplot" i dati, quindi prima cosa da fare è creare 
#una finestra vuota tramite la funzione ggplot, poi si definisce il tipo di geometria 
#tramite il comando "geom_raster" che in questo caso sarà rettangolare e infine si passano 
#a definire le estetiche (ovvero cosa si vuole plottare) che in questo caso sono
#la x e la y-->le coordinate geografiche e come "fill", ovvero il valore di riempimento 
#si mette lo strato/layer. Dentro c'è il valore della deviazione standard.
p1 <- ggplot() +
  geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis()  + #serve per utilizzare una delle legende di viridis.
  ggtitle("Standard deviation of PC1 by viridis colour scale") #si inserisce il titolo.

#Si cambia la scala di colori della library viridis e si utilizza magma:
p2 <- ggplot() +
  geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "magma")  +
  ggtitle("Standard deviation of PC1 by magma colour scale")

#Si cambia la scala di colori della library viridis e si utilizza turbo
p3 <- ggplot() +
  geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "turbo")  +
  ggtitle("Standard deviation of PC1 by turboo colour scale")

#Per mettere le 3 immagini in un'unica schermata si utilizza grid.arrange:
grid.arrange(p1, p2, p3, nrow=1) #1 riga e 3 colonne con le rispettive legende.
