# read text file 
ruidoso <- read.csv("/home/juan/Documentos/unlu/bdm/tps/TP03/ds/ruidoso.txt") 
# print data frame
View(ruidoso)

# a) data distribution
boxplot(ruidoso[,c(-1)])

#equal WIDTH!!
equal_width_binning <- function(the_vector, given_breaks) {
  factors <- cut(the_vector, breaks=given_breaks, dig.lab=7)
  mean_per_bin <- tapply(the_vector, factors, mean)
  for (i in 1:length(the_vector)){
    the_vector[i] <- mean_per_bin[factors[i]]
  }
  the_vector
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
  for (i in 1:length(x)){
    for (binNumber in 1:length(bins)){
      if (x[i] %in% unlist(bins[binNumber])){
        thisElementBin <- binNumber 
        break
      }
    }
    x[i] <- mean_per_bin[thisElementBin]
  }
  x
}

# Exercise a.
sapply(ruidoso[,2:5], equal_freq_smoothing, binSize=6)

# Exercise b.
for (i in 2:10) {
  print(paste("BIN = ", i))
  print(sapply(ruidoso[,2:5], equal_width_binning, given_breaks=i))
  print("***********************************************************************")
}