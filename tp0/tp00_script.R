summary(iris)
table(iris$Species)
pie(table(iris$Species))
str(iris)
# media de cada atributo de iris
sapply(iris, mean)
barplot(table(iris$Species))
# calcular moda
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
# calcular moda para cada atributo de iris excepto el ultimo
sapply(iris[,1:4], getmode)
View(iris)
aggregate(Petal.Length ~ Species, data=iris, FUN=median)
# media de cada atributo numerico agrupado por variedad:
aggregate(x=iris[,1:4], by=list(iris$Species), FUN=mean)
# standard deviation de cada variable
sapply(iris[,1:4], sd)
# varianza
sapply(iris[,1:4], var)
#range
sapply(iris[,1:4], range)
#boxplot
boxplot(iris[,1:4])
# scatter plot of all attributes in pairs
pairs(iris[,1:4],col=iris$Species)
#