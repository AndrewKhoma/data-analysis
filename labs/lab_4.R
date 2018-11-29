load()
UCBAdmissions
class(UCBAdmissions)
ChickWeight
Orange
max(ChickWeight[,3])

salaries = read.csv(file = "C:/R_Projects/Lab_1/Salaries.csv", header = T, sep = ",",stringsAsFactors = T)
salaries
#building model
summary(aov(formula = salary~rank, data = salaries))
summary(aov(formula = salary~sex, data = salaries))
summary(aov(formula = salary~rank+sex+sex:rank, data = salaries))

class(salaries[,"rank"])
unique(salaries[,"rank"])
