#R_code_knitr.r

#Si sceglie la cartella da dove si andranno a leggere i dati
setwd("C:/lab/") # Windows


# install.packages("knitr")
library (knitr)

# E' una funzione per la creazione di report automatici su piccola scala basata su uno script R e un modello. 
stitch("R_code_Greenland.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
