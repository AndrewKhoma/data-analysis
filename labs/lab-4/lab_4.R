salaries = read.csv(file = "C:/Users/NikitaSkybytskyi/Desktop/data-analysis/labs/lab-4/Salaries.csv", header = TRUE, sep=";", stringsAsFactors = TRUE)
# salaries

#building model
summary(aov(formula = salary~rank, data = salaries))
#              Df    Sum Sq   Mean Sq F value Pr(>F)    
# rank          2 1.432e+11 7.162e+10   128.2 <2e-16 ***
# Residuals   394 2.201e+11 5.586e+08                   
# ---
# Signif. codes:  
# 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

summary(aov(formula = salary~sex, data = salaries))
#              Df    Sum Sq   Mean Sq F value  Pr(>F)   
# sex           1 6.980e+09 6.980e+09   7.738 0.00567 **
# Residuals   395 3.563e+11 9.021e+08                   
# ---
# Signif. codes:  
# 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

summary(aov(formula = salary~rank+sex+sex:rank, data = salaries))
#              Df    Sum Sq   Mean Sq F value Pr(>F)    
# rank          2 1.432e+11 7.162e+10 127.755 <2e-16 ***
# sex           1 8.408e+08 8.408e+08   1.500  0.221    
# rank:sex      2 4.360e+07 2.180e+07   0.039  0.962    
# Residuals   391 2.192e+11 5.606e+08                   
# ---
# Signif. codes:  
# 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

class(salaries[,"rank"])
# [1] "factor"

unique(salaries[,"rank"])
# [1] Prof      AsstProf  AssocProf
# Levels: AssocProf AsstProf Prof
