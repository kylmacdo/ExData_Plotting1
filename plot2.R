plot2.subsetfile<- function(){
        #
        #Reads the full power consumption data set and creates a smaller CSV file
        #to speed up future processing
        #
        
        plot2.colclasses <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
        plot2.data<- read.table("./household_power_consumption.txt", 
                                sep=";", 
                                header=TRUE, 
                                na.strings="?", 
                                colClasses=plot2.colclasses,
        )
        plot2.data<-plot2.data[plot2.data[1]=='1/2/2007'|plot2.data[1]=='2/2/2007',]
        plot2.data[,1]<-paste(plot2.data[,1],plot2.data[,2])
        plot2.data[,1]<-as.character(strptime(plot2.data[,1],"%d/%m/%Y %H:%M:%S"))
        write.csv(plot2.data,file="household_power_subset.csv")        
}

plot2<- function(){
        #
        #Creates the scatterplot for plot2
        #
        plot2.colclasses <- c("character","POSIXct","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
        plot2.data<- read.csv("./household_power_subset.csv",  
                              colClasses=plot2.colclasses)
        png(filename="Plot2.png")
        plot(plot2.data[,2],plot2.data[,4],type="l",xlab="",ylab="Global Active Power (kilowatts)")

        dev.off()
}
