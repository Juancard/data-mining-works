# read text file 
univ <- read.csv("/home/juan/Documentos/unlu/bdm/tps/TP03/ds/encuesta_universitaria.csv") 
# print data frame
View(univ)
tt.original <- univ[,5]
tt.mean_replace <- univ[,5]
# a) sustitution by mean
tt.mean <- mean(tt.mean_replace, na.rm = TRUE)
tt.mean_replace[is.na(tt.mean_replace)] <- tt.mean
# b) hot deck
# install.packages("hot.deck")
univ.no_nulls <- hot.deck(univ)
tt.hotdeck <- as.data.frame(univ.no_nulls$data)[,5]
# c) compare distributions
par(mfrow=c(1, 3))
hist(tt.original[tt.original<300], breaks=30, main = "Original", ylim=c(0,1800), xlab = "Tiempo de traslado")
hist(tt.mean_replace[tt.mean_replace<300], breaks=30, main = "Mean", ylim=c(0,1800), xlab = "Tiempo de traslado")
hist(tt.hotdeck[tt.mean_replace<300], breaks=30, main = "Hot-deck", ylim=c(0,1800), xlab = "Tiempo de traslado")
