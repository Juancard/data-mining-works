sup=read.csv("~/Documentos/unlu/bdm/tps/TP06/ds/supervisor-data-performance.csv")
#a.
View(sup)
str(sup)
#b.
plot(sup)
#c.
#LINEALIDAD
sup.cov = cor(sup)
fit = lm (y~., data = sup)
cofs = fit$coefficients
# INDEPENDENCIA
#install.packages(lmtest)
library(lmtest)
dwtest(y~., data=sup)
# HOMOCEDASTICIDAD
plot(fit$residuals, main = "Homocedasticidad")
# NORMALIDAD
## Normalidad de los residuos
qqnorm(fit$residuals, main = "Supuesto de normalidad") 
qqline(fit$residuals)
hist(fit$residuals, main = "Supuesto de normalidad")
shapiro.test(fit$residuals)
prediccion = function (x1,x2,x3,x4,x5,x6) {cofs[[1]]+x1*cofs[[2]]+x2*cofs[[3]]+x3*cofs[[4]]+x4*cofs[[5]]+x5*cofs[[6]]+x6*cofs[[7]]}
prediccion (54,31,62,90,77,41)
prediccion (59,44,71,80,72,44)
prediccion (62,39,65,82,74,43)
