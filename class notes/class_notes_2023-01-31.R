#2023-01-31
#CO2 Mauna Loa Data

#We can import data directly from NOAA's website instead of downloading it

url = 'ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_mm_mlo.txt'
co2 = read.table(url, col.names = c("year", "month", "decimal_date", "monthly_average", "deseasonalized", 
                                    "n_days", "st_dev_days", "monthly_mean_uncertainty"))
class(co2)
head(co2)
summary(co2)
tail(co2)

#Let's plot the co2 data (monthly and yearly average)

pdf('figures/keelingCurve.pdf', width=7, height=5)
plot(monthly_average ~ decimal_date, data=co2, type="l", xlab="Year", 
     ylab="CO2 (ppm)", main="Keeling Curve")
lines(y=co2$deseasonalized, x=co2$decimal_date, col="red")
dev.off()

#Now let's look at the seasonal variation

co2$seasonal_cycle = co2$monthly_average - co2$deseasonalized
head(co2)

plot(seasonal_cycle ~ decimal_date, data=co2, type="l")

#We want to find out which month gives us the peak, so let's zoom in on the data after 2018

co2$decimal_date>2018 #gives a list of booleans for each year
which(co2$decimal_date > 2018) #gives a list of row IDs

plot(seasonal_cycle ~ decimal_date, data=co2[co2$decimal_date>2018, ], type="l")
plot(seasonal_cycle ~ month, data=co2[co2$decimal_date>2022, ], type="l")

#Let's look at just january

jan_anomalies = co2$seasonal_cycle[which(co2$month == 1)]
head(jan_anomalies)
mean(jan_anomalies)

#Now we want to find the mean anomaly for each month

co2_monthly_cycle = data.frame(month=seq(12), detrended_monthly_cycle=NA)
head(co2_monthly_cycle)

  #calculate mean monthly cycles
for (i in c(1:12)) 
  {
  co2_monthly_cycle$detrended_monthly_cycle[i] = mean(co2$seasonal_cycle[co2$month==i])
  }
head(co2_monthly_cycle)

  #plot the new data frame
plot(detrended_monthly_cycle ~ month, data=co2_monthly_cycle, type="l",
     xlab="Month", ylab="Mean Monthly Anomaly (ppm)")

#Exercise 4.1

plot(seasonal_cycle ~ month, data=co2[co2$decimal_date>1959 & co2$decimal_date<1960, ], type="l")
lines(seasonal_cycle ~ month, data=co2[co2$decimal_date>2019 & co2$decimal_date<2020, ], col="red")

#Exercise 5.1

num = 6
fact = 1

for(i in seq(num)) {
  fact = fact*i
}

fact

#nested loops - completes the full cycle of the inner loop before stepping out to outer loop

mat = matrix(c(2,0,8,3,5,-4), nrow=2)
mat_sq = matrix(NA, nrow=2, ncol=3)
for(i in seq(2)){
  for(j in seq(3)){
    print(paste("i=",i," and j=",j))
    mat_sq[i,j] = mat[i,j]^2
    print(mat_sq)
  }
}