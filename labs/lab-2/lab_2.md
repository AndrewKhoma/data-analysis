# An Introduction to corrplot Package

## Introduction

The **corrplot** package is a graphical display of a correlation matrix, confidence interval. It also contains some algorithms to do matrix reordering. In addition, corrplot is good at details, including choosing color, text labels, color labels, layout, etc.

## Visualization methods

There are seven visualization methods (parameter `method`) in **corrplot** package, named `"circle"`, `"square"`, `"ellipse"`, `"number"`, `"shade"`, `"color"`, `"pie"`.

Positive correlations are displayed in blue and negative correlations in red color. Color intensity and the size of the circle are proportional to the correlation coefficients.

```R
library(corrplot)
## corrplot 0.84 loaded
M <- cor(mtcars)
corrplot(M, method = "circle")
```

![plt-1](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-1.png)

```R
corrplot(M, method = "square")
```

![plt-2](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-2.png)

```R
corrplot(M, method = "ellipse")
```

![plt-3](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-3.png)

```R
corrplot(M, method = "number") # Display the correlation coefficient
```

![plt-4](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-4.png)

```R
corrplot(M, method = "shade")
```

![plt-5](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-5.png)

```R
corrplot(M, method = "color")
```

![plt-6](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-6.png)

```R
corrplot(M, method = "pie")
```

![plt-7](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-7.png)

## Layout

There are three layout types (parameter `type`):

* `"full"` (default) : display full **correlation matrix**
* `"upper"` : display upper triangular of the **correlation matrix**
* `"lower"` : display lower triangular of the **correlation matrix**

```R
corrplot(M, type = "upper")
```

![plt-8](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-8.png)

`corrplot.mixed()` is a wrapped function for mixed visualization style.

```R
corrplot.mixed(M)
```

![plt-9](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-9.png)

```R
corrplot.mixed(M, lower.col = "black", number.cex = .7)
```

![plt-10](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-10.png)

```R
corrplot.mixed(M, lower = "ellipse", upper = "circle")
```

![plt-11](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-11.png)

```R
corrplot.mixed(M, lower = "square", upper = "circle", tl.col = "black")
```

![plt-12](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-12.png)

## Reorder a correlation matrix

The correlation matrix can be reordered according to the correlation coefficient. This is important to identify the hidden structure and pattern in the matrix. There are four methods in corrplot (parameter order), named `"AOE"`, `"FPC"`, `"hclust"`, `"alphabet"`. More algorithms can be found in seriation package.

You can also reorder the matrix “manually” via function `corrMatOrder()`.

* `"AOE"` is for the angular order of the eigenvectors. It is calculated from the order of the angles $a_i$,
$$ a_i = \begin{cases} \tan(e_{i2} / e_{i1}), & \text{if } e_{i1} > 0; \\ \tan(e_{i2} * e_{i1}) + \pi, \text{otherwise}. \end{cases}$$
where $e_1$ and $e_2$ are the largest two eigenvalues of the correlation matrix. See Michael Friendly (2002) for details.

* `"FPC"` for the first principal component order.

* `"hclust"` for hierarchical clustering order, and `"hclust.method"` for the agglomeration method to be used. `"hclust.method"` should be one of `"ward"`, `"single"`, `"complete"`, `"average"`, `"mcquitty"`, `"median"` or `"centroid"`.

* `"alphabet"` for alphabetical order.

```R
corrplot(M, order = "AOE")
```

![plt-13](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-13.png)

```R
corrplot(M, order = "hclust")
```

![plt-14](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-14.png)

```R
corrplot(M, order = "FPC")
```

![plt-15](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-15.png)

```R
corrplot(M, order = "alphabet")
```

![plt-16](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-16.png)

If using `"hclust"`, `corrplot()` can draw rectangles around the chart of corrrlation matrix based on the results of hierarchical clustering.

```R
corrplot(M, order = "hclust", addrect = 2)
```

![plt-17](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-17.png)

```R
corrplot(M, order = "hclust", addrect = 3)
```

![plt-18](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-18.png)

```R
# Change background color to lightblue
corrplot(M, type = "upper", order = "hclust", col = c("black", "white"), bg = "lightblue")
```

![plt-19](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-19.png)

## Using different color spectra
As shown in the above section, the color of the correlogram can be customized. The function `colorRampPalette()` is very convenient for generating color spectrum.

```R
col1 <- colorRampPalette(c("#7F0000", "red", "#FF7F00", "yellow", "white", "cyan", "#007FFF", "blue", "#00007F"))
col2 <- colorRampPalette(c("#67001F", "#B2182B", "#D6604D", "#F4A582", "#FDDBC7", "#FFFFFF", "#D1E5F0", "#92C5DE", "#4393C3", "#2166AC", "#053061"))
col3 <- colorRampPalette(c("red", "white", "blue")) 
col4 <- colorRampPalette(c("#7F0000", "red", "#FF7F00", "yellow", "#7FFF7F", "cyan", "#007FFF", "blue", "#00007F"))
whiteblack <- c("white", "black")
```

```R
## using these color spectra
corrplot(M, order = "hclust", addrect = 2, col = col1(100))
```

![plt-20](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-20.png)

```R
corrplot(M, order = "hclust", addrect = 2, col = col2(50))
```

![plt-21](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-21.png)

```R
corrplot(M, order = "hclust", addrect = 2, col = col3(20))
```

![plt-22](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-22.png)

```R
corrplot(M, order = "hclust", addrect = 2, col = col4(10))
```

![plt-23](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-23.png)

```R
corrplot(M, order = "hclust", addrect = 2, col = whiteblack, bg = "gold2")
```

![plt-24](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-24.png)

You can also use the standard color palettes (package 'grDevices')

```R
corrplot(M, order = "hclust", addrect = 2, col = heat.colors(100))
```

![plt-25](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-25.png)

```R
corrplot(M, order = "hclust", addrect = 2, col = terrain.colors(100))
```

![plt-26](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-26.png)

```R
corrplot(M, order = "hclust", addrect = 2, col = cm.colors(100))
```

![plt-27](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-27.png)

```R
corrplot(M, order = "hclust", addrect = 2, col = gray.colors(100))
```

![plt-28](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-28.png)

Other option would be to use `RcolorBrewer` package.

```R
library(RColorBrewer)

corrplot(M, type = "upper", order = "hclust", col = brewer.pal(n = 8, name = "RdBu"))
```

![plt-29](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-29.png)

```R
corrplot(M, type = "upper", order = "hclust", col = brewer.pal(n = 8, name = "RdYlBu"))
```

![plt-30](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-30.png)

```R
corrplot(M, type = "upper", order = "hclust", col = brewer.pal(n = 8, name = "PuOr"))
```

![plt-31](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-31.png)

## Changing color and rotation of text labels and legend

Parameter `cl.*` is for color legend, and `tl.*` is for text legend. For the text label, `tl.col` (text label color) and `tl.srt` (text label string rotation) are used to change text colors and rotations.

Here are some examples.

```R
## remove color legend and text legend 
corrplot(M, order = "AOE", cl.pos = "n", tl.pos = "n")  
```

![plt-32](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-32.png)

```R
## bottom  color legend, diagonal text legend, rotate text label
corrplot(M, order = "AOE", cl.pos = "b", tl.pos = "d", tl.srt = 60)
```

![plt-33](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-33.png)

```R
## a wider color legend with numbers right aligned
corrplot(M, order = "AOE", cl.ratio = 0.2, cl.align = "r")
```

![plt-34](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-34.png)

```R
## text labels rotated 45 degrees
corrplot(M, type = "lower", order = "hclust", tl.col = "black", tl.srt = 45)
```

![plt-35](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-35.png)

## Dealing with a non-correlation matrix

```R
corrplot(abs(M), order = "AOE", col = col3(200), cl.lim = c(0, 1))
```

![plt-36](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-36.png)

```R
## visualize a  matrix in [-100, 100]
ran <- round(matrix(runif(225, -100,100), 15))
corrplot(ran, is.corr = FALSE, method = "square")
```

![plt-37](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-37.png)

```R
## a beautiful color legend 
corrplot(ran, is.corr = FALSE, method = "ellipse", cl.lim = c(-100, 100))
```

![plt-38](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-38.png)

If your matrix is rectangular, you can adjust the aspect ratio with the `win.asp` parameter to make the matrix rendered as a square.

```R
ran <- matrix(rnorm(70), ncol = 7)
corrplot(ran, is.corr = FALSE, win.asp = .7, method = "circle")
```

![plt-39](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-39.png)

## Dealing with missing (NA) values

By default, **corrplot** renders NA values as `"?"` characters. Using `na.label` parameter, it is possible to use a different value (max. two characters are supported).

```R
M2 <- M
diag(M2) = NA
corrplot(M2)
```

![plt-40](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-40.png)

```R
corrplot(M2, na.label = "o")
```

![plt-41](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-41.png)

```R
corrplot(M2, na.label = "NA")
```

![plt-42](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-42.png)

## Using “plotmath” expressions in labels

Since version 0.78, it is possible to use plotmath expression in variable names. To activate plotmath rendering, prefix your label with one of the characters `":"`, `"="` or `"$"`.

```R
M2 <- M[1:5,1:5]
colnames(M2) <- c("alpha", "beta", ":alpha+beta", ":a[0]", "=a[beta]")
rownames(M2) <- c("alpha", "beta", NA, "$a[0]", "$ a[beta]")
corrplot(M2)
```

![plt-43](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-43.png)

## Combining correlogram with the significance test

```R
res1 <- cor.mtest(mtcars, conf.level = .95)
res2 <- cor.mtest(mtcars, conf.level = .99)

## specialized the insignificant value according to the significant level
corrplot(M, p.mat = res1$p, sig.level = .2)
```

![plt-44](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-44.png)

```R
corrplot(M, p.mat = res1$p, sig.level = .05)
```

![plt-45](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-45.png)

```R
corrplot(M, p.mat = res1$p, sig.level = .01)
```

![plt-46](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-46.png)

```R
## leave blank on no significant coefficient
corrplot(M, p.mat = res1$p, insig = "blank")
```

![plt-47](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-47.png)

```R
## add p-values on no significant coefficient
corrplot(M, p.mat = res1$p, insig = "p-value")
```

![plt-48](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-48.png)

```R
## add all p-values
corrplot(M, p.mat = res1$p, insig = "p-value", sig.level = -1)
```

![plt-49](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-49.png)

```R
## add cross on no significant coefficient 
corrplot(M, p.mat = res1$p, order = "hclust", insig = "pch", addrect = 3)
```

![plt-50](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-50.png)

## Visualize confidence interval
```R
corrplot(M, low = res1$lowCI, upp = res1$uppCI, order = "hclust", rect.col = "navy", plotC = "rect", cl.pos = "n")
```

![plt-51](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-51.png)

```R
corrplot(M, p.mat = res1$p, low = res1$lowCI, upp = res1$uppCI, order = "hclust", pch.col = "red", sig.level = 0.01, addrect = 3, rect.col = "navy", plotC = "rect", cl.pos = "n")
```

![plt-52](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-52.png)

```R
res1 <- cor.mtest(mtcars, conf.level = .95)

corrplot(M, p.mat = res1$p, insig = "label_sig", sig.level = c(.001, .01, .05), pch.cex = .9, pch.col = "white")
```

![plt-53](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-53.png)

```R
corrplot(M, p.mat = res1$p, method = "color", insig = "label_sig", pch.col = "white")
```

![plt-54](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-54.png)

```R
corrplot(M, p.mat = res1$p, method = "color", type = "upper", sig.level = c(.001, .01, .05), pch.cex = .9, insig = "label_sig", pch.col = "white", order = "AOE")
```

![plt-55](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-55.png)

```R
corrplot(M, p.mat = res1$p, insig = "label_sig", pch.col = "white", pch = "p<.05", pch.cex = .5, order = "AOE")
```

![plt-56](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-56.png)

## Customize the correlogram

```R
# matrix of the p-value of the correlation
p.mat <- cor.mtest(mtcars)$p
head(p.mat[, 1:5])
##              [,1]         [,2]         [,3]         [,4]         [,5]
## [1,] 0.000000e+00 6.112687e-10 9.380327e-10 1.787835e-07 1.776240e-05
## [2,] 6.112687e-10 0.000000e+00 1.802838e-12 3.477861e-09 8.244636e-06
## [3,] 9.380327e-10 1.802838e-12 0.000000e+00 7.142679e-08 5.282022e-06
## [4,] 1.787835e-07 3.477861e-09 7.142679e-08 0.000000e+00 9.988772e-03
## [5,] 1.776240e-05 8.244636e-06 5.282022e-06 9.988772e-03 0.000000e+00
## [6,] 1.293959e-10 1.217567e-07 1.222320e-11 4.145827e-05 4.784260e-06
# Specialized the insignificant value according to the significant level
corrplot(M, type = "upper", order = "hclust", p.mat = p.mat, sig.level = 0.01)
```

![plt-57](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-57.png)

```R
# Leave blank on no significant coefficient
corrplot(M, type = "upper", order = "hclust", p.mat = p.mat, sig.level = 0.01, insig = "blank")
```

![plt-58](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-58.png)

In the above figure, correlations with **p-value > 0.01** are considered as insignificant. In this case the correlation coefficient values are leaved blank or crosses are added.

```R
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(M, method = "color", col = col(200), type = "upper", order = "hclust", number.cex = .7,
   addCoef.col = "black", # Add coefficient of correlation
   tl.col = "black", tl.srt = 90, # Text label color and rotation
   # Combine with significance
   p.mat = p.mat, sig.level = 0.01, insig = "blank", 
   # hide correlation coefficient on the principal diagonal
   diag = FALSE)
```

![plt-59](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-59.png)

**Note:** Some of the plots were taken from this blog.

## Explore Large Feature Matrices

```R
# generating large feature matrix (cols=features, rows=samples)
num_features <- 60 # how many features
num_samples <- 300 # how many samples
DATASET <- matrix(runif(num_features * num_samples), nrow = num_samples, ncol = num_features)

# setting some dummy names for the features e.g. f23
colnames(DATASET) <- paste0("f", 1:ncol(DATASET))

# let's make 30% of all features to be correlated with feature "f1"
num_feat_corr <- num_features * .3
idx_correlated_features <- as.integer(seq(from = 1, to = num_features, length.out = num_feat_corr))[-1]

for (i in idx_correlated_features) {
  DATASET[,i] <- DATASET[,1] + runif(num_samples) # adding some noise
}

corrplot(cor(DATASET), diag = FALSE, order = "FPC", tl.pos = "td", tl.cex = 0.5, method = "color", type = "upper")
```

![plt-60](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-2/plt-60.png)
