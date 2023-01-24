# Katie
# 2023-01-24
# Ice mass loss over poles

#read in data from NASA txt file and format it into a table
#first 31 rows are header, separated by white space
ant_ice_loss = read.table(file="data/antarctica_mass_200204_202209.txt", skip=31, sep="", header=FALSE, 
           col.names=c("decimal_date", "mass_Gt", "sigma_Gt"))

typeof(ant_ice_loss) #list
class(ant_ice_loss) #data frame
dim(ant_ice_loss) #what are the dimensions? - 213 rows, 3 columns

grn_ice_loss = read.table(file="data/greenland_mass_200204_202209.txt", skip=31, sep="", header=FALSE, 
                          col.names=c("decimal_date", "mass_Gt", "sigma_Gt"))

head(grn_ice_loss) #prints first 6 rows of the data frame to check everything looks good
tail(grn_ice_loss) #prints last 6 rows
summary(ant_ice_loss) #gives stats about each column in this case



# now we'll plot the data, just using base r
# create line plot using type = "l"
# adjust plot range using ylim - can hard code or look to data

plot(x=ant_ice_loss$decimal_date, y=ant_ice_loss$mass_Gt, type="l", 
     xlab = "Year", ylab = "Antarctic Ice Mass Loss (Gt)", 
     ylim=range(grn_ice_loss$mass_Gt)) 
lines(mass_Gt~decimal_date, data=grn_ice_loss, col="red") #lines function relies on plot already being created

#missing data between grace missions - we'll insert an NA in the middle of the missing period

data_break = data.frame(decimal_date=2018.0, mass_Gt=NA, sigma_Gt=NA)
ant_ice_loss_with_NA = rbind(ant_ice_loss, data_break)
grn_ice_loss_with_NA = rbind(grn_ice_loss, data_break)

tail(ant_ice_loss_with_NA) #appended new data point to the end, and since r plots in order we need to put it in place
order(ant_ice_loss_with_NA$decimal_date) #row 214 shows up after 163
ant_ice_loss_with_NA = ant_ice_loss_with_NA[order(ant_ice_loss_with_NA$decimal_date), ]
tail(ant_ice_loss_with_NA) #data break no longer at the end

grn_ice_loss_with_NA = grn_ice_loss_with_NA[order(grn_ice_loss_with_NA$decimal_date), ]

#now we'll create a new plot

plot(x=ant_ice_loss_with_NA$decimal_date, y=ant_ice_loss_with_NA$mass_Gt, type="l", 
     xlab = "Year", ylab = "Antarctic Ice Mass Loss (Gt)", 
     ylim=range(grn_ice_loss$mass_Gt)) 
lines(mass_Gt~decimal_date, data=grn_ice_loss_with_NA, col="red") #lines function relies on plot already being created

#on to error bars
#sigma column gives us 1 st dev, typically show 2 for 95% confidence interval

pdf('figures/ice_mass_trends.pdf', width=7, height=5) #saves plot to pdf
plot(x=ant_ice_loss_with_NA$decimal_date, y=ant_ice_loss_with_NA$mass_Gt, type="l", 
     xlab = "Year", ylab = "Antarctic Ice Mass Loss (Gt)", 
     ylim=range(grn_ice_loss$mass_Gt))
lines((mass_Gt + 2*sigma_Gt) ~ decimal_date, data=ant_ice_loss_with_NA, lty = "dashed")
lines((mass_Gt - 2*sigma_Gt) ~ decimal_date, data=ant_ice_loss_with_NA, lty = "dashed")
dev.off()

#bar plot of total ice loss
tot_ice_loss_ant = min(ant_ice_loss_with_NA$mass_Gt, na.rm=T) - max(ant_ice_loss_with_NA$mass_Gt, na.rm=T)
tot_ice_loss_grn = min(grn_ice_loss_with_NA$mass_Gt, na.rm=T) - max(grn_ice_loss_with_NA$mass_Gt, na.rm=T)

barplot(height = -1*c(tot_ice_loss_ant, tot_ice_loss_grn), names.arg=c("Antarctica","Greenland"))
