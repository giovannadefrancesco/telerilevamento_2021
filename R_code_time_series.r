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
#lst-->land surface temperature:
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
