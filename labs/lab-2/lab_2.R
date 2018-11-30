# install.packages("corrplot")
library(corrplot)

# load built-in dataset mtcars
M <- cor(mtcars)
# M

res <- cor.mtest(mtcars, conf.level = .95)

# specialized the insignificant value according to the significant level
corrplot(
  M,
  p.mat = res$p, 
  sig.level = .05,
  order = "hclust", 
  addrect = 3
)

cor.test(
  mtcars$mpg, 
  mtcars$cyl,
  alternative = "two.sided",
  method = "pearson",
  conf.level = 0.95
)

cor.test(
  mtcars$mpg, 
  mtcars$cyl,
  alternative = "greater",
  method = "kendall",
  conf.level = 0.9,
  exact = FALSE
)

cor.test(
  mtcars$mpg, 
  mtcars$cyl,
  alternative = "less",
  method = "spearman",
  conf.level = 0.8,
  exact = FALSE
)