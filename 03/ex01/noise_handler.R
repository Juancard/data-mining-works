# read text file 
ruidoso <- read.csv("/home/juan/Documentos/unlu/bdm/tps/TP03/ds/ruidoso.txt") 
# print data frame
View(ruidoso)
pairs(ruidoso[,c(-1)])
boxplot(ruidoso[,c(-1)])

road55 = ruidoso[order(ruidoso$Road_55dB),]$Road_55dB
#equal WIDTH!!
equal_width_binning <- function(the_vector, given_breaks) {
  factors <- cut(the_vector, breaks=given_breaks, dig.lab=7)
  mean_per_bin <- tapply(the_vector, factors, mean)
  mean_per_bin
}

for (i in 2:10) {
  print(paste("BIN = ", i))
  print(sapply(ruidoso[,2:5], equal_width_binning, given_breaks=i))
  print("***********************************************************************")
}
