# read text file 
eur <- read.csv("/home/juan/Documentos/unlu/bdm/tps/TP03/ds/europa.dat", sep = " ") 
# print data frame
View(eur)
# covarianza
eur.cov = cov(scale(eur))
# pca
pca1 <- prcomp(scale(eur))
# autovalores
eur.autoval <- pca1$sdev ^ 2
options(scipen=999)
eur.autoval
# autovectores
eur.autovect <- pca1$rotation
eur.autovect
# Porcentaje de varianza capturada
eur.porc_var <- cumsum(eur.autoval / sum(eur.autoval))
eur.porc_var
# c) gráfico de dispersion
plot(eur.autoval, xlab = "componentes", ylab = "varianza")
# d) gráfico biplot
biplot(pca1)
# generate strings to save in csv file
write.table(eur.cov, sep=";", dec = ",")
write.table(eur.autovect, sep=";", dec = ",")
