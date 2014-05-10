#regression
topicpro=read.csv("theta20.csv")
dim(topicpro)
jobsf=cbind(jobs,topicpro)
View(jobsf)
ols20=cbind(jobs$annual_salary_midpoint,topicpro)
topic20=lm(jobs$annual_salary_midpoint~., topicpro)
log20=log(topicpro)
topic20l=lm(log(jobs$annual_salary_midpoint)~., log20)
topic50=read.csv("theta50.csv")
log50=log(topic50)
topic50l=lm(log(jobs$annual_salary_midpoint)~., log50)
####cross validation
r20=cbind(jobs$annual_salary_midpoint,log20)
colnames(r20)[1]="salary"
topics20l=lm(log(salary)~.,r20)
install.packages("cvTools")
library(cvTools)
crossvali20=cvFit(topics20l, data = r20, x = NULL,y=log(r20$salary),
       cost =mspe, K = 5 )
######
topic40=read.csv("theta40.csv")
log40=log(topic40)
r40=cbind(jobs$annual_salary_midpoint,log40)
colnames(r40)[1]="salary"
topic40l=lm(log(salary)~.,r40 )
crossvali40=cvFit(topic40l, data = r40, x = NULL,y=log(r40$salary),
                  cost =mspe, K = 5 )
####




