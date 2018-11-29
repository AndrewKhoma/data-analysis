# install tidyverse:
# install.packages("tidyverse")

# import tidyverse:
library(tidyverse)

# for kurtosis function:
# install.packages("e1071")
library(e1071)

# change working directory to that of cats.csv:
# setwd("C:/Users/NikitaSkybytskyi/Desktop/data-analysis/labs/lab-1")

# read .csv with header and store in memory as norm.data
norm.data <- read.csv(file = "cats.csv", header = TRUE, stringsAsFactors = FALSE)
# norm.data

# Bwt is body weight and Hwt is heart weight:
x <- norm.data$Hwt
# x

# we will sort x to simplify further plotting:
x.sorted = sort(x)
# x.sorted

# basic stat for further usage:
stats <- data.frame(mean = mean(x), sd = sd(x), range = range(x))

# histogram
hist(x, breaks = 20)

# box plot
boxplot(x, horizontal = TRUE, col = "yellow")

# q-q plot
ggplot(data = norm.data, mapping = aes(sample = x)) + stat_qq() + stat_qq_line()

# p-p plot
x.ecdf = ecdf(x.sorted)
ggplot(
  data = norm.data,
  mapping = aes(x = x.ecdf(x.sorted), y = pnorm(q = x.sorted, mean = stats$mean, sd = stats$sd))
) + geom_point() + geom_abline(intercept = 0, slope = 1, size = 1)

cat(sprintf("Mean = %.4f\n", stats$mean))
# Mean = 10.6306

cat(sprintf("Median = %.4f\n", median(x)))
# Median = 10.1000

# Mode is not applicable

cat(sprintf("Variance = %.4f\n", var(x)))
# Variance = 5.9275

cat(sprintf("Standard deviation = %.4f\n", stats$sd))
# Standard deviation = 2.4346

cat(sprintf("Coefficient of variation = %.4f\n", stats$sd / stats$mean))
# Coefficient of variation = 0.2290

cat(sprintf("Min value = %.4f\n", stats$range[1]))
# Min value = 6.3000

cat(sprintf("Max value = %.4f\n", stats$range[2]))
# Max value = 20.5000

cat(sprintf("Range = %.4f\n", stats$range[2] - stats$range[1]))
# Range of sample = 14.2000

cat(sprintf("Skewness = %.4f\n", skewness(x)))
# Skewness = 0.8214

cat(sprintf("Kurtosis = %.4f\n", kurtosis(x)))
# Kurtosis = 1.0253
