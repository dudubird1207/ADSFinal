#split dataset
jobs=subset(jobs,salary<300000)
jobs <- cbind(jobs, salary.bin=cut(jobs$salary, breaks=c(9026,68200,180000)))
topic20=read.csv("theta20.csv")
log20=log(topic20[-271,])
jobs=cbind(jobs,log20)
select=seq(1,864,by=1)
set.seed=1
jobstrain=sample(select,576)
jobst=jobs[jobstrain,]
jobsv=jobs[-jobstrain,]
###regression
salary.bin=jobs$salary.bin
nsalary.bin=as.numeric(salary.bin)
nsalary.bin[nsalary.bin==1]=0
nsalary.bin[nsalary.bin==2]=1
log20=data.frame(log20)
log20=log20[-271,]
row.names(log20) <- NULL
log20$salary.bin=nsalary.bin
data=log20
###ols
olstopic20=lm((salary.bin)~., data)
###logit
logit20= glm(salary.bin~.,data=data,family=binomial)

#cross validation
#install.packages("cvTools")
#install.packages("boot")
#library(cvTools)
#library(boot)
#cvols=cvFit(olstopic20, data = data, x = NULL,y=data$salary.bin, cost =mspe, K = 5 )
#cvols2=cv.glm(data=data,glmfit=olstopic20,K=5)


###validation
install.packages("caret")
install.packages("rknn")
install.packages("e1071")
library(e1071)
library(ggplot2)
library(caret)
library(rknn)
#accuracy

#accuracy logit
prob=predict(logit20,type=c("response"))
pred=ifelse(prob>=0.5,1,0)
confusionMatrix(pred,data[,21])


