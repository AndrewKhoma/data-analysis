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

xyz <- leaf.data[,2:4]
pairs(xyz, cols = 3)

lm.leaf = lm(formula = petiole~bladelen + bladewid, data = leaf.data)
summary(lm.leaf)

qqnorm(lm.leaf$residuals)
qqline(lm.leaf$residuals)

ggplot(data = lm.leaf, aes(x = lm.leaf$fitted, y = lm.leaf$residuals)) + geom_point() + geom_smooth(method = "lm", se = FALSE)
