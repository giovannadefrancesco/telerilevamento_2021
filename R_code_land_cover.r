#R_code_land_cover.r
#Le mappe di copertura del suolo rappresentano informazioni spaziali su diversi 
#tipi (classi) di copertura fisica della superficie terrestre, ad es. foreste, 
#praterie, colture, laghi, zone umide. 
#Le mappe dinamiche della copertura del suolo includono le transizioni delle 
#classi di copertura del suolo nel tempo e quindi catturano i cambiamenti della
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
#Vengono plottate le immagini con la funzione "plotRGB":
plotRGB(defor2, r=1, g=2, b=3, stretch="lin") #si utilizza uno strech lineare
#Vengono plottate le immagini con la funzione "ggRGB":
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")#si utilizza uno strech lineare.

#Vengono plottate le immagini con plotRGB e vengono disposte tramite la funzione
#"par" su una righe e due colonne:
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin") #si utilizza uno strech lineare
plotRGB(defor2, r=1, g=2, b=3, stretch="lin") #si utilizza uno strech lineare

#E' possibile disporre le immagini anche per il plot della funzione "ggRGB", non 
#più con "par" ma con un'altra funzione chiamata "grid.arrange".
#Multiframe with ggplot2 and gridExtra
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin") #si utilizza uno strech lineare
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin") #si utilizza uno strech lineare
#Tale funzione viene seguita da p1, p2 e numero di righe=2
grid.arrange(p1, p2, nrow=2)

#Per la 1 IMMAGINE del 1992.
#Unsupervised classification--> Classificazione non supervisionata, significa 
#che fa tutto il sistema/software, in questo modo quest'ultimo crea le classi e 
#poi va avanti con la classificazione.
#La funzione "unsuperClass" ha come sintassi: (l'immagine da inserire, il numero
#di campioni che si lascerà di default, numero di calssi):
d1c <- unsuperClass(defor1, nClasses=2)
#Per avere informazioni su quello che si è appena creato:
d1c
#Viene plottata dc1 insieme alla mappa:
plot(d1c$map)
#Dal plot esce fuori che la classe 1 indica foresta mentre la 
#classe 2: la zona agricola

#La funzione "set.seed" () permette di ottenere lo stesso risultato.

#Per la 2 IMMAGINE del 2006.
#unsupervised classification--> classificazione non supervisionata.
d2c <- unsuperClass(defor2, nClasses=2)
#Per avere informazioni su dc2
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
prop1 <- freq(d1c$map)/somma1
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
percentages <- data.frame(cover, percent_1992, percent_2006 )
percentages
#cover percent_1992 percent_2006
#1      Forest        89.54        52.10
#2 Agricolture        10.45        47.89

#Si esegue un grafico con "ggplot" per il 1992, più precisamente un grafico a barre
#PRIMO PERIODO
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
#Da questo plot si osserva che la parte agricola è molto meno rispetto alla foresta

#Plot dell'immagine del 2006
#SECONDO PERIODO
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
#Da questo plot le due barre si sono molto avvicinate, la parte agricola è molto
#simile alla foresta.

#Si associano i plot appena eseguiti ad un nome:
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

#Funzione per assemblare più grafici su una pagina:
grid.arrange(p1, p2, nrow=1)
#Nella prima data, quella del 1992 si avrà la foresta che è molto elevata come valore,
#mentre l'agricoltura ha un valore basso. La situazione è molto diversa nel secondo grafico,
#quello riferito al 2006, dove l'agricoltura e la foresta hanno quasi lo stesso valore. 



