zoo <- read.csv('~/Documentos/unlu/bdm/tps/TP_opcional/ds/zoo.csv', sep = ',')
library(e1071)
pred <- naiveBayes(zoo$type ~., data = zoo[-1])
pred
