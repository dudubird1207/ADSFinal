set.seed(6)

N_obs <- dim(jobs)[1]
test_ids <- sample( N_obs , N_obs %/% 4 )
train_ids <- 
