library(corrplot)

M = cor(mtcars)
M
corrplot(M, method="shade", type = "full", sig.level = 0.90, insig = "blank", 
         order = "hclust")

cor.test(mtcars)
