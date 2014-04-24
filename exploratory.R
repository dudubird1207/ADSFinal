# install.packages("ggplot2")
library(ggplot2)

load("jobs.RData")

jobs <- cbind(jobs[,1:9],
              salary_range = jobs$salary_range_to - jobs$salary_range_from,
              salary_midpoint = (jobs$salary_range_to + jobs$salary_range_from) / 2,
              jobs[,10:25])

table(jobs$salary_frequency)
table(jobs$X__of_positions)

ggplot(jobs[jobs$salary_frequency=="Annual",], aes(x=salary_range)) + geom_histogram() + ggtitle("Salary Ranges, Annual Salaries")
ggplot(jobs[jobs$salary_frequency=="Annual",], aes(x=salary_midpoint)) + geom_histogram() + ggtitle("Salary Midpoints, Annual Salaries")
ggplot(jobs[jobs$salary_frequency=="Annual",], aes(x=salary_midpoint,y=salary_range)) + geom_point() + ggtitle("Annual Salaries")

ggplot(jobs[jobs$salary_frequency=="Hourly",], aes(x=salary_range)) + geom_histogram() + ggtitle("Salary Ranges, Hourly Salaries")
ggplot(jobs[jobs$salary_frequency=="Hourly",], aes(x=salary_midpoint)) + geom_histogram() + ggtitle("Salary Midpoints, Hourly Salaries")
ggplot(jobs[jobs$salary_frequency=="Hourly",], aes(x=salary_midpoint,y=salary_range)) + geom_point() + ggtitle("Hourly Salaries")

ggplot(jobs[jobs$salary_frequency=="Daily",], aes(x=salary_range)) + geom_histogram() + ggtitle("Salary Ranges, Daily Salaries")
ggplot(jobs[jobs$salary_frequency=="Daily",], aes(x=salary_midpoint)) + geom_histogram() + ggtitle("Salary Midpoints, Daily Salaries")
ggplot(jobs[jobs$salary_frequency=="Daily",], aes(x=salary_midpoint,y=salary_range)) + geom_point() + ggtitle("Daily Salaries")

# interesting stuff in here...