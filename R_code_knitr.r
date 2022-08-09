#R_code_knitr.r

#Si sceglie la cartella dove si andranno a leggere i dati. Serve per impostare 
#la cartella di lavoro, nella quale verranno salvati/cercati di default i file. 
setwd("C:/lab/greenland") # Windows


#install.packages('knitr') #serve per installare il pacchetto knitr, di utilizzano le 
                           #virgolette perchè si esce da R.
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
