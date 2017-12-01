library(e1071)

zoo <- read.csv('zoo.csv', sep = ',')
model <- naiveBayes(zoo$type ~., data = zoo[-1])
model$tables

random_zoo <- read.csv('zoo_random_instances.csv', sep = ',')
preds <- predict(model, newdata = random_zoo[-1])
table(preds, random_zoo$type)