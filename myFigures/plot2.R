library(data.table)

#read rows from 1/2/2007 to 2/2/2007
epc<-fread(input="household_power_consumption.txt", na.strings = '?', sep = ';', header = FALSE, skip = "1/2/2007", nrows = 2879)

#get headers and set them to epc
epc_header <- fread(input="household_power_consumption.txt", sep = ';', header = FALSE, nrows = 1)
setnames(epc, old <- names(epc), new = as.vector(as.matrix(epc_header[1,], mode = "any")))

#change epc date format
epc[, Date := as.Date(Date, "%d/%m/%Y")]


#plot frequecy of Global_active_power 
png(filename = "plot2.png", width = 480, height = 480)
plot(epc$Global_active_power, xaxt="n", xlab="", ylab = "Global Active Power(kilowatts)", type = "l")
axis(1, at=seq(from = 1,to = nrow(epc), length.out = 3), labels = c("Thu", "Fri", "Sat"))
dev.off()
