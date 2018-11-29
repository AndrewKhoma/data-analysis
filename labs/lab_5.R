library("TTR")
library("forecast")
#plot
my.ts = USAccDeaths
plot.ts(my.ts)
smoothed = SMA(my.ts, n=2)
plot.ts(smoothed)
comp = decompose(smoothed)
plot(comp)

#forecast
sm.fcst = HoltWinters(x = my.ts, beta = F, gamma = F)
plot(sm.fcst)
sm.fcst2 = forecast(sm.fcst, h = 10)
sm.fcst2$residuals
plot(sm.fcst2)

#errors
sm.fcst2$residuals[1] = -1000
length(sm.fcst2$residuals)
acf(sm.fcst2$residuals, lag.max = 72)
