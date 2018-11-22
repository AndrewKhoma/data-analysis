library(tidyverse)
norm.data <- read.csv(file = "cats.csv",header = T, stringsAsFactors = F)
norm.data
x <- norm.data$Hwt
class(sort(x))

# p-p plot
mean = mean(norm.data$Hwt)
sd = sd(norm.data$Hwt)
x.ecdf = ecdf(x.sorted)
x.sorted = sort(x)
ggplot(data = norm.data, mapping = aes(x = x.ecdf(x.sorted), y = pnorm(q = sort(x), mean = mean, sd = sd))) + geom_point() + geom_abline(intercept = 0, slope = 1, size = 1)

#histogram
hist(x = x, breaks = 30)
# q-q plot
ggplot(data= norm.data, mapping = aes(sample = x)) + stat_qq() + stat_qq_line()
# box-plot
boxplot(x, horizontal = T, col = "turquoise")
sample_range = range(x)
cat(sprintf("mean = %f\n", mean(x)))
cat(sprintf("median = %f\n", median(x)))
cat(sprintf("variance = %f.4\n", var(x)))
cat(sprintf("standard deviation = %.4f\n", sd(x = x)))
cat(sprintf("coefficient of variation = %.4f\n", (sd(x = x)/mean(x = x))))
cat(sprintf("min value = %f.4\n", sample_range[1]))
cat(sprintf("max value = %f.4\n", sample_range[2]))
cat(sprintf("range of sample = %f.4\n", sample_range[2] - sample_range[1]))
cat(sprintf("kurtosis = %f.4\n", kurtosis(x = x)))
cat(sprintf("skewdness = %f.4\n", skewness(x = x)))

