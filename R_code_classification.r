# R_code_classification.r

#Si sceglie la cartella da dove si andranno a leggere i dati. Serve per impostare 
#la cartella di lavoro, nella quale verranno salvati/cercati di default i file.
setwd("C:/lab/") # Windows

#Le librerie che servono per tale codice sono:
library(raster) #Viene caricato il pacchetto raster.
library(RStoolbox) #Viene caricato il pacchetto RStoolbox. 
#La funzione brick crea un oggetto RasterBrick, ovvero un oggetto raster 
#multistrato a cui si associa un nome (so-->solar orbiter).
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

#Per vedere i livelli e le varie informazioni:
so

#Visualize RGB levels.
#Per visualizzare i vari livelli si utilizza plotRGB e la prima cosa da mettere 
#è il nome dell'ogetto da plottare, ovvero l'immagine che si è appena inserita.
#Dopodichè si fa il plottaggio dei tre livelli (nella componente red si mette il 
#primo, nella componente green si mette il secondo e nella componente blu il 
#terzo livello). Inoltre, si aggiunge uno stretch dei valori lineare.
plotRGB(so, 1, 2, 3, stretch="lin")
#Si vede un livello dove le esplosioni sono maggiori (a destra), un livello 
#intermedio e un livello più basso scuro a sinistra.

#UnsuperClass classification--> classificzione non supervisionata, ovvero non 
#c'è nessun impatto da parte dell'utente di definire a monte le classi. Si lascia
#al software di definire i "training sets" direttamente sulla base delle
#riflettanze.

#La funzione che si utilizza è unsuperClass. Si tratta di una funzione che dentro
#RStoolbox opera la classificazione non supervisionata.
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
#funzione che si chiama set.seed.
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
#Si utilizza di nuovo la funzione brick che crea un oggetto RasterBrick, ovvero
#un oggetto raster multistrato a cui si associa un nome (sun).
sun <- brick("sun.png")

#Unsupervised classification
#Si parte facendo la classificazione di questa immagine, tenendo in considerazione 
#un numero di classi pari a 3.
sunc <- unsuperClass(sun, nClasses=3)
#Si plotta l'immagine classificata (sunc) insieme alla mappa (map):
plot(sunc$map)
#Da questo plot si vedono molto bene i livelli più energetici che si trovano 
#esternamente e una situazione intermedia che si trova al centro.
dev.off()

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

#Si procede con il caricare l'immagine tramite la funzione brick, in quanto si
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

#Si utilizza la funzione unsuperClass per classificare l'immagine che si sta 
#utilizzando e il numero di classi che in questo caso sono 2.
#Prima di chiudere la funzione, la si associa ad un oggetto (gcc2).
gcc2 <- unsuperClass(gc, nClasses=2)
#per vedere le informazioni:
gcc2
#per vedere il plot dell'immagine, si plotta l'immagine classificata (gcc2) 
#insieme alla mappa (map):
plot(gcc2$map)

#Come prima con l'unica differenza che si aggiungono più classi e a questa funzione
#viene associato un nome diverso rispetto al precedente (gcc4):
gcc4 <- unsuperClass(gc, nClasses=4)
#per vedere le informazioni
gcc4
#per vedere il plot dell'immagine, si plotta l'immagine appena classificata (gcc4) 
#insieme alla mappa (map):
plot(gcc4$map)
