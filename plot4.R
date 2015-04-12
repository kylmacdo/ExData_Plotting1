plot4.subsetfile<- function(){
        #
        #Reads the full power consumption data set and creates a smaller CSV file
        #to speed up future processing
        #
        
        plot4.colclasses <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
        plot4.data<- read.table("./household_power_consumption.txt", 
                                sep=";", 
                                header=TRUE, 
                                na.strings="?", 
                                colClasses=plot4.colclasses,
        )
        plot4.data<-plot4.data[plot4.data[1]=='1/2/2007'|plot4.data[1]=='2/2/2007',]
        plot4.data[,1]<-paste(plot4.data[,1],plot4.data[,2])
        plot4.data[,1]<-as.character(strptime(plot4.data[,1],"%d/%m/%Y %H:%M:%S"))
        write.csv(plot4.data,file="household_power_subset.csv")        
}

plot4<- function(){
        #
        #Creates the 4 plots required for plot4
        #
        plot4.colclasses <- c("character","POSIXct","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
        plot4.data<- read.csv("./household_power_subset.csv",  
                              colClasses=plot4.colclasses)
        png(filename="plot4.png")
        
        par(mfcol=c(2,2))
        #,mar=c(4,4,2,1))
        plot(plot4.data[,2],plot4.data[,4],type="l",xlab="",ylab="Global Active Power (kilowatts)")
        
        plot(plot4.data[,2],plot4.data[,8],type="l",xlab="",ylab="Energy sub metering")
        legend("topright",legend=c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"), col=c("black","red","blue"),lty=1,bty="n")
        
        lines(plot4.data[,2],plot4.data[,9],col="red")
        lines(plot4.data[,2],plot4.data[,10],col="blue")
        
        plot(plot4.data[,2],plot4.data[,6],type="l",xlab="datetime",ylab="Voltage")
        plot(plot4.data[,2],plot4.data[,5],type="l",xlab="datetime",ylab="Global_reactive_power")
        
        dev.off()
}
