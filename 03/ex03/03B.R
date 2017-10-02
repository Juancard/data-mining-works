# read text file 
univ <- read.csv("/home/juan/Documentos/unlu/bdm/tps/TP03/ds/encuesta_universitaria.csv") 
# print data frame
View(univ)
tt <- univ[,5]
# remove null values
tt.no_null <- tt[!is.na(tt)]
# a) minmax normalization
tt.minmax <- (tt.no_null-min(tt.no_null))/(max(tt.no_null)-min(tt.no_null))
# b) z-score normalization
tt.zscore <- (tt.no_null - mean(tt.no_null)) / sd(tt.no_null)
# c) decimal scale normalization
tt.decimal_scale <- tt.no_null / 10000