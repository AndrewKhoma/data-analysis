salaries = read.csv(file = "C:/Users/NikitaSkybytskyi/Desktop/data-analysis/labs/lab-4/Salaries.csv", header = TRUE, sep=";", stringsAsFactors = TRUE)
salaries

#building model
summary(aov(formula = salary~rank, data = salaries))

summary(aov(formula = salary~sex, data = salaries))

summary(aov(formula = salary~rank+sex+sex:rank, data = salaries))

class(salaries[,"rank"])

unique(salaries[,"rank"])
