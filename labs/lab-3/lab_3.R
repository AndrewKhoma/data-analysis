library(tidyverse)

cars

# one variable regression plot
ggplot(data = cars, aes(x = speed, y = dist)) + geom_point() + geom_smooth(method = "lm", se = FALSE)

# build model
lm.res = lm(formula = dist~speed, data = cars)
summary(lm.res)
# Call:
# lm(formula = dist ~ speed, data = cars)
#
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -29.069  -9.525  -2.272   9.215  43.201 
#
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -17.5791     6.7584  -2.601   0.0123 *  
# speed         3.9324     0.4155   9.464 1.49e-12 ***
# ---
# Signif. codes:  
# 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
# Residual standard error: 15.38 on 48 degrees of freedom
# Multiple R-squared:  0.6511,	Adjusted R-squared:  0.6438 
# F-statistic: 89.57 on 1 and 48 DF,  p-value: 1.49e-12

# residuals
qqnorm(lm.res$residuals)
qqline(lm.res$residuals)

ggplot(data = lm.res, aes(x = lm.res$fitted, y = lm.res$residuals)) + geom_point()

# build model
lm.res.lin = lm(formula = dist~speed-1, data = cars)
summary(lm.res.lin)
# Call:
# lm(formula = dist ~ speed - 1, data = cars)
#
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -26.183 -12.637  -5.455   4.590  50.181 
#
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# speed   2.9091     0.1414   20.58   <2e-16 ***
# ---
# Signif. codes:  
# 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
# Residual standard error: 16.26 on 49 degrees of freedom
# Multiple R-squared:  0.8963,	Adjusted R-squared:  0.8942 
# F-statistic: 423.5 on 1 and 49 DF,  p-value: < 2.2e-16

# residuals
qqnorm(lm.res.lin$residuals)
qqline(lm.res.lin$residuals)
ggplot(data = lm.res.lin, aes(x = lm.res$fitted, y = lm.res$residuals)) + geom_point() + geom_smooth(method = "lm", se = FALSE)

cor.test(x = lm.res$fitted, y = lm.res$residuals)
#   Pearson's product-moment correlation
#
# data: lm.res$fitted and lm.res$residuals
# t = 3.207e-16, df = 48, p-value = 1
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
# -0.2783477  0.2783477
# sample estimates:
#  cor 
# 4.628907e-17

# multivariate linear model
leaf.data = read.csv(file = "C:/Users/NikitaSkybytskyi/Desktop/data-analysis/labs/lab-3/leafshape.csv", stringsAsFactors = FALSE)

names(leaf.data)
# [1] "X" "bladelen"  "petiole" "bladewid"
# [5] "latitude"  "logwid"  "logpet"  "loglen"  
# [9] "arch"  "location"

leaf.data[,2:4]
pairs(leaf.data[,2:4], cols = 3)

lm.leaf = lm(formula = petiole~bladelen + bladewid, data = leaf.data)
summary(lm.leaf)
# Call:
#   lm(formula = petiole ~ bladelen + bladewid, data = leaf.data)
#
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -13.3276  -0.8848   0.0212   0.8289  14.2905 
#
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -0.91120    0.29640  -3.074  0.00232 ** 
# bladelen    -0.26155    0.02253 -11.609  < 2e-16 ***
# bladewid     1.14051    0.03731  30.565  < 2e-16 ***
# ---
# Signif. codes:  
# 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
# Residual standard error: 2.273 on 283 degrees of freedom
# Multiple R-squared:  0.8148,	Adjusted R-squared:  0.8134 
# F-statistic: 622.4 on 2 and 283 DF,  p-value: < 2.2e-16

qqnorm(lm.leaf$residuals)
qqline(lm.leaf$residuals)
ggplot(data = lm.leaf, aes(x = lm.leaf$fitted, y = lm.leaf$residuals)) + geom_point() + geom_smooth(method = "lm", se = FALSE)
