# install.packages("corrplot")
library(corrplot)

# load built-in dataset mtcars
M <- cor(mtcars)
# M

corrplot(
  M, 
  method = "circle", 
  type = "full", 
  sig.level = 0.90, 
  insig = "blank", 
  order = "hclust"
)

cor.test(mtcars$mpg, mtcars$cyl)
