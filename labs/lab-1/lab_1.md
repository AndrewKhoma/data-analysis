# Лабораторна робота №1

Розглянемо датасет що містить дані про стать, вагу тіла, і вагу серця котів, розміщений у файлі `cats.csv`.

Для аналізу нам знадобляться бібліотеки `tidyverse` і `e1071` (у ній розміщена функція для обчислення коефіцієнту ексцесу розподілу). Вони не вбудовані в `R`, тому встановимо їх і підключимо:

```R
install.packages("tidyverse")
library(tidyverse)

install.packages("e1071")
library(e1071)
```

У зв'язку зі специфічним розміщенням файлів на моїй машині необхідно змінити робочу директорію:
```R
setwd("C:/Users/NikitaSkybytskyi/Desktop/data-analysis/labs/lab-1")
```

Зчитаємо дані із заголовком і не факторизуючи рядкові змінні і поглянемо на зчитані дані:
```R
data <- read.csv(file = "cats.csv", header = TRUE, stringsAsFactors = FALSE)
data
```
```
      X Sex Bwt  Hwt
1     1   F 2.0  7.0
2     2   F 2.0  7.4
....................
143 143   M 3.9 14.4
144 144   M 3.9 20.5
```

Візьмемо вагу серця як випадкову величину `x`:
```R
x <- data$Hwt
x
```
```
  [1]  7.0  7.4  9.5  7.2  7.3  7.6  8.1  8.2  8.3  8.5
 [11]  8.7  9.8  7.1  8.7  9.1  9.7 10.9 11.0  7.3  7.9
.......................................................
[131] 11.7 12.9 15.6 15.7 17.2 11.8 13.3 14.8 15.0 11.0
[141] 14.8 16.8 14.4 20.5
```

Відсортуємо `x` і збережемо його в `x.sorted` для подальшого застосування:
```R
x.sorted = sort(x)
x.sorted
```
```
  [1]  6.3  6.5  6.5  7.0  7.1  7.2  7.2  7.3  7.3  7.3
 [11]  7.4  7.6  7.6  7.7  7.9  7.9  7.9  7.9  7.9  8.0
.......................................................
[131] 14.1 14.3 14.4 14.4 14.8 14.8 14.9 15.0 15.4 15.6
[141] 15.7 16.8 17.2 20.5
```

Збережемо основні статистики в.в. `x` у окремий датафрейм `x.stats` для подальшого застосування:
```R
x.stats <- data.frame(mean = mean(x), sd = sd(x), range = range(x))
```

Перейдемо до графічного аналізу і почнемо з діаграми:
```R
hist(x, breaks = 20)
```
![hist](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-1/hist.png)

Поки що розподіл схожий на нормальний з єдиною аномалією.

Побудуємо тепер ящик з вусами:
```R
boxplot(x, horizontal = TRUE, col = "yellow")
```
![boxplot](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-1/boxplot.png)

Як бачимо, R автоматично відділив дві реалізації в.в. `x` які він вважає аномальними, і розподіл вже не виглядає таким симетричним, можливо він не такий і нормальний.

Побудуємо Q-Q графік
```R
ggplot(data = data, mapping = aes(sample = x)) + stat_qq() + stat_qq_line()
```
![q-q-plot](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-1/q-q%20plot.png)

Знову-ж таки, графік трохи відрізняється від прямої, але у частині в якій сконцентрована більшість спостережень графік дуже схожий на пряму.

Те саме можна сказати про P-P графік
```R
x.ecdf = ecdf(x.sorted)
ggplot(
  data = norm.data,
  mapping = aes(x = x.ecdf(x.sorted), y = pnorm(q = x.sorted, mean = x.stats$mean, sd = x.stats$sd))
) + geom_point() + geom_abline(intercept = 0, slope = 1, size = 1)
```
![p-p-plot](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-1/p-p%20plot.png)

Далі просто обчислимо основні числові характеристики цього розподілу:

```R
cat(sprintf("Середнє = %.4f\n", x.stats$mean))  # 10.6306

cat(sprintf("Медіана = %.4f\n", median(x)))  # 10.1000

# Моду не обчислюємо бо в.в. неперервна

cat(sprintf("Дисперсія = %.4f\n", var(x)))  # 5.9275

cat(sprintf("Середньоквадратичне відхилення = %.4f\n", x.stats$sd))  # 2.4346

cat(sprintf("Коефіцієнт варіації = %.4f\n", x.stats$sd / x.stats$mean)  # 0.2290

cat(sprintf("Найменше значення = %.4f\n", x.stats$range[1]))  # 6.3000

cat(sprintf("Найбільше значення = %.4f\n", x.stats$range[2]))  # 20.5000

cat(sprintf("Розкид вибірки = %.4f\n", diff(x.stats$range)))  # 14.2000

cat(sprintf("Скошеність = %.4f\n", skewness(x)))  # 0.8214

cat(sprintf("Ексцес = %.4f\n", kurtosis(x)))  # 1.0253
```