####----Variable Construction----####

load("jobs.Rda")

#library(tm)
#library(topicmodels)
#library(stm)
library(stringr)

##bin the agency variable
names(jobs)
#out<-textProcessor(jobs$agency,NULL)
#vocab<-out$vocab
#docs<-out$documents
#fit<-stm(documents=docs,vocab=vocab,K=5,data=NULL)

#category<-labelTopics(fit,topics=1:5)
#names(fit)
#agency<-apply(fit$theta,1,which.max)

table(jobs$agency)
fin<-c(1,9,19,21,16,32) #finance
infra<-c(7,11,17,18,23,26,28,38,25,10) # infrastructure
soc<-c(2,6,8,27,31,34,35,39) # social
law<-c(3,4,13,14,15,20,22,24,25,29,33,37)
sec<-c(5,30,36)
it<-12

sum(jobs$agency %in% unique(jobs$agency)[fin]) #137
sum(jobs$agency %in% unique(jobs$agency)[infra]) #313
sum(jobs$agency %in% unique(jobs$agency)[soc]) #538
sum(jobs$agency %in% unique(jobs$agency)[law]) #488
sum(jobs$agency %in% unique(jobs$agency)[sec]) #51
sum(jobs$agency == unique(jobs$agency)[it]) #121

jobs$agency.bin<-NA
jobs$agency.bin[jobs$agency %in% unique(jobs$agency)[fin]]<-"finance"
jobs$agency.bin[jobs$agency %in% unique(jobs$agency)[infra]]<-"infrastructure"
jobs$agency.bin[jobs$agency %in% unique(jobs$agency)[soc]]<-"socialService"
jobs$agency.bin[jobs$agency %in% unique(jobs$agency)[law]]<-"law"
jobs$agency.bin[jobs$agency %in% unique(jobs$agency)[sec]]<-"security"
jobs$agency.bin[jobs$agency %in% unique(jobs$agency)[it]]<-"IT"

table(jobs$agency.bin)
jobs$agency.bin<-as.factor(jobs$agency.bin)

##bin the level variable
jobs$level.bin<-NA
jobs$level.bin[jobs$level=="00" | jobs$level=="01" |jobs$level=="02" |jobs$level=="03" |jobs$level=="04" ]="entry"
jobs$level.bin[jobs$level=="M1" |jobs$level=="M2" |jobs$level=="M3" |jobs$level=="M4" |jobs$level=="M5" |jobs$level=="M6" |jobs$level=="M7"]="manager"
jobs$level.bin[jobs$level=="4A" |jobs$level=="4B" |jobs$level=="3B" ]="chief"

table(jobs$level.bin)
jobs$level.bin<-as.factor(jobs$level.bin)

##bin the residency requriement variable
