library(tidyverse)

cars

# one variable regression plot
ggplot(data = cars, aes(x = speed, y = dist)) + geom_point() + geom_smooth(method = "lm", se = FALSE)

# build model
lm.res = lm(formula = dist~speed, data = cars)
summary(lm.res)

# residuals
qqnorm(lm.res$residuals)
qqline(lm.res$residuals)

ggplot(data = lm.res, aes(x = lm.res$fitted, y = lm.res$residuals)) + geom_point()

# build model
lm.res.lin = lm(formula = dist~speed-1, data = cars)
summary(lm.res.lin)

# residuals
qqnorm(lm.res.lin$residuals)
qqline(lm.res.lin$residuals)
ggplot(data = lm.res.lin, aes(x = lm.res$fitted, y = lm.res$residuals)) + geom_point() + geom_smooth(method = "lm", se = FALSE)

cor.test(x = lm.res$fitted, y = lm.res$residuals)$estimate

# multivariate linear model
leaf.data = read.csv(file = "C:/Users/NikitaSkybytskyi/Desktop/data-analysis/labs/lab-3/leafshape.csv", stringsAsFactors = FALSE)

names(leaf.data)
# [1] "X" "bladelen"  "petiole" "bladewid"
# [5] "latitude"  "logwid"  "logpet"  "loglen"  
# [9] "arch"  "location"

xyz <- leaf.data[,2:4]
pairs(xyz, cols = 3)

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
