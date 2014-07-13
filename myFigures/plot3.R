library(data.table)

#read rows from 1/2/2007 to 2/2/2007
epc<-fread(input="household_power_consumption.txt", na.strings = '?', sep = ';', header = FALSE, skip = "1/2/2007", nrows = 2879)

#get headers and set them to epc
epc_header <- fread(input="household_power_consumption.txt", sep = ';', header = FALSE, nrows = 1)
setnames(epc, old <- names(epc), new = as.vector(as.matrix(epc_header[1,], mode = "any")))

#change epc date format
epc[, Date := as.Date(Date, "%d/%m/%Y")]


#plot frequecy of Global_active_power 
png(filename = "plot3.png", width = 480, height = 480)
ylim = c(0,38)
plot(epc$Sub_metering_1, xaxt="n", ylim = ylim, xlab="", ylab = "Energy sub metering", type = "l")
axis(1, at=seq(from = 1,to = nrow(epc), length.out = 3), labels = c("Thu", "Fri", "Sat"))
par(new = TRUE)
plot(epc$Sub_metering_2, col = "red", xaxt = "n", ylim = ylim, yaxt = "n", xlab="", ylab = "", type = "l")
par(new = TRUE)
plot(epc$Sub_metering_3, col = "blue", xaxt = "n", ylim = ylim, yaxt = "n", xlab="", ylab = "", type = "l")
legend(x = "topright", legend = paste("Sub_metering_", 1:3), col = c("black", "red", "blue"), lty = 1)
par(new = FALSE)
dev.off()

