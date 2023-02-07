#user defined funcitons

#allow user to switch between arithmetic and geometric mean
avg = function(x, arithmetic=TRUE){
  if(!is.numeric(x))
  {
    stop("x must be numeric")
  }#idiot-proofing our function
  n=length(x)
  result = ifelse(arithmetic, sum(x)/n, prod(x)^(1/n))
  return(result)
}
#outside of funciton, intermediary variables don't exist - creates separate environment


dat = c(1,3,5,7)

avg(dat)
avg(arithmetic=FALSE, x=dat)#can switch order if we explicitly name the variables
avg(x=c("a","b","c"))#now non-numeric data throws an error
avg(FALSE, dat)

#exercise 7.1
letter_grade = function(x){
  if(!is.numeric(x)){
    stop("x must be numeric")
  }
  
  if(x>=90){
    grade="A"
  }
  else if(x>=80){
    grade="B"
  }
  else if(x>=70){
    grade="C"
  }
  else if(x>=60){
    grade="D"
  }
  else{
    grade="F"
  }
  return(grade)
}

#-------------------------------------------------------------------------------
# Analyze Global Temps
#-------------------------------------------------------------------------------

url = 'https://data.giss.nasa.gov/gistemp/graphs/graph_data/Global_Mean_Estimates_based_on_Land_and_Ocean_Data/graph.txt'

temp_anomaly = read.delim(url,
                          skip=5,
                          sep="",
                          header=FALSE,
                          col.names=c("Year", "No_Smoothing", "Lowess_5"))
head(temp_anomaly)
tail(temp_anomaly)

temp1998 = temp_anomaly$No_Smoothing[temp_anomaly$Year==1998]
temp2012 = temp_anomaly$No_Smoothing[temp_anomaly$Year==2012]

plot(No_Smoothing~Year, data=temp_anomaly, ylab="Global Temp Anomaly (C)") +
  lines(Lowess_5~Year, data=temp_anomaly, col="red", lwd=2) +
  abline(v=1998, lty="dashed") +
  abline(v=2012, lty="dashed") +
  lines(c(temp1998, temp2012) ~ c(1998, 2012), col="blue", lwd=2.5)
#lwd for line width, lty for line type

calc_rolling_avg = function(data, moving_window=5){
  result = rep(NA, length(data))
  for(i in seq(from=moving_window, to=length(data))){
    result[i] = mean(data[seq(from=(i-moving_window+1), to=i)])
  }
  return(result)
}

temp_anomaly$avg_5yr = calc_rolling_avg(data=temp_anomaly$No_Smoothing)
temp_anomaly$avg_10yr = calc_rolling_avg(data=temp_anomaly$No_Smoothing, moving_window = 10)
head(temp_anomaly)
