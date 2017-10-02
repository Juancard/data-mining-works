# read text file 
ruidoso <- read.csv("/home/juan/Documentos/unlu/bdm/tps/TP03/ds/ruidoso.txt") 
# print data frame
View(ruidoso)
pairs(ruidoso[,c(-1)])
boxplot(ruidoso[,c(-1)])

#equal WIDTH!!
equal_width_binning <- function(the_vector, given_breaks) {
  factors <- cut(the_vector, breaks=given_breaks, dig.lab=7)
  mean_per_bin <- tapply(the_vector, factors, mean)
  mean_per_bin
}
#equal freq.
equal_freq_binning <- function(x, binSize) {
  desiredFrequency = floor(length(x)/binSize)
  bins <- split(sort(x), rep(1:binSize, rep(desiredFrequency, binSize)))
  bins
}
equal_freq_smoothing <- function(x, binSize){
  bins <- equal_freq_binning(x, binSize)
  mean_per_bin <- sapply(bins, mean)
  desiredFrequency = floor(length(x)/binSize)
  rep(mean_per_bin, each=desiredFrequency)
}
# Exercise a.
sapply(ruidoso[,2:5], equal_freq_smoothing, binSize=6)

# Exercise b.
for (i in 2:10) {
  print(paste("BIN = ", i))
  print(sapply(ruidoso[,2:5], equal_width_binning, given_breaks=i))
  print("***********************************************************************")
}
