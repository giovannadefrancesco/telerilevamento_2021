#R_code-complete_Telerilevamento Geo-Ecologico
#--------------------------------------------------------------------------------

#Sumamary:
#1. R code remote sensing
#2. R code time seies
#3. R code Copernicus data
#4. R code knitr
#5. R code multivariate analysis
#6. R code classification
#7. R code ggplot2
#8. R code vegetation indices
#9. R code land cover
#10. R code variability temp 
#11. R code NO2
#12. R code spetral signature

#--------------------------------------------------------------------------------

#1. R code remote sensing
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
dev.off() #funzione che serve per chiudere la finestra precedente.

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

#---------------------------------------------------------------------------------

#2. R code time seies
######GIORNO 6
#Time series analysis: analisi di serie multitemporale di dati da satellite.
#Greenland increase of temperature, ovvero il potenziale aumento di temperatura 
#in Groenlandia 
#Data and code from Emanuela Cosma

#install.packages("raster") serve per installare il pacchetto raster.
library(raster) #Viene caricato il pacchetto raster, non vengono messe le virgolette 
                #perchè è già in R.

#install.packages("rasterVis") #serve per installare il pacchetto rasterVis.
library(rasterVis) #il pacchetto rasterVis consiste in metodi di visualizzazione
                   #per i dati raster.

setwd("C:/lab/greenland") # Windows

#Con questo codice si lavorerà su come importare un blocco di dati tutti insieme
#in  modo da creare uno stack, ovvero un insieme di dati raster multitemporali.

#RICORDA:Il formato raster è formato da pixel, quadratini che hanno valori di riflettanza.

#In questo caso non avendo un unico file ma avendone quattro, non è possibile 
#utilizzare la funzione "brick" e quindi, bisogna importarli singolarmente.
#Ogni file rappresenta la stima della temperatura (lst) e derivano da Copernicus.

#La funzione per caricare i singoli dati/singoli strati e NON un pacchetto di dati, 
#si chiama "raster".

#Importazione PRIMA IMMAGINE del 2000:
#Si assegna la funzione raster all'oggetto lst_2000.tif (si utilizzano le virgolette 
#perchè si esce da R), a sua volta si associa un nome (lst_2000).
lst_2000 <- raster ("lst_2000.tif")
#Viene plottata la prima immagine:
plot(lst_2000)

#Importazione SECONDA IMMAGINE del 2005:
lst_2005 <- raster ("lst_2005.tif")
#Viene plottata la seconda immagine:
plot(lst_2005)

#IMPORTANTE: Dall'immaggine plottata si nota che maggiore è il valore del
#digital numbers (DNs), maggiore è il valore di temperatura per l'area in esame.

#Importazione TERZA IMMAGINE del 2010:
lst_2010 <- raster ("lst_2010.tif")
#Viene plottata la terza immagine:
plot(lst_2010)

#Importazione QUARTA IMMAGINE del 2015:
lst_2015 <- raster ("lst_2015.tif")
#Viene plottata la quarta immagine:
plot(lst_2015)

#Creazione di un multi-pannel con le 4 immagini, utilizzando il comando "par": 
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#Metodo per importare tutte le immaginin insieme:
#lapplay: si può applicare una certa funzione (raster) a una lista di file.
#Si procede creando una lista tramite la funzione "list.files" di tutti i file "lst"
#e si applica a tutti la funzione "raster".
rlist <- list.files(pattern="lst") #pattern è quella "scritta" che hanno in comune
                                   #nei loro nomi i files. Quest'ultimo oggetto 
                                   #poi si associa a un nome.
rlist #è la lista di tutti i file, dentro la cartelle greenland, che hanno al 
      #loro interno la scritta "lst".
#Si vuole ottenere quella famosa lista di file, alla quale applicare la funzione
#"raster" con la funzione "lapply".

#Si applica la funzione "raster" a tutta la lista tramite "lapply".
#La funzione  "lapply" viene applicata a tutta la lista di file che si è appena creata 
#utilizzando la funzione "raster" che importa tutti i file, a cui si associa un nome
#(in questo caso import):
import<-lapply(rlist,raster)
#Per vedere le informazioni:
import
#Si sono importati 4 file singolarmente.

#Si procede con il costruire il pacchetto di file tutto insieme, utilizzando la 
#funzione "stack" e a cui si associa un nome (TGr):
TGr<-stack(import)
TGr #si hanno tutte le informazioni utili del RasterStack.
plot(TGr) #in questo modo viene plottato il singolo file.
dev.off() #funzione che serve per chiudere la finestra precedente.

#Per creare un file in cui si sovrappongono le immagini dei vari anni:
plotRGB(TGr, 1, 2, 3, stretch="lin")
#nel livello Red, si mette il file 1 (2000), nel livello Green il file 2(2005) e
#nel livello Blue il file 3(2010).

#In questo caso se si hanno i valori rossi, ciò significa che si hanno valori più 
#alti di "lst" nella mappa del 2000;

#Se si hanno valori verdi si hanno valori di "lst" più alti nella mappa del 2005

#Se si hanno valori blu si hanno valori di "lst" più alti nella mappa del 2010.

#Siccome la mappa che si è plottata con questi ultimi comandi è abbastanza scura
#nel centro, questo potrebbe significare che si hanno valori più alti nel 2010.

#Si può estendere lo stesso ragionamento utilizzando però, le immagini del 2005, 
#2010 e 2015:
plotRGB(TGr, 2, 3, 4, stretch="lin")
#nel livello Red, si mette il file 2 (2005), nel livello Green il file 3 (2010) 
#e nel livello blue il file 4(2015).

#Si ottiene un'immagine molto simile a quella precedente con la parte blu che 
#riguarda i valori più alti.

#E' possibile anche invertire, ovvero mettere nel livello Red il file 4 (2015), 
#nel livello Green il file 3 (2010) e nel livello blue il file 2 (2005).
plotRGB(TGr, 4, 3, 2, stretch="lin")
dev.off()#funzione che serve per chiudere la finestra precedente.

#######GIORNO 7
#Questa funzione "level plot" disegna grafici di livello e grafici di contorno.
levelplot(TGr)#grafico con tutte e 4 le mappe.
levelplot(TGr$lst_2000)#grafico con una singola mappa di come varia la temperatura
                       #nell'area in esame.
#Dal grafico plottato si nota che dove sono presenti i ghiacci, si ha un valore 
#di lst più basso.

#Per cambiare i colori e abbelire il "plot" si utilizza una colorRampPalette
cl<- colorRampPalette(c("blue","light blue", "pink","red"))(100)
#Per cambiare il colore della mappa finale si utilizza "col.regions".
levelplot(TGr, col.regions=cl)
#Facendo questo plot con dei nuovi colori che si sono stabiliti, è possibile 
#vedere multitemporalmente cosa è successo in questa zona di studio.
#Il colore blu scuro che indica una temperatura minore si degrada verso un
#colore celeste, una temperatura un po' più alta, da un anno all'altro. 
#Si nota un trend di cambiamento di temperatura dal 2000 al 2015.

#A differenza della funzione "plot", la funzione "levelplot" è più compatta, inoltre
#le coordinate sono messe solo sul primo asse y e l'asse x sotto,la legenda è 
#unica e i colori sono migliori.

#Per cambiare i titoli delle immagini:
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
#"names.attr" è l'argomento della funzione "levelplot" per nominare i singoli attributi
#e si inseriscono i 4 blocchi. Siccome si tratta di un vettore di 4 elementi diversi
#bisogna aggiungere anche la c.

#Si imposta come titolo generale la variazione del LST nel tempo con la 
#funzione "main" (si mettono tra virgolette perchè si tratta di un testo):
levelplot(TGr,col.regions=cl, main="LST variation in time",
          names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

#"Melt", dati in riferimento allo scioglimento dei ghiacciai:
#Visto che si hanno tante immagini, si crea una lista con i file che hanno lo
#stesso "pattern":
meltlist <- list.files(pattern="melt")
#Si importano i file con la funzione "lapplay":
melt_import <- lapply(meltlist,raster)
#Si raggruppano tutti i file con la funzione "stack", mettendoli tutti insieme:
melt <- stack(melt_import)
#Per vedere informazioni più specifiche dei dati:
melt
#Si esegue un level plot con i dati melt:
levelplot(melt)
#Vengono rappresentati i valori di scioglimento dei ghiacci: più è alto 
#il valore, maggiore sarà lo scioglimento. Questo è possibile notarlo tra il
#primo anno (1979) e l'ultimo anno (2007), la striscia di ghiaccio che si è persa
#è molto più grande rispetto a quella del 1979.

#A tal proposito è possibile eseguire "METRICS ALGEBRA", ovvero algebra applicata
#a delle matrici.
#Si esegue la sottrazione tra il dato del 2007 e quello del 1979 a cui si associa un nome.
#Per legare i due tipi di dati, ovvero il file originale allo strato interno, si mette il $.
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt

#Si crea una nuova ColorRampPalette:
clb <- colorRampPalette(c("blue","white","red"))(100)
#I colori più bassi sono in blu, i colori medi in bianco, i colori alti in rosso.

#Si esegue prima un plot:
plot(melt_amount, col=clb)
#Tutte le zone rosse sono quelle dove dal 2007 al 1979 c'è stato uno scioglimento
#del ghiaccio più alto perchè si è sottratto dal melt del 2007 quello del 1979.

#Per vedere maggiori informazioni, come il minimo e il massimo si scrive:
melt_amount

#e poi un "levelplot":
levelplot(melt_amount, col.regions=clb)

#---------------------------------------------------------------------------------

#3. R code Copernicus data
#R_code_Copernicus.r
#Visualizing Copernicus data

#install.packages("raster") #serve per installare il pacchetto raster.
library(raster) #Viene caricato il pacchetto raster, non vengono messe le virgolette 
                #perchè è già in R.

install.packages("ncdf4") #serve per installare il pacchetto ncdf4 ed è la 
#libreria per leggere netCDF, si tratta di un formato di dati.
library(ncdf4) #Viene caricato il pacchetto ncdf4, non vengono messe le virgolette 
               #perchè è già in R.

#Si sceglie la cartella da dove si andranno a leggere i dati. Serve per impostare 
#la cartella di lavoro, nella quale verranno salvati/cercati di default i file.      
setwd("C:/lab/") # Windows

#Si assegna un nome da dare al dataset a cui viene associato la funzione
#"raster" perchè si tratta di un singolo layer.
albedo <-raster("c_gls_ALBH_202006130000_GLOBE_PROBAV_V1.5.1.nc")

#Si vedono tutte le informazioni del dataset:
albedo

#Si assegnano dei colori tramite un ColorRamPalette:
cl <- colorRampPalette(c('light blue','green','red','yellow'))(100) 
#Plot della variabile albedo:
plot(albedo, col=cl)
#Dal plot si nota che la zona rossa è dove viene riflessa più energia solare
#(ovviamente la parte dei deserti è quella che riflette di più, in quanto il 
#suolo è tutto esposto).

#Fase di RESAMPLING (ricampionamento):
#Questo dato è possibile ricampionarlo, ovvero diminuire la risoluzione con dei 
#pixel un pò più grandi. E' un metodo che viene adottato per velocizzare i tempi 
#di test di alcune analisi.
#Questo è possibile farlo utilizzando la funzione "aggregate" della variabile originale
#albedo con un certo fattore di ricampionamento (100), la quale poi viene assegnata 
#al nome albedores.
albedores <- aggregate(albedo, fact=100)
#Si è utilizzato un fattore 100, quindi un accorpamento di 10 000 volte il dato 
#originale, avendo così dei file in uscita molto più grezzi.

#Si esegue il plot con i colori precedenti:
plot(albedores, col=cl)

#--------------------------------------------------------------------------------

#4. R code knitr
#R_code_knitr.r

#Si sceglie la cartella dove si andranno a leggere i dati. Serve per impostare 
#la cartella di lavoro, nella quale verranno salvati/cercati di default i file. 
setwd("C:/lab/greenland") # Windows


#install.packages('knitr') #serve per installare il pacchetto knitr..
#install.packages('tinytex')
library (knitr) #Viene caricato il pacchetto knitr, non vengono messe le virgolette 
                #perchè è già in R.
library(tinytex) #Viene caricato il pacchetto tinytex.

#"knitr" è un pacchetto R che integra informatica e reporting. Incorporando il codice 
#nei documenti di testo, l'analisi, i risultati e la discussione sono tutti in un 
#unico posto. I file possono essere elaborati in una vasta gamma di formati di 
#documenti: pdf, documenti Word, presentazioni di diapositive e pagine Web.

#SINTESI: E' una funzione per la creazione di report automatici su piccola scala
#basata su uno script R e un modello. 

#La funzione che si utilizza è "snitch" a cui si aggiunge il primo argomento che 
#sarebbe il nome del file che si mette fra virgolette perchè si esce da R.

#L'altro argomento è il "tamplate" che si chiama "misc" e il file si chiama 
#"knitr-template.Rnw", dopodichè si aggiunge il pacchetto che si andrà ad utilizzare.
stitch("R_code_greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

#--------------------------------------------------------------------------------

#5. R code multivariate analysis
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
#ricampionamento (ovvero quante volte s vuole diminuire la risoluzione oppure 
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
dev.off()#funzione che serve per chiudere la finestra precedente.

#Si esegue un plotRGB con le prime 3 componenti principali:
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")
#immagine con tutte e 3 le componenti.

#Per plottare una singola componente, nel senso che si è plottata la prima PC1 
#contro la PC2 per vedere se fossero correlate tra loro e si nota che non c'è 
#nessuna correlazione. 
plot(p224r63_2011res_pca$map$PC1, p224r63_2011res_pca$map$PC2)

#Per vedere tutti i blocchi del file e quali informazioni possono dare sulla 
#struttura informatica del file si utilizza il comando "str":
str(p224r63_2011res_pca)

#--------------------------------------------------------------------------------

#6. R code classification
# R_code_classification.r

#Si sceglie la cartella da dove si andranno a leggere i dati. Serve per impostare 
#la cartella di lavoro, nella quale verranno salvati/cercati di default i file.
setwd("C:/lab/") # Windows

#Le librerie che servono per tale codice sono:
library(raster) #Viene caricato il pacchetto raster.
library(RStoolbox) #Viene caricato il pacchetto RStoolbox. 
#La funzione "brick" crea un oggetto RasterBrick, ovvero un oggetto raster 
#multistrato a cui si associa un nome (so-->solar orbiter).
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

#Per vedere i livelli e le varie informazioni:
so

#Visualize RGB levels.
#Per visualizzare i vari livelli si utilizza "plotRGB" e la prima cosa da mettere 
#è il nome dell'ogetto da plottare, ovvero l'immagine che si è appena inserita.
#Dopodichè si fa il plottaggio dei tre livelli (nella componente red si mette il 
#primo, nella componente green si mette il secondo e nella componente blu il 
#terzo livello). Inoltre, si aggiunge uno "stretch" dei valori lineare.
plotRGB(so, 1, 2, 3, stretch="lin")
#Si vede un livello dove le esplosioni sono maggiori (a destra), un livello 
#intermedio e un livello più basso scuro a sinistra.

#"UnsuperClass classification"--> classificzione non supervisionata, ovvero non 
#c'è nessun impatto da parte dell'utente di definire a monte le classi. 
#Si lascia al software definire i "training sets" direttamente sulla base delle
#riflettanze.

#La funzione che si utilizza è "unsuperClass". 
#Si tratta di una funzione che è all'interno di RStoolbox e opera sulla classificazione 
#non supervisionata.
#Viene strutturata in questo modo: si inserisce prima di tutto il nome 
#dell'immagine appena importata (so), poi si aggiunge il numero di classi.
#Prima di chiudere la funzione, la si associa ad un oggetto (soc).
soc <- unsuperClass(so, nClasses=3)
#Successivamente, si plotta l'immagine classificata (soc) insieme alla mappa (map):
plot(soc$map)
#L'immagine che uscirà fuori da questo plot non sarà sempre uguale, in quanto una
#volta lanciato il processo unsuperclass si è selezionato un training sets di 
#pixel in entrata.

#Per fare in modo che una classificazione sia sempre la stessa, si usa una 
#funzione che si chiama "set.seed".
set.seed(42)

#E' possibile aumentare il numero delle classi, ad esempio 20.
#Unsupervised Classification with 20 classes
soc20 <- unsuperClass(so, nClasses=20)
#Si aggiunge anche una colorRampPalette:
cl <- colorRampPalette(c('yellow','red','black'))(100)
#Si plotta l'immagine classificata (soe) insieme alla mappa (map):
plot(soc20$map)

# Download an image from:
# https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
#Si utilizza di nuovo la funzione "brick" che crea un oggetto "RasterBrick", ovvero
#un oggetto raster multistrato a cui si associa un nome (sun).
sun <- brick("sun.png")

#Unsupervised classification:
#Si parte facendo la classificazione di questa immagine, tenendo in considerazione 
#un numero di classi pari a 3.
sunc <- unsuperClass(sun, nClasses=3)
#Si plotta l'immagine classificata (sunc) insieme alla mappa (map):
plot(sunc$map)
#Da questo plot si vedono molto bene i livelli più energetici che si trovano 
#esternamente e una situazione intermedia che si trova al centro.
dev.off() #funzione che serve per chiudere la finestra precedente.

#Gran Canyon
#https://landsat.visibleearth.nasa.gov/view.php?id=80948
#When John Wesley Powell led an expedition down the Colorado River and through 
#the Grand Canyon in 1869, he was confronted with a daunting landscape. 
#At its highest point, the serpentine gorge plunged 1,829 meters (6,000 feet) 
#from rim to river bottom, making it one of the deepest canyons in the United States.
#In just 6 million years, water had carved through rock layers that collectively
#represented more than 2 billion years of geological history, nearly half of the 
#time Earth has existed.

#Le librerie che servono per tale codice sono:
library(raster) #Viene caricato il pacchetto raster.
library(RStoolbox) #Viene caricato il pacchetto RStoolbox.

#Si sceglie la cartella da dove si andranno a leggere i dati. Serve per impostare 
#la cartella di lavoro, nella quale verranno salvati/cercati di default i file.
setwd("C:/lab/") # Windows

#Si procede con il caricare l'immagine tramite la funzione "brick", in quanto si
#tratta di un immagine in RGB, formata da 3 livelli.
#(Si ulitzzano le virgolette perchè si esce da R, si prende l'immagine e la si 
#carica all'interno).In fine tale funzione si assegna ad un  oggetto (gc-->grand canyon).
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
#Per visualizzare l'immagine si utilizza il comando plotRGB, ovvero si ha un 
#oggetto Raster con più strati e con tale comando viene plottato.
plotRGB(gc, r=1, g=2, b=3, stretch="lin") #si utilizza lo stretch lineare per 
                                          #aumentare la potenza visiva di tutti 
                                          #i colori possibili
plotRGB(gc, r=1, g=2, b=3, stretch="hist") #si utilizza lo histogram stretching

#Si utilizza la funzione "unsuperClass" per classificare l'immagine che si sta 
#utilizzando e il numero di classi che in questo caso sono 2.
#Prima di chiudere la funzione, la si associa ad un oggetto (gcc2).
gcc2 <- unsuperClass(gc, nClasses=2)
#Per vedere le informazioni:
gcc2
#Per vedere il plot dell'immagine, si plotta l'immagine classificata (gcc2) 
#insieme alla mappa (map):
plot(gcc2$map)

#Come prima con l'unica differenza che si aggiungono più classi e a questa funzione
#viene associato un nome diverso rispetto al precedente (gcc4):
gcc4 <- unsuperClass(gc, nClasses=4)
#Per vedere le informazioni
gcc4
#Per vedere il plot dell'immagine, si plotta l'immagine appena classificata (gcc4) 
#insieme alla mappa (map):
plot(gcc4$map)

#--------------------------------------------------------------------------------

#7. R code ggplot2
#Si richiamano i pacchetti da installare e le librerie di cui si ha bisogno:
#install.packages("raster") #Viene installato il pacchetto raster.
library(raster) #Viene caricato il pacchetto raster.

#install.packages("RStoolbox") #Viene installato il pacchetto RStoolbox per 
                               #eseguire la classificazione.
library(RStoolbox)#Viene caricato il pacchetto RStoolbox.

#install.packages("ggplot2") #Viene installato il pacchetto ggplot2.
library(ggplot2) #Viene caricato il pacchetto ggplot2.

#install.packages("gridExtra") #Viene installato il pacchetto gridExtra.
library(gridExtra) #Viene caricato il pacchetto gridExtra per la disposizione 
                   #della griglia.

#Si sceglie la cartella da dove si andranno a leggere i dati. Serve per impostare 
#la cartella di lavoro, nella quale verranno salvati/cercati di default i file.
setwd("C:/lab/") # Windows

#Le bande sono divise in questo modo:
#B1=NIR: infrarosso vicino;
#B2=red;
#B3=green.

#Si utilizza la funzione "brick" che serve a caricare l'intero pacco di dati della
#prima immagine del 1992:
defor1 <-brick ("defor1.jpg")
#Vengono plottate le immagini con la funzione "plotRGB":
plotRGB(defor1, r=1, g=2, b=3, stretch="lin") #si utilizza uno strech lineare
#Vengono plottate le immagini con la funzione ggRGB:
ggRGB(defor1, r=1, g=2, b=3, stretch="lin") #si utilizza uno strech lineare.
#si ha la stessa immagine plottata con la funzione plotRGB ma con gli assi x ed 
#y e le varie coordinate spaziali dell'oggetto.

#Si procede con il caricare la seconda immagine del 2006 tramite la funzione "brick":
defor2 <-brick ("defor2.jpg")
#Vengono plottate le immagini con la funzione plotRGB:
plotRGB(defor2, r=1, g=2, b=3, stretch="lin") #si utilizza uno strech lineare
#Vengono plottate le immagini con la funzione ggRGB:
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")#si utilizza uno strech lineare.

#Vengono plottate le immagini con plotRGB e vengono disposte tramite la funzione
#par su 1 righe e 2 colonne:
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#E' possibile disporre le immagini anche per il "plot" della funzione ggRGB, non 
#più con "par" ma con un'altra funzione chiamata "grid.arrange".
#Multiframe with ggplot2 and gridExtra
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin") #si utilizza uno strech lineare.
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin") #si utilizza uno strech lineare.
#Tale funzione viene seguita da p1, p2 e numero di righe=2:
grid.arrange(p1, p2, nrow=2)

#--------------------------------------------------------------------------------

#8. R code vegetation indices
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

#--------------------------------------------------------------------------------

#9. R code land cover
#R_code_land_cover.r
#Le mappe di copertura del suolo rappresentano informazioni spaziali su diversi 
#tipi (classi) di copertura fisica della superficie terrestre, ad es. foreste, 
#praterie, colture, laghi, zone umide. 
#Le mappe dinamiche della copertura del suolo includono le transizioni delle 
#classi di copertura del suolo nel tempo e quindi, catturano i cambiamenti della
#copertura del suolo. Le mappe dell'uso del suolo contengono informazioni spaziali 
#sulle disposizioni, le attività e gli input che le persone intraprendono in un 
#determinato tipo di copertura del suolo per produrlo, modificarlo o mantenerlo.
#Le mappe annuali di copertura del suolo a risoluzione moderata mirano
#principalmente al rilevamento della copertura del suolo e ai loro cambiamenti.

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
                   #della griglia.

#Si sceglie la cartella da dove si andranno a leggere i dati. Serve per impostare 
#la cartella di lavoro, nella quale verranno salvati/cercati di default i file.
setwd("C:/lab/") # Windows

#Le bande sono divise in questo modo:
#B1=NIR,infrarosso vicino;
#B2=red;
#B3=green.

#Si utilizza la funzione "brick" che serve a caricare l'intero pacco di dati della
#prima immagine del 1992:
defor1 <-brick ("defor1.jpg")
#Vengono plottate le immagini con la funzione plotRGB:
plotRGB(defor1, r=1, g=2, b=3, stretch="lin") #si utilizza uno strech lineare
#Vengono plottate le immagini con la funzione ggRGB:
ggRGB(defor1, r=1, g=2, b=3, stretch="lin") #si utilizza uno strech lineare
#si ha la stessa immagine plottata con la funzione plotRGB ma con gli assi x ed 
#y e le varie coordinate spaziali dell'oggetto.

#Si procede con il caricare la seconda immagine del 2006 tramite la funzione "brick":
defor2 <-brick ("defor2.jpg")
#Vengono plottate le immagini con la funzione plotRGB:
plotRGB(defor2, r=1, g=2, b=3, stretch="lin") #si utilizza uno strech lineare.
#Vengono plottate le immagini con la funzione ggRGB:
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")#si utilizza uno strech lineare.

#Vengono plottate le immagini con plotRGB e vengono disposte tramite la funzione
#"par" su 1 riga e 2 colonne:
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#E' possibile disporre le immagini anche per il plot della funzione ggRGB, non 
#più con "par" ma con un'altra funzione chiamata "grid.arrange".
#Multiframe with ggplot2 and gridExtra
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin") #si utilizza uno strech lineare
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin") #si utilizza uno strech lineare
#Tale funzione viene seguita da p1, p2 e numero di righe=2
grid.arrange(p1, p2, nrow=2)

#Per la 1 IMMAGINE del 1992.
#Unsupervised classification--> Classificazione non supervisionata, significa 
#che fa tutto il sistema/software, in questo modo ques'ultimo crea le classi e 
#poi va avanti con la classificazione.
#La funzione unsuperClass ha come sintassi: (l'immagine da inserire, il numero
#di campioni che si lascerà di default, numero di calssi):
d1c <- unsuperClass(defor1, nClasses=2)
#Per avere informazioni su quello che si è appena creato:
d1c
#Viene plottata dc1 insieme alla mappa:
plot(d1c$map)
#Dal plot esce fuori che la clsse 1 indica foresta mentre la 
#classe 2: la zona agricola

#La funzione set.seed () permette di ottenere lo stesso risultato.

#Per la 2 IMMAGINE del 2006.
#unsupervised classification--> classificazione non supervisionata.
d2c <- unsuperClass(defor2, nClasses=2)
#Per avere informazioni su dc2:
d2c
#Viene plottata dc2 insieme alla mappa:
plot(d2c$map)
#Dal plot esce fuori che la classe 1 indica la parte agricola mentre la 
#classe 2: la foresta

#Classificazione con 3 classi:
d2c3 <- unsuperClass(defor2, nClasses=3)
#Viene plottata d2c3 insieme alla mappa:
plot(d2c3$map)
#Il giallo è la parte residua di foresta Amazzonica, invece la parte dell'agricolo
#l'ha divisa in due classi aggiuntive (una verde e una bianca).

#Si vuole calcolare la frequenza dei pixel di una certa classe per la prima
#immagine del 1992:
freq(d1c$map)
#Questi sono i valori che si ottengono:
#value  count
#[1,]     1 305195
#[2,]     2  36097

#Per calcolare la proporzione  della prima immagine del 1992 si esegue prima la somma dei 
#2 valori:
somma1 <- 305195 + 36097
somma1
#e poi si imposta la proporzione:
prop1 <- freq(d1c$map)/ somma1
#Per vedere i valori di "prop1":
prop1
#value     count
#[1,] 2.930042e-06 0.8954678 --> 89.54% di foresta
#[2,] 5.860085e-06 0.1045322 --> 10.45% di parte agricola

#Per fare la proporzione della seconda immagine del 2006 si vedono prima le informazioni:
defor2
#da cui esce fuori una somma di 342726
somma2 <-342726
#Per calcolare la proporzione dell'immagine del 2006:
prop2 <- freq(d2c$map)/ somma2
#Per vedere i valori di "prop1":
prop2
#value     count
#[1,] 2.917783e-06 0.4789861 --> 47.89% parte agricola
#[2,] 5.835565e-06 0.5210139 --> 52.10% foresta

#Si prosegue con il generare un dataframe.
#Build a dataframe
cover <- c("Forest", "Agricolture") #Si mette la "c" perchè si tratta di un vettore
                                    #composto da due diversi blocchi all'interno dello
                                    #stesso pezzo di codice.
percent_1992 <- c(89.54, 10.45)
percent_2006 <- c(52.10, 47.89)
#La funzione per creare un dataframe è-->data.frame a cui poi si assegna un nome.
percentages <- data.frame(cover, percent_1992, percent_2006)
#Se si vogliono vedere le informazioni:
percentages
#cover percent_1992 percent_2006
#1      Forest        89.54        52.10
#2 Agricolture        10.45        47.89

#Si esegue un grafico con ggplot per il 1992, più precisamente un grafico a barre.
#PRIMO PERIODO:
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
#Da questo plot si osserva che la parte agricola è molto meno rispetto alla foresta

#Plot dell'immagine del 2006
#SECONDO PERIODO:
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
#Da questo plot le due barre si sono molto avvicinate, la parte agricola è molto
#simile alla foresta.

#Si associano i plot appena eseguiti ad un nome:
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

#Funzione per assemblare più grafici su una stessa schermata:
grid.arrange(p1, p2, nrow=1)

#--------------------------------------------------------------------------------

#10. R code variability temp 
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

#--------------------------------------------------------------------------------

#11. R code NO2
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

#--------------------------------------------------------------------------------

#12. R code spetral signature
#R_code_spectral_signatures.r
#Le spectrak signature non sono altro che delle impronte digitali 
#delle immagini satellitari.

#Si richiamano i pacchetti da installare e le librerie di cui si ha bisogno:
#install.packages("raster") #Viene installato il pacchetto raster.
library(raster) #Viene caricato il pacchetto raster.

#install.packages("rgdal") #Viene installato il pacchetto rgdal che serve per 
                            #leggere qualsiasi tipo di dato.
library(rgdal) #Viene caricato il pacchetto rgdal

#install.packages("ggplot2") #Viene installato il pacchetto ggplot2.
library(ggplot2) #Viene caricato il pacchetto ggplot2.

#1.Set the working directory.
#Si sceglie la cartella da dove si andranno a leggere i dati. Serve per impostare 
#la cartella di lavoro, nella quale verranno salvati/cercati di default i file.
setwd("C:/lab/") # Windows

#Si esegue un "brick" in modo da caricare tutte le bande e si associa un nome:
defor2 <- brick("defor2.jpg")
#Se si vogliono vedere le informazioni:
defor2 #si nota che ci sono 3 bande: 
#defor2.1, defor2.2, defor2.3 e corrispondodo a:
#     NIR,      red,    green.

#Si esegue un plot di questa immagine:
plotRGB (defor2, r=1, g=2, b=3, stretch="lin")#tramite uno strech lineare.
#oppure
plotRGB (defor2, r=1, g=2, b=3, stretch="his")#facendo un histogram strech
#che invece di utilizzare una linea per trasformare e ampliare la gamma dei 
#valori, utilizza una curva (chiamata curva logistica) che aumenta la pendenza
#e quindi le differenze tra i due plot saranno molto più accentuate.

#La funzione per creare firme spettrali si chiama "click" che è contenuta 
#nel pacchetto "rgdal". Serve per cliccare sulla mappa e avere a disposizione 
#qualsiasi informazione (in questo caso informazioni relative alla riflettanza).
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow") #T=true, p=punto e pch=tipo di punto

#Results:
#Cliccando sulla mappa una zona vegetata si ottiene:
#      x     y   cell defor2.1 defor2.2 defor2.3
#1 273.5 151.5 234016      206        8       23   
#Si nota che la prima banda corrispondente al NIR ha un valore molto alto di 
#riflettanza, nella seconda banda che corrisponde al red si ha un valore basso 
#in quanto assorbe e nella terza banda che sarebbe quella del green si ha un 
#valore medio basso.

#Invece, cliccando su una zona dove è presente acqua si ottengono i seguenti risultati:
#      x     y   cell defor2.1 defor2.2 defor2.3
#1 572.5 245.5 166917       51       80      124   
#Si nota una riflettanza molto bassa in NIR, una rifrettanza alta in rosso e 
#molto alta nel verde.

#Bisogna chiudere l'immagine per poter proseguire.

#Si passa a creare un dataframe.
#Per creare un dataframe si fa uno storage dei dati.

#Si farà una tabellina con quattro colonne: nella prima e nella seconda si 
#inseriranno il numero delle bande, nella terza la componente foresta e nella
#quarta la componente acqua

#Define the columns of dataset.
#Si definiscono le colonne del dataset:
band <- c(1,2,3) #banda 1,2,3
forest <- c(206,8,23) #si inseriscono i valori riportati prima per la foresta
water <- c(51,80,124) #si inseriscono i valori riportati prima per l'acqua

#La funzione per fare la tabella è data.frame:
spectrals <- data.frame(band, forest, water)
#Per visualizzare la tabella:
spectrals 
#da cui si visualizzerà a video la tabella:
#band forest water
#   1    1    206    51
#   2    2      8    80
#   3    3     23   124


######## MULTITEMPORAL ###############
#Plot the spectral sign
#A questo punto si esegue un plot con ggplot2.
ggplot(spectrals, aes(x=band))+ #per il grafico si mette sull'asse delle x le bande e 
                                #sull'asse y le riflettanze della foresta e dell'acqua.
  geom_line(aes(y = forest), color ="green") + #geom_line connette le osservazioni
                                               #che si hanno a seconda del dato 
                                               #che si #è definito sulla x.
  geom_line(aes(y = water), color ="blue") + #da cui esce che l'acqua ha un comportamento
                                             #diametralmente opposto rispetto alla vegetazione.
  labs(x="band",y="reflectance") #si aggiungono le etichette agli assi.

#Si procede con il fare un'analisi multitemporale su una serie di pixel utilizzando 
#come immagini la defor1 e la defor2.
#Si carica l'immagine defor1:
defor1 <-brick("defor1.jpg")
#Si esegue un plot dell'immagine defor1 con plotRGB:
plotRGB (defor1, r=1, g=2, b=3, stretch="lin")#strech lineare.

#Spectral signatures defor1
#Si procede creando delle sprectral signatures dell'immagine defor1:
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, col="yellow") #T=true, p=punto e pch=tipo di punto

#Si preme in una zona dove c'è stata deforestazione (sopra la prima ansa del fiume)
#e si riportano i primi 5 valori.
#Results:
#     x     y  cell defor1.1 defor1.2 defor1.3
#1 59.5 340.5 97878      218       13       30
#     x     y  cell defor1.1 defor1.2 defor1.3
#1 88.5 340.5 97907      231       19       44
#     x     y   cell defor1.1 defor1.2 defor1.3
#1 98.5 327.5 107199      215       10       27
#     x     y  cell defor1.1 defor1.2 defor1.3
#1 92.5 376.5 72207      204       16       33
#     x     y  cell defor1.1 defor1.2 defor1.3
#1 72.5 390.5 62191      223       25       50
#     x     y   cell defor1.1 defor1.2 defor1.3
#1 156.5 289.5 134389      208       16       31

#Si esegue la stessa operazione per defor2 ma prima bisogna eseguire il plotRGB:
plotRGB (defor2, r=1, g=2, b=3, stretch="lin")#strech lineare.
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow") #T=true, p=punto e pch=tipo di punto
#Results:
#     x     y  cell defor2.1 defor2.2 defor2.3
#1 76.5 340.5 98306      192      173      166
#      x     y  cell defor2.1 defor2.2 defor2.3
#1 100.5 342.5 96896      206      181      176
#      x     y   cell defor2.1 defor2.2 defor2.3
#1 114.5 331.5 104797      171       73       70
#     x     y  cell defor2.1 defor2.2 defor2.3
#1 93.5 378.5 71077      207        5       21
#     x     y  cell defor2.1 defor2.2 defor2.3
#1 78.5 401.5 54571      193       11       23

#Ora si passa a creare il data.set
#Define the columns of dataset.
#Si definiscono le colonne del dataset:
band <- c(1,2,3) #banda 1,2,3.
time1<- c(218, 13,30) #si inseriscono i valori di defor1 per il primo risultato.
time2 <- c(192,173,166) #si inseriscono i valori di defor2 per il primo risultato.

#La funzione per fare la tabella è data.frame:
spectrals <- data.frame(band, time1, time2)
#Per visualizzare la tabella:
spectrals 
#da cui si visualizzerà a video la tabella:
#   band time1 time2
#1    1   218   192
#2    2    13   173
#3    3    30   166

#A questo punto si esegue un plot con ggplot2:
ggplot(spectrals, aes(x=band))+
  geom_line(aes(y = time1), color ="red") + 
  geom_line(aes(y = time2), color ="gray") + 
  labs(x="band",y="reflectance") #si aggiungono le etichette agli assi.

#Dal plot esce una situazione di questo tipo: il pixel del primo periodo (rosso)
#con pixel tipicamente vegetato che ha un'altissima riflettanza nel NIR e il pixel 
#del secondo momento (grigio). Nella parte del rosso dove prima si aveva un alto 
#assorbimento dovuto alla fotosintesi, in questo plot non c'è più.
#L'infrarosso è ancora alto percho non si è proprio nella zona del suolo nudo ma 
#piuttosto in una zona intermedia.

#A questa situazione è possibile aggiungere il secondo pixel:
band <- c(1,2,3) #banda 1,2,3
time1<- c(218,13,30) #si inseriscono i valori di defor1 per il primo pixel
time1p2<- c(231,19,44)#si inseriscono i valori di defor1 per il secondo pixel
time2 <- c(192,173,166) #si inseriscono i valori di defor2 per il primo pixel
time2p2<- c(206,181,176) #si inseriscono i valori di defor2 per il secondo pixel

#La funzione per fare la tabella è data.frame:
spectrals <- data.frame(band, time1,time1p2, time2,time1p2)
#Per visualizzare la tabella:
spectrals 
#da cui si visualizzerà a video la tabella:
#   band time1 time1p2 time2 time1p2.1
#1    1   218     231   192       231
#2    2    13      19   173        19
#3    3    30      44   166        44

ggplot(spectrals, aes(x=band))+
  geom_line(aes(y = time1), color ="red", linetype="dotted") +  #linetype serve per cambiare 
                                                                #il modo per visualizzare la linea.
  geom_line(aes(y = time1p2), color ="red") + 
  geom_line(aes(y = time2), color ="gray", linetype="dotted") + 
  geom_line(aes(y = time2p2), color ="gray") + 
  labs(x="band",y="reflectance")
#Si nota come si mantiene la stessa situazione.

#Image from Earth Observatory
#Si esegue lo stesso esercizio ma prendendo un'immagine da Earth Observatory
#e la si mette nella cartella lab.

#Si esegue un "brick" in modo da caricare tutte le bande e si associa un nome:
eo <- brick("June_puzzler.jpg")
#Si esegue un plot di questa immagine:
plotRGB (eo, r=1, g=2, b=3, stretch="his") #histogram strech

#Si procede creando delle sprectral signatures dell'immagine:
click(eo, id=T, xy=T, cell=T, type="p", pch=16, col="yellow") #T=true, p=punto e pch=tipo di punto
#Results:
#     x     y  cell june_puzzler.1 june_puzzler.2 june_puzzler.3
#1 96.5 378.5 72817            172            113              0
#     x     y   cell june_puzzler.1 june_puzzler.2 june_puzzler.3
#1 214.5 275.5 147095             11            150              0
#     x     y   cell june_puzzler.1 june_puzzler.2 june_puzzler.3
#1 187.5 318.5 116108             36             33             26

#Ora si passa a creare il data.set
#Define the columns of dataset.
#Si definiscono le colonne del dataset:
band <- c(1,2,3) #banda 1,2,3
stratumyellow <- c(172,113,0) #si inseriscono i valori dell'immagine per la zona yellow
stratumgreen <- c(11,150,0) #si inseriscono i valori dell'immagine per la zona green
stratumblue <- c(36,33,26) #si inseriscono i valori dell'immagine per la zona blue

#La funzione per fare la tabella è data.frame:
spectralsg <- data.frame(band, stratumyellow, stratumgreen, stratumblue)
#Per visualizzare la tabella:
spectralsg 
#da cui si visualizzerà a video la tabella:
#   band yellow green blue
#1    1    172    11   36
#2    2    113   150   33
#3    3      0     0   26

#A questo punto si esegue un plot con ggplot2:
ggplot(spectralsg, aes(x=band))+
  geom_line(aes(y = stratumyellow), color ="yellow")+ 
  geom_line(aes(y = stratumgreen), color ="green") + 
  geom_line(aes(y = stratumblue), color ="blue") 
  labs(x="band",y="reflectance")
#Si nota che le 3 formazioni che si sono individuate si differenziano molto.
