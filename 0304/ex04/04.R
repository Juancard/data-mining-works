library (arules)
bank <- read.csv("/home/juan/Documentos/unlu/bdm/tps/TP07/ds/04/bank-full.csv", sep = ";") 

#a)
bank$age <- cut(bank$age, breaks=c(17, 29, 39, 49, 59, 69, max(bank$previous)), dig.lab=7)
bank$balance <- cut(bank$balance, breaks=c(min(bank$balance) - 1, -1, 0, 500, 1500, max(bank$balance)), dig.lab=7)
bank$day = discretize(bank$day)
bank$duration = cut(bank$duration, breaks=c(0, 60, 60 * 5, 60 * 10, max(bank$duration)), dig.lab=7)
bank$campaign = cut(bank$campaign, breaks=c(0, 1, 5, max(bank$campaign)), dig.lab=7)
bank$pdays = cut(bank$pdays, breaks=c(-1.1, -1, 90, 180, 365, max(bank$pdays)), dig.lab=7)
bank$previous = cut(bank$previous, breaks=c(-0.1, 0, 1, 5, max(bank$previous)), dig.lab=7)

#b)
rules <- apriori(bank, list("confidence"=0.4, "support"=0.1))
inspect(head(sort(rules, by="lift"),10))

#c)
df_reglas<-data.frame(
  lhs = labels(lhs(rules)),
  rhs = labels(rhs(rules)), 
  rules@quality)

term_deposit_rules = df_reglas[c(grep('\\{y=' ,df_reglas$rhs)),]
attach(term_deposit_rules)
term_deposit_rules = term_deposit_rules[order(-lift),]
View(term_deposit_rules)
#write.csv(head(term_deposit_rules, 200), file = "rules.csv")
