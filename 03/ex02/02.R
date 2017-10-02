# read text file 
univ <- read.csv("/home/juan/Documentos/unlu/bdm/tps/TP03/ds/encuesta_universitaria.csv") 
# print data frame
View(univ)
tiempo_traslado <- univ[,5]
univ[,5] <- cut(tiempo_traslado, breaks=5, dig.lab=7)
univ[,5]
