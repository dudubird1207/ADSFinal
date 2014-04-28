.saveworkspace.data_processing.R <- ls()

# install.packages("XML")
# install.packages("lubridate")
library(XML)
library(lubridate)

jobs.xml <- xmlParse("NYC_jobs.xml")
jobs.list <- xmlToList(jobs.xml)
jobs.list <- jobs.list$row
names(jobs.list) <- seq_along(jobs.list)

#--- pre-processing to make sure the columns match up in each row ---#
ln <- numeric(length(jobs.list))
for(i in seq_along(ln)){
  ln[i] <- length(names(jobs.list[[i]]))
}
lwhich <- which(ln==max(lwhich))
v<- logical(length(lwhich)-1)
for(i in seq_along(v)){
  v[i] <- identical(names(jobs.list[[lwhich[i]]]),names(jobs.list[[lwhich[i+1]]]))
}
names(jobs.list[[30]])[which(!( names(jobs.list[[30]]) %in% names(jobs.list[[29]]) ))]
lnwhich <- which(ln!=26)
for( l in lnwhich){
  jobs.list[[l]]["post_until"] <- NA # fill in with NA's to make the rows conform
  jobs.list[[l]] <- jobs.list[[l]][c(1:22,26,23:25)] # reorder columns to conform
}

#--- make a data frame and convert some column types ---#
jobs <- data.frame(do.call(rbind,jobs.list),stringsAsFactors=F)
jobs$.attrs <- NULL

jobs <- data.frame(lapply(jobs,gsub,pattern=" 00:00:00",replace="",fixed=T),stringsAsFactors=F) # not strictly necessary, but makes the resulting lubridate objects easier to handle
head(apply(jobs,1,grep,pattern="^[[:digit:]]+$"),20)[c(1,3,20)]
# 1, 4, 9, and 10 are definitely numeric
for(k in c(1,4,9,10)){
  jobs[,k] <- as.numeric(jobs[,k],as.numeric)
}
for(k in c("post_until","posting_date","posting_updated")){
  jobs[,k] <- mdy(jobs[,k])
}

save(jobs,file="jobs.RData")

rm(list=ls()[!(ls() %in% .saveworkspace.data_processing.R)])