library (arules)
# a.
help ("APparameter")

# b.
data (Groceries)
groc <- Groceries
reglas <- apriori (groc, list("confidence"=0.1, "support"=0.006))

#c.
inspect(head(sort(reglas, by="lift"),10))
lala<-data.frame(
  lhs = labels(lhs(reglas)),
  rhs = labels(rhs(reglas)), 
  reglas@quality)

#f.
df_reglas[c(grep('beer' ,df_reglas$lhs), grep('beer' ,df_reglas$rhs)),]
help(apriori)
