library(cluster)
trigo <- read.csv("/home/juan/Documentos/unlu/bdm/tps/TP05/ds_clusters/trigo.csv", sep = ";") 
#7)a.
hc <- hclust(dist(trigo), method = "single", members = NULL)
#7)b.
plot(hc, hang = -1)
#7)c.
dianac <- diana(trigo, stand=TRUE)
#7)d.
plot(dianac, hang = -1)
