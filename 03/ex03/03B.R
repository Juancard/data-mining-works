# read text file 
univ <- read.csv("/home/juan/Documentos/unlu/bdm/tps/TP03/ds/encuesta_universitaria.csv") 
# print data frame
View(univ)
tt <- univ[,5]
# remove null values
tt.no_null <- tt[!is.na(tt)]
# remove outliers
tt.no_outliers = tt.no_null[tt.no_null<300]
# distribution of original data
hist(tt.no_outliers, main = "Original")
# a) minmax normalization
tt.minmax <- (tt.no_outliers-min(tt.no_outliers))/(max(tt.no_outliers)-min(tt.no_outliers))
hist(tt.minmax, main = " Minmax")
# b) z-score normalization
tt.zscore <- (tt.no_outliers - mean(tt.no_outliers)) / sd(tt.no_outliers)
hist(tt.zscore, main = "Z-score")
# c) decimal scale normalization
tt.decimal_scale <- tt.no_outliers / 10000
hist(tt.decimal_scale, main = "Decimal Scale")