#setwd("Desktop/final")
load("jobs.Rda")

#Remove outliers
jobs2=subset(jobs,salary<300000)
jobs2=subset(jobs2,X__of_positions<999)

#plot(jobs2$length_text,jobs2$salary)
#boxplot(jobs2$salary~jobs2$level)
#boxplot(jobs2$salary~jobs2$residency.bin)
#boxplot(jobs2$salary~jobs2$level.bin)
#boxplot(jobs2$salary~jobs2$agency.bin)
#boxplot(jobs3$X__of_positions~jobs3$agency,las=3,cex.axis=0.4)
#stacked histogram

require(ggplot2)
jobs2$posting_date=as.character(jobs2$posting_date)

jobs3=jobs2
g2012=list()
for (i in 6:9){
  g2012[[i]]=grep(paste("2012-0",i,"+",sep=""),jobs2$posting_date,perl=TRUE,value=FALSE)
  jobs3$posting_date[g2012[[i]]]=paste("2012-0",i,sep="")
}
for (i in 10:12){
  g2012[[i]]=grep(paste("2012-",i,"+",sep=""),jobs2$posting_date,perl=TRUE,value=FALSE)
  jobs3$posting_date[g2012[[i]]]=paste("2012-",i,sep="")
}

g2013=list()
for (i in 1:9){
  g2013[[i]]=grep(paste("2013-0",i,"+",sep=""),jobs2$posting_date,perl=TRUE,value=FALSE)
  jobs3$posting_date[g2013[[i]]]=paste("2013-0",i,sep="")
}
for (i in 10:12){
  g2013[[i]]=grep(paste("2013-",i,"+",sep=""),jobs2$posting_date,perl=TRUE,value=FALSE)
  jobs3$posting_date[g2013[[i]]]=paste("2013-",i,sep="")
}

g2014=list()
for (i in 1:4){
  g2014[[i]]=grep(paste("2014-0",i,"+",sep=""),jobs2$posting_date,perl=TRUE,value=FALSE)
  jobs3$posting_date[g2014[[i]]]=paste("2014-0",i,sep="")
}

summary(jobs3$salary)
jobs3 <- cbind(jobs3, salary.bin=cut(jobs3$salary, breaks=c(9026,46150,68200,87450,180000)))

jobs4=jobs3
jobs4$salary.bin=as.character(jobs4$salary.bin)

jobs4$salary.bin[jobs4$salary.bin=="(9.03e+03,4.62e+04]"]="0%-25%"
jobs4$salary.bin[jobs4$salary.bin=="(4.62e+04,6.82e+04]"]="25%-50%"
jobs4$salary.bin[jobs4$salary.bin=="(6.82e+04,8.74e+04]"]="50%-75%"
jobs4$salary.bin[jobs4$salary.bin=="(8.74e+04,1.8e+05]"]="75%-100%"
jobs4=jobs4[c(-33,-34,-35),]

month=sort(unique(jobs4$posting_date))
salbin=sort(unique(jobs4$salary.bin))


freq=c()
for (i in 1:length(month)) {
  for (j in 1:length(salbin)){
		freq[4*(i-1)+j]=nrow(jobs4[jobs4$posting_date==month[i]&jobs4$salary.bin==salbin[j], ])
	}
}


months=rep(month,each=length(salbin))
salary_bin=rep(salbin,length(month))

df=data.frame(cbind(months,freq,salary_bin))
df$freq=as.numeric(as.character(df$freq))

ggplot(data=df,aes(x=months,y=freq,fill=salary_bin))+geom_bar()+
  scale_fill_brewer(palette = 12)+
  labs(title = "Frequency of each salary bin for each of the month", 
       y = "Frequency", x = "Posting date", fill = "Salary bin")+coord_flip()

