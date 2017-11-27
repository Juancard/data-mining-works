llamadas=read.csv("llamadas.csv")
fit = lm (unidades ~ minutos, data = llamadas)
# a.
plot(llamadas[-c(1)]) # Gráficamente
# b.
cor (llamadas[c(-1)])
# c.
## supuesto de linealidad
plot(llamadas[-c(1)]) # Gráficamente
cor(llamadas[-c(1)])  # Midiendo la fuerza de la relación
## Media 0
mean(fit$residuals)
## Homocedasticidad
plot(fit$residuals, main = "Homocedasticidad") # No debería observarse ningún patrón en los residuos
## Normalidad de los residuos
qqnorm(fit$residuals, main = "Supuesto de normalidad") # Lo verificamos gráficamente
qqline(fit$residuals)
# d)
llamadas.min.mean <- mean(llamadas$minutos)
llamadas.uni.mean <- mean(llamadas$unidades)
beta1 <- (sum((llamadas$minutos - llamadas.min.mean) * (llamadas$unidades - llamadas.uni.mean))) / sum((llamadas$minutos - llamadas.min.mean) ^ 2) 
beta0 <- llamadas.uni.mean - (beta1 * llamadas.min.mean)
# e)
plot(llamadas$unidades ~ llamadas$minutos, data=llamadas, main="Recta de ajuste")
abline (fit, col="red")
# f)
summary (fit)
# g)
prediccion = function (minutos) {fit$coefficients[[1]]+minutos*fit$coefficients[[2]]}
prediccion(160)
prediccion(25)
prediccion(119)