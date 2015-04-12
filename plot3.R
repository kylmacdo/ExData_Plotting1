plot3.subsetfile<- function(){
        #
        #Reads the full power consumption data set and creates a smaller CSV file
        #to speed up future processing
        #
        
        plot3.colclasses <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
        plot3.data<- read.table("./household_power_consumption.txt", 
                                sep=";", 
                                header=TRUE, 
                                na.strings="?", 
                                colClasses=plot3.colclasses,
        )
        plot3.data<-plot3.data[plot3.data[1]=='1/2/2007'|plot3.data[1]=='2/2/2007',]
        plot3.data[,1]<-paste(plot3.data[,1],plot3.data[,2])
        plot3.data[,1]<-as.character(strptime(plot3.data[,1],"%d/%m/%Y %H:%M:%S"))
        write.csv(plot3.data,file="household_power_subset.csv")        
}

plot3<- function(){
        #
        #Creates the scatterplot for plot3
        #
        plot3.colclasses <- c("character","POSIXct","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
        plot3.data<- read.csv("./household_power_subset.csv",  
                              colClasses=plot3.colclasses)
        png(filename="plot3.png")
        

        plot(plot3.data[,2],plot3.data[,8],type="l",xlab="",ylab="Energy sub metering")
        legend("topright",legend=c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"), col=c("black","red","blue"),lty=1)

        lines(plot3.data[,2],plot3.data[,9],col="red")
        lines(plot3.data[,2],plot3.data[,10],col="blue")

        
        dev.off()
}
