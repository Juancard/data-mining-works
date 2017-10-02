# read text file 
univ <- read.csv("/home/juan/Documentos/unlu/bdm/tps/TP03/ds/encuesta_universitaria.csv") 
# print data frame
View(univ)
tt <- univ[,5]
# a) sustitution by mean
tt.mean <- mean(tt, na.rm = TRUE)
tt[is.na(tt)] <- tt.mean
# b) hot deck
hot.deck(data, m = 5, method = c("best.cell", "p.draw"))
