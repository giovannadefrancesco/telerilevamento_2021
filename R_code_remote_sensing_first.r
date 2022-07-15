#GIORNO 1
#My first code in R for remote sensing!
#Il mio primo codice in R per il telerilevamento!

setwd("C:/lab/")#Serve per impostare la cartella di lavoro, nella quale verranno
                #salvati/cercati di default i file.      

#install.packages("raster") #serve per installare il pacchetto raster.

library(raster) #Viene caricato il pacchetto raster, non vengono messe le virgolette 
                #perchè è già in R.

#La funzione brick serve ad importare un'immagine satellitare infatti,
#importa tutte le bande delle immagini satellitari in un'unica immagine 
#satellitare. In questo caso si usano le virgolette perchè questo file si 
#trova esterno a R. In seguito, questa funzione viene associata ad un nome.
p224r63_2011 <- brick("p224r63_2011_masked.grd")

#Questo comando serve per vedere le informazioni  (tipo di file, dimensioni,
#risoluzione ecc) del file contenente le immagini satellitari
p224r63_2011 #Si tratta della riserva Parakan

#Questo comando serve per plottare le varie immagini
plot(p224r63_2011)

#COLOUR CHANGE
#colorRampPalette--> stabilisce la variazione dei colori (i colori che si vedono 
#con le singole bande sono numeri, ovvero i valori di riflettanza in una certa
#lunghezza d'onda).
#La "c" prima delle parentesi indica una serie di elementi che si chiama vettore 
#o array. Il numero 100 tra parentesi indica quanti livelli diversi dei 3 colori 
#scelti si vuole inserire nella scala di colori.
#A tale funzione si associa un nome/un oggetto, in questo caso cl.
cl<-colorRampPalette(c("black", "grey","light grey"))(100)

#Adesso, bisogna fare il plot della nuova immagine usando questa nuova scala di 
#colori, dove con il "col" si indica l'argomento e si assegna=cl.
plot(p224r63_2011, col=cl)
#In questo modo si è utilizzata una legenda personale che si basa dal nero fino 
#al grigio chiaro. 

##GIORNO 2
#COLOUR CHANGE NEW
#Se si vuole inserire una nuova scala di colori:
cl<-colorRampPalette(c("blue","green","grey","red","magenta","yellow"))(100)
#In seguito, si esegue il plot della nuova immmagine con la nuova scala di colori:
plot(p224r63_2011, col=cl)

#Altra nuova scala di colori:
cls<-colorRampPalette(c("red","pink","orange","purple"))(100)
#sSi esegue il plot:
plot(p224r63_2011, col=cls)
#In questo caso si avranno i valori di riflettanza più bassi in rosso e valori di
#riflettanza più alti in viola per ogni banda.

###GIORNO 3
# Il software applica una scala di colori di dafault e le varie bande di LANDSAT sono:

# B1: blu (blue) 
# B2: verde (green)
# B3: rosso (red)
# B4: NIR,  infrarosso vicino
# B5: infrarosso medio 
# B6: infrarosso termico o lontano 
# B7: infrarosso medio 

#dev.off-->questa funzione serve a ripulire la finestra grafica
dev.off()

#Si vuole vedere plottata solo la banda blu, B1 dell'immagine.
#Il simbolo del $ viene sempre utilizzato per legare due blocchi, in questo caso
#si lega l'immagine alla banda uno.
plot(p224r63_2011$B1_sre)

#Esercizio:
#Plot band 1 with a predefined color ramp palette
#Si plotta la banda 1 con una scala di colori a piacere 
cls<-colorRampPalette(c("red","pink","orange","purple"))(100)
plot(p224r63_2011$B1_sre, col=cls)

dev.off() #funzione che serve per chiudere la finestra precedente.

#Si vuole effettuare un plot delle singole bande con la funzione "par" che serve 
#per fare un settaggio dei parametri grafici di un certo grafico che si vuole 
#creare.
#Comando par(mfrow=1 row, 2 colums) dove "mf" sta per multiframe e row=riga, 
#serve per visualizzare il prossimo grafico, che a sua volta contiene grafici
#interni con disposizione in 1 riga e 2 colonne.
#In sintesi, la funzione "par" serve a stabilire come si vuole fare il plottaggio.

par(mfrow=c(1,2)) #con par(mfrow...) si ha prima il numero di righe. 
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#E' possibile anche invertire la disposizione delle immagini, ovvero disporre 
#le immagigin in 2 righe e 1 colonna
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
#Nel caso si decidesse di utilizzare prima le colonne si scriverebbe: par(mfcol..).

#Plot the first four bands of Landsat:
#Plottare le prime 4 bande di Landsat:
par(mfrow=c(4,1)) #le immagini verranno visualizzate in 4 righe e 1 colonna
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#Se si volessero  plottare e disporre le immagini in una disposizione "quadrata" 
#a quadrat of bands...:
par(mfrow=c(2,2)) #le immagini verranno visualizzate in 2 righe e 2 colonne
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#Per ogni banda, si mette una colorRamPalette che richiami, appunto, quella banda
par(mfrow=c(2,2)) #si visualizza il grafico in modo che abbia 2 righe e 2 colonne
#Si crea una colorRamPalette che ricorda il blu
clb <- colorRampPalette(c("dark blue","blue","light blue")) (100) 
#Si è plottata la banda del blu con questa colorRamPalette
plot(p224r63_2011$B1_sre, col=clb) 

#Si aggiunge la banda del verde:
clg <- colorRampPalette(c("dark green","green","light green")) (100)
#Si esegue il plot:
plot(p224r63_2011$B2_sre, col=clg)

#Si aggiunge la banda del rosso:
clr <- colorRampPalette(c("dark red","red","pink")) (100)
#Si esegue il plot:
plot(p224r63_2011$B3_sre, col=clr)

#Si aggiunge la banda dell'infrarosso vicino:
clnir <- colorRampPalette(c("red","orange","yellow")) (100)
#Si esegue il plot:
plot(p224r63_2011$B4_sre, col=clnir)

dev.off() #funzione che serve per chiudere la finestra precedente.

####GIORNO 4
#Visualizing data by RGB plotting.
#Si cercherà di capire cosa sia un plotting in RGB
#Viene richiamata la libreria raster.
library(raster)
#Si seleziona la cartella di lavoro e quindi, di riferimento.
setwd("C:/lab/")
#Vengono ricaricati i dati
p224r63_2011 <- brick("p224r63_2011_masked.grd")

#Le varie bande di LANDSAT:
# B1: blu (blue) 
# B2: verde (green)
# B3: rosso (red)
# B4: NIR,  infrarosso vicino
# B5: infrarosso medio 
# B6: infrarosso termico o lontano 
# B7: infrarosso medio 

#Plot RGB (RedGreenBlue), si ha un oggetto raster multi-layered quindi, con molte
#bande e attraverso lo schema RedGreenBlue verranno utilizzate.
#Il comando consiste in plotRGB seguito dal nome dell'immagine Landsat originale 
#che contiene tutte le bande,poi bisogna specificare quali componenti si vogliono 
#associare ad ogni singola banda di Landsat:
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")#Stretch serve per "stirare" 
                                                   #le immagini da cui uscirà 
                                                   #un'immagine a colori naturali.
#Si è saltata una banda per utilizzare l'infrarosso vicino montandolo sulla componente
#red dello schema RGB.
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") #in questo caso tutta la 
                                                    #vegetazione è rossa.

#Si è utilizzato l'infrarosso vicino montandolo sulla componente green dello schema RGB.
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") #in questo caso tutta la 
                                                    #vegetazione è verde.

#Si è utilizzato l'infrarosso vicino montandolo sulla componente blu dello schema RGB.
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin") #in questo caso tutta la 
                                                    #vegetazione è blu.
dev.off() #funzione che serve per chiudere la finestra precedente.

#Exercise:mount a 2X2 multiframe, 
#         montare un multiframe 2X2 con le 4 bande precedenti.
#Per salvare un'immagine PDF si utilizza questa funzione:
pdf("Il_mio_primo_PDF_in_R")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off() #funzione che serve per chiudere la finestra precedente.

#Si esegue un altro tipo di stretch:
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") #stretch lineare.
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist") #histogram stretching aumenta 
                                                     #lo strech e ha una penenza 
                                                     #+ elevata nei valori intermedi.
dev.off() #funzione che serve per chiudere la finestra precedente.
#"par" natural colours, false colour and false colours with histogram stretching. 
#"par" con colori naturali, falsi colori e falsi colori con  histogram stretching. 
par(mfrow=c(3,1)) #la disposizione delle immagini sarà in 3 righe e 1 colonna
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #stretch lineare.
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") #stretch lineare.
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist") #histogram stretching, si 
#Si evidenziano differenze potenzilai all'interno della foresta, facendo uno stretch
#ancora più ampio, tutta la parte fucsia è vegetazione.
dev.off() #funzione che serve per chiudere la finestra precedente.

##### GIORNO 5
#install.packages("RStoolbox") #serve per installare il pacchetto RStoolbox.
library(RStoolbox)##Carico il pacchetto RStoolbox.

#Multitemporal set: si inserisce anche l'immagine del 1988
# p224r63_1988_masked
p224r63_1988 <- brick("p224r63_1988_masked.grd")
#La funzione "brick" importa un intero set di bande, creando un RasterBrick (blocco 
#di diversi raster messi tutti insieme).
p224r63_1988 #serve per vedere le informazioni inirenti l'immagine del 1988.
plot(p224r63_1988) #plotta le singole bande dell'immagine.

#Le varie bande di LANDSAT:
# B1: blu (blue) 
# B2: verde (green)
# B3: rosso (red)
# B4: NIR,  infrarosso vicino
# B5: infrarosso medio 
# B6: infrarosso termico o lontano 
# B7: infrarosso medio 

plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin") #plot in colori naturali del 1988.

#Si è saltata una banda per utilizzare l'infrarosso vicino montandolo sulla componente
#red dello schema RGB.
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin") #tutto quello in rosso rappresenta
                                                    #la vegetazione nel 1988.

#Per vedere le differenze tra il 1988 e il 2011 si mettono a confronto le 2 immagini 
#in 2 righe e 1 colonna   
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin") #1988
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") #2011

dev.off() #funzione che serve per chiudere la finestra precedente.

#Si esegue un PDF finale
pdf("Multitemp.pdf")
#Per fare una sintesi, si farà un'unica immagine che a sua volta conterrà
#4 immagini: nelle prime due posizioni si metterà lo stretch lineare,
#nelle seconde due si metterà l'histogram stretch.
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin") #stretch lineare.
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") #stretch lineare.
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist") #histogram stretching.
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist") #histogram stretching.
dev.off() #funzione che serve per chiudere la finestra precedente.
