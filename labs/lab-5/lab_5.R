# install.packages("TTR")
library("TTR")
# install.packages("forecast")
library("forecast")

# plots
my.ts = USAccDeaths
plot.ts(my.ts)

smoothed = SMA(my.ts, n = 2)
plot.ts(smoothed)

comp = decompose(smoothed)
plot(comp)

# forecast
sm.fcst = HoltWinters(x = my.ts, beta = FALSE, gamma = FALSE)
plot(sm.fcst)

sm.fcst2 = forecast(sm.fcst, h = 10)
sm.fcst2$residuals
#             Jan        Feb        Mar        Apr
# 1973         NA  -901.0000   821.9404   209.0543
# 1974 -1177.0155  -769.0778  1056.9492   384.0699
# 1975  -518.0020  -856.0342   817.9434  -253.9459
# 1976  -317.0083  -256.0210   305.9831   158.0202
# 1977  -854.9489  -835.0565   768.9448   380.0508
# 1978  -959.9649  -944.0635   898.9376   401.0594
#             May        Jun        Jul        Aug
# 1973   880.0138   809.0582   491.0535  -572.9675
# 1974   292.0254   798.0193   608.0528  -296.9598
# 1975  1516.9832   169.1003   537.0112  -472.9645
# 1976   698.0104   322.0461  1133.0213  -898.9251
# 1977   784.0251   409.0518  1326.0270 -1322.9123
# 1978   923.0265   319.0610  1050.0211  -656.9306
#             Sep        Oct        Nov        Dec
# 1973 -1031.0379   224.9318  -776.9851  -234.0514
# 1974 -1080.0196   385.9286  -418.9745   -30.0277
# 1975 -1335.0313   180.9117  -305.9880  -126.0202
# 1976 -1142.0594   450.9245  -613.9702   772.9594
# 1977  -988.0875   535.9347  -584.9646   530.9613
# 1978  -717.0434   -40.0474  -437.0026   606.9711
plot(sm.fcst2)

# errors
sm.fcst2$residuals[1] = -1000
length(sm.fcst2$residuals)  # 72
acf(sm.fcst2$residuals, lag.max = 72)
