# Лабораторна робота №3

## Лінійна регресія за однією змінною

Побудуємо дві регресійні моделі, одну із однією змінною а другу з багатьма. Для першої скористаємося вбудованим датасетом `cars` який містить відомості про швидкість і гальмівний шлях різних машин.

```R
library(tidyverse)
cars
```
car | speed | dist
----|-------|-----
 1  |     4 |    2
 2  |     4 |   10
 3  |     7 |    4
 4  |     7 |   22
 5  |     8 |   16
 .. |    .. |  ...
 46 |    24 |   70
 47 |    24 |   92
 48 |    24 |   93
 49 |    24 |  120
 50 |    25 |   85

Спершу побудуємо графік лінійної регресійної моделі методами пакету `tideverse`:
```R
ggplot(data = cars, aes(x = speed, y = dist)) + geom_point() + geom_smooth(method = "lm", se = FALSE)
```
![g-g plot 1](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-3/g-g%20plot%201.png)

А тепер спробуємо побудувати хоча б щось схоже за явними формулами. Логічно спробувати пряму пропорційну залежність. Побудуємо модель і одразу поглянемо на її показники:
```R
lm.res = lm(formula = dist~speed, data = cars)
summary(lm.res)
```
```
Call:
lm(formula = dist~speed, data = cars)

Residuals:
     Min      1Q  Median      3Q     Max 
 -29.069  -9.525  -2.272   9.215  43.201 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) -17.5791     6.7584  -2.601   0.0123 *  
speed         3.9324     0.4155   9.464 1.49e-12 ***
---
Signif. codes:  
0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 15.38 on 48 degrees of freedom
Multiple R-squared:  0.6511,	Adjusted R-squared:  0.6438 
F-statistic: 89.57 on 1 and 48 DF,  p-value: 1.49e-12
```

Поглянемо на залишкові члени моделі (і заодно порівняємо їхній розподіл з нормальним вже відомим нам Q-Q графіком):
```R
qqnorm(lm.res$residuals)
qqline(lm.res$residuals)
```
![q-q plot 1](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-3/q-q%20plot%201.png)

Справді певна схожість простежується, але не ідеальна, тому навряд гальмівний шлях залежить тільки від швидкості.

До того ж, як ілюструє наступний графік, модель доволі "божевільно" помиляється при будь-якому прогнозованому гальмівному шляху, тому її не можна використовувати навіть на якомусь одному інтервалі швидкостей:
```R
ggplot(data = lm.res, aes(x = lm.res$fitted, y = lm.res$residuals)) + geom_point()
```
![g-g plot 2](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-3/g-g%20plot%202.png)

Побудуємо нову модель, без вільного коефіцієнту:
```
lm.res.lin = lm(formula = dist~speed-1, data = cars)
summary(lm.res.lin)
```
```
Call:
lm(formula = dist ~ speed - 1, data = cars)

Residuals:
    Min      1Q  Median      3Q     Max 
-26.183 -12.637  -5.455   4.590  50.181 

Coefficients:
      Estimate Std. Error t value Pr(>|t|)    
speed   2.9091     0.1414   20.58   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 16.26 on 49 degrees of freedom
Multiple R-squared:  0.8963,	Adjusted R-squared:  0.8942 
F-statistic: 423.5 on 1 and 49 DF,  p-value: < 2.2e-16
```
Як бачимо, її показники навіть трохи більш плачевні, але все-таки поглянемо на залишкові члени:

```R
qqnorm(lm.res.lin$residuals)
qqline(lm.res.lin$residuals)
```

![q-q plot 2](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-3/q-q%20plot%202.png)

Як показує наступний графік, ми дійсно прибрали неконстанту складову з моделі:
```R
ggplot(data = lm.res.lin, aes(x = lm.res$fitted, y = lm.res$residuals)) + geom_point() + geom_smooth(method = "lm", se = FALSE)
```
![g-g plot 3](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-3/g-g%20plot%203.png)

Підтвердимо наші слова про незалежність помилки від передбаченої довжини гальмівного шляху обчисливши коефіцієнт кореляції Пірсона цих величин:

```R
cor.test(x = lm.res$fitted, y = lm.res$residuals)$estimate  # 4.628907e-17
```

Оскільки тут складно ще щось зробити, перейдемо до лінійної регресії за багатьма змінними.

## Лінійна регресія за багатьма змінними

Дослідимо датасет що містить відомості про форму листя.

Завантажимо його командою
```R
leaf.data = read.csv(file = "C:/Users/NikitaSkybytskyi/Desktop/data-analysis/labs/lab-3/leafshape.csv", stringsAsFactors = FALSE)
```

Він містить наступні змінні:
* `bladelen` - довжина листа (в міліметрах);
* `petiole` - довжина черешка;
* `bladewid` - ширина листя;
* `latitude` - широта;
* `logwid` - натуральний логарифм ширини листа;
* `logpet` - натуральний логарифм довжини черешка;
* `loglen` - натуральний логарифм довжини листа;
* `arch` - форма листа (конкретні значення нам не знадобляться);
* `location` - факторна змінна з градаціями `Sabah, Panama, Costa Rica, N Queensland, S Queensland, Tasmania`.

З нього нам знадобляться лише стовпчики з другого по четвертий, виділимо їх і одразу побудуємо попарні точкові графіки (англ. scatterplot): 
```R
pairs(leaf.data[,2:4], cols = 3)
```
![pairs](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-3/pairs.png)

Побудуємо лінійну модуль залежності `petiole` від довжини і ширини листя:
```R
lm.leaf = lm(formula = petiole ~ bladelen + bladewid, data = leaf.data)
summary(lm.leaf)
```
```
Call:
lm(formula = petiole ~ bladelen + bladewid, data = leaf.data)

Residuals:
     Min       1Q   Median       3Q      Max 
-13.3276  -0.8848   0.0212   0.8289  14.2905 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) -0.91120    0.29640  -3.074  0.00232 ** 
bladelen    -0.26155    0.02253 -11.609  < 2e-16 ***
bladewid     1.14051    0.03731  30.565  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 2.273 on 283 degrees of freedom
Multiple R-squared:  0.8148,	Adjusted R-squared:  0.8134 
F-statistic: 622.4 on 2 and 283 DF,  p-value: < 2.2e-16
```
Схоже що побудована модель досить точка як підтверджують наступні графіки порівняння розподілу похибки моделі і нормального розподілу:
```R
qqnorm(lm.leaf$residuals)
qqline(lm.leaf$residuals)
```
![q-q plot 3](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-3/q-q%20plot%203.png)

Втім наступний графік залежності похибки від передбаченого значення показує, що хоча вона і невелика за абсолютним значенням, але велика у порівнянні із власне значеннями `petiole`

```R
ggplot(data = lm.leaf, aes(x = lm.leaf$fitted, y = lm.leaf$residuals)) + geom_point() + geom_smooth(method = "lm", se = FALSE)
```
![g-g plot 4](https://github.com/Sky-Nik/data-analysis/blob/master/labs/lab-3/g-g%20plot%204.png)
