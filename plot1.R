plot1.subsetfile<- function(){
        #
        #Reads the full power consumption data set and creates a smaller CSV file
        #to speed up future processing
        #
        
        plot1.colclasses <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
        plot1.data<- read.table("./household_power_consumption.txt", 
                                sep=";", 
                                header=TRUE, 
                                na.strings="?", 
                                colClasses=plot1.colclasses,
                                )
        plot1.data<-plot1.data[plot1.data[1]=='1/2/2007'|plot1.data[1]=='2/2/2007',]
        plot1.data[,1]<-paste(plot1.data[,1],plot1.data[,2])
        plot1.data[,1]<-as.character(strptime(plot1.data[,1],"%d/%m/%Y %H:%M:%S"))
        write.csv(plot1.data,file="household_power_subset.csv")        
}

plot1<- function(){
        #
        #Creates the histogram for plot1
        #
        plot1.colclasses <- c("character","POSIXct","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
        plot1.data<- read.csv("./household_power_subset.csv",  
                                colClasses=plot1.colclasses)
        png(filename="Plot1.png")
        hist(plot1.data[,4],main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency",col="Red")
        dev.off()
}

