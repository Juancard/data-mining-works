ani=read.csv("animals.csv")
ani.log = log(ani)
# a.
plot(ani.log[-c(1)]) # Gráficamente
# b
cor (ani[c(-1)])
# c.
## supuesto de linealidad
plot(ani.log[-c(1)]) # Gráficamente
cor(ani.log[-c(1)])  # Midiendo la fuerza de la relación
## Media 0
fit = lm (brain_weight ~ body_weight, data = ani.log)
mean(fit$residuals)
## Homocedasticidad
plot(fit$residuals, main = "Homocedasticidad") # No debería observarse ningún patrón en los residuos
## Normalidad de los residuos
qqnorm(fit$residuals, main = "Supuesto de normalidad") # Lo verificamos gráficamente
qqline(fit$residuals)
#d.
ani.log.brain.mean <- mean(ani.log$brain_weight)
ani.log.body.mean <- mean(ani.log$body_weight)
beta1 <- (sum((ani.log$body_weight - ani.log.body.mean) * (ani.log$brain_weight - ani.log.brain.mean))) / sum((ani.log$body_weight - ani.log.body.mean) ^ 2) 
beta0 <- ani.log.brain.mean - (beta1 * ani.log.body.mean)
# e)
plot(brain_weight ~ body_weight, data=ani.log, main="Recta de ajuste")
abline (fit, col="red")
# f)
summary (fit)
# g)
prediccion = function (body) {fit$coefficients[[1]]+body*fit$coefficients[[2]]}
prediccion(log(160))
prediccion(log(25))
prediccion(log(119))
log(160)
