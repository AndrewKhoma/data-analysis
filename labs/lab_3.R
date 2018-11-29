library(tidyverse)

#one variable regression
#plot
cars
ggplot(data = cars,aes(x = speed, y = dist)) + geom_point() + geom_smooth(method="lm", se =F)

#build model
lm.res = lm(formula = dist~speed, data = cars)
summary(lm.res)
#residuals
qqnorm(lm.res$residuals)
qqline(lm.res$residuals)
ggplot(data = lm.res, aes(x = lm.res$fitted, y = lm.res$residuals)) + geom_point()
#build model
lm.res.lin = lm(formula = dist~speed-1, data = cars)
summary(lm.res.lin)
#residuals
qqnorm(lm.res.lin$residuals)
qqline(lm.res.lin$residuals)
ggplot(data = lm.res.lin, aes(x = lm.res$fitted, y = lm.res$residuals)) + geom_point() + geom_smooth(method = "lm", se = F)
cor.test(x = lm.res$fitted, y = lm.res$residuals)

#multivariate linear model
leaf.data = read.csv(file = "C:/R_Projects/Lab_1/leafshape.csv", stringsAsFactors = F)

names(leaf.data)
leaf.data[,2:4]
pairs(leaf.data[,2:4], cols = 3)
lm.leaf = lm(formula = petiole~bladelen + bladewid, data = leaf.data)
summary(lm.leaf)
qqnorm(lm.leaf$residuals)
qqline(lm.leaf$residuals)
ggplot(data = lm.leaf,aes(x = lm.leaf$fitted, y = lm.leaf$residuals)) + geom_point() + geom_smooth(method="lm", se = F)#+ coord_cartesian(xlim = c(-5, 5), ylim = c(-3, 10))

