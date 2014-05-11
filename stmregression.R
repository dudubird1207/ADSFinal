#split dataset
jobs=subset(jobs,salary<300000)
jobs <- cbind(jobs, salary.bin=cut(jobs$salary, breaks=c(9026,68200,180000)))
topic20=read.csv("theta20.csv")
log20=log(topic20[-271,])
jobs=cbind(jobs,log20)
salary.bin=jobs$salary.bin
jobs$nsalary.bin=as.numeric(salary.bin)
jobs$nsalary.bin[nsalary.bin==1]=0
jobs$nsalary.bin[nsalary.bin==2]=1
select=seq(1,864,by=1)
set.seed=1
jobstrain=sample(select,576)
jobst=jobs[jobstrain,]
jobsv=jobs[-jobstrain,]
###regression topic
data=cbind(jobst$nsalary.bin,log20[jobstrain,])
colnames(data)[1]="salary.bin"
###ols
olstopic20=lm((salary.bin)~., data)
###logit
logit20= glm(salary.bin~.,data=data,family=binomial)
###validation data
datav=cbind(jobsv$nsalary.bin,log20[-jobstrain,])
colnames(datav)[1]="salary.bin"
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
#accuracy ols
prob=predict(olstopic20,datav[,2:21])
pred=ifelse(prob>=0.5,1,0)
confusionMatrix(pred,datav[,1])
#Accuracy : 0.8056
#Sensitivity : 0.7933
#Specificity : 0.8188 

#accuracy logit
prob=predict(logit20,datav[,2:21])
pred=ifelse(prob>=0.5,1,0)
confusionMatrix(pred,datav[,1])
#Accuracy : 0.7986 
#Sensitivity : 0.8533
#Specificity : 0.7391


###regression all
fdata=cbind(jobst$nsalary.bin,jobst$level.bin,jobst$length_text,jobst$residency.bin,log20[jobstrain,])
colnames(fdata)[1]="salary.bin"
colnames(fdata)[c(2,3,4)]=c("level.bin","length_text","residency.bin")
fdatav=cbind(jobsv$nsalary.bin,jobsv$level.bin,jobsv$length_text,jobsv$residency.bin,log20[-jobstrain,])
colnames(fdatav)[1]="salary.bin"
colnames(fdatav)[c(2,3,4)]=c("level.bin","length_text","residency.bin")
###ols
folstopic20=lm((salary.bin)~., fdata)
###logit
flogit20= glm(salary.bin~.,data=fdata,family=binomial)
#accuracy ols
fprob=predict(folstopic20,fdatav[,2:24])
fpred=ifelse(fprob>=0.5,1,0)
confusionMatrix(fpred,fdatav[,1])
#Accuracy : 0.809
#Sensitivity : 0.7867
#Specificity :  0.8333  

#accuracy logit
prob=predict(flogit20,fdatav[,2:24])
pred=ifelse(prob>=0.5,1,0)
confusionMatrix(pred,fdatav[,1])
#Accuracy : 0.809 
#Sensitivity : 0.8400 
#Specificity : 0.7754

##random forest
data$salary.bin=as.factor(data$salary.bin)
datav$salary.bin=as.factor(datav$salary.bin)
install.packages("randomForest")
library(randomForest)
rf=randomForest(salary.bin~.,data=data,importance=TRUE,
                proximity=TRUE,keep.forest=TRUE)
pred=predict(rf,datav[,2:21])
confusionMatrix(pred,datav[,1])
#Accuracy : 0.8056  
#Sensitivity : 0.8333
#Specificity : 0.7754

##random forest for all
fdata$salary.bin=as.factor(fdata$salary.bin)
fdatav$salary.bin=as.factor(fdatav$salary.bin)

frf=randomForest(salary.bin~.,data=fdata,importance=TRUE,
                proximity=TRUE,keep.forest=TRUE)
fpred=predict(frf,fdatav[,2:24])
confusionMatrix(fpred,fdatav[,1])
#Accuracy : 0.8438
#Sensitivity : 0.8600   
#Specificity : 0.8261