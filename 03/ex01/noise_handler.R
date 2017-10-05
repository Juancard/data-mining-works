#PARAMETERS:
# path to ruidoso.txt
DATASET_LOCATION = "/home/juan/Documentos/unlu/bdm/tps/TP03/ds/ruidoso.txt"
# path where the resulting .png files for each smoothing method will be saved
OUTPUT_FILES_LOCATION = "/home/juan/Documentos/unlu/bdm/data-mining-works/03/ex01/output/"

# read text file 
ruidoso <- read.csv(DATASET_LOCATION) 
# print data frame
View(ruidoso)

# a) data distribution
par(mfrow=c(2,2))
for(i in 2:5){
  barplot(ruidoso[,i], main = names(ruidoso)[i])
}
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

comparativeGraph <- function(ruidosoSmooth, method = "not specified", filename="smooth.png"){
  par(mfrow=c(4, 2))
  dev.copy(png,paste(OUTPUT_FILES_LOCATION, filename, sep=""), width=720,height=1024)
  for(i in 2:5){
    colName <- names(ruidoso)[i]
    yLim <- max(c(max(ruidoso[,i], na.rm = TRUE), max(ruidosoSmooth[,i-1], na.rm = TRUE)))
    plot(ruidoso[,i], main = paste(colName, " - Original"), ylim = c(0, yLim))
    plot(ruidosoSmooth[,i-1], main = paste(colName, " - ", method), ylim = c(0, yLim))
  }
  print(paste("File saved in: ", OUTPUT_FILES_LOCATION, filename, sep=""))
  dev.off()
}

# Exercise a.
numberOfBins <- 11
ruidoso.smooth.eqfreq = sapply(ruidoso[,2:5], equal_freq_smoothing, binSize=numberOfBins)
filename <- paste("equal_freq_smoothing_", numberOfBins, "bins.png", sep="")
comparativeGraph(ruidoso.smooth.eqfreq, filename = filename, method = "Equal freq. smoothing")

# Exercise b.
for (i in 2:10) {
  print(paste("BIN = ", i))
  filename <- paste("equal_width_smoothing_", i, "bins.png", sep="")
  ruidoso.smooth.eqwidth <- sapply(ruidoso[,2:5], equal_width_binning, given_breaks=i)
  comparativeGraph(ruidoso.smooth.eqwidth, filename = filename, method = "Equal freq. smoothing")
  print("***********************************************************************")
}
