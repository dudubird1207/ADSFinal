## This is a skeleton of what our code will eventually look like.
## We can fill in pieces as we develop, write, and test them.

#### NOTATION:
# Y = salary midpoint
# K = number of topics
# Kmax = the maximum K we will try
# I = number of docs
# N = number of words in the whole corpus,
# 			i.e. all the words strung together in one big document
# N_i = number of words in doc i
# i(n) = document i as a function of word n, i.e. the document that contains word n
# theta_i = distribution over topics for doc i
# phi_i,k = distribution over words for doc i, topic k
# w_n = the nth word in the corpus
# t_n = topic of the nth word in the corpus
# T_i = imputed count of topics in doc i,
# 			e.g. (T_i)_k = 10 means "topic k appears 10 times in doc i" 
# X_i = prevalence covariates
# G = number of levels of Z, when it is converted into a single factor
# g(i) = level of Z for document i.
# Z_i = content covariates
# U_i = salary-specific covariates
# beta = regression coefficients for X, Z, U, and T
# gamma = coefficients for X for prior on theta
# mu = X' * gamma
# kappa_0 = word frequency in the whole corpus
# kappa_k = word frequency within topic k
# kappa_g = word frequency among all documents at level g of Z
# kappa_k,g = word frequency within topic k at level g of Z

# ### RESEARCH DESIGN:
# 1. Split sample into training and test data (DONE - split_train_test.R)
# 2. Clean the numerical data (DONE - data_processing.R)
# 3. Clean the text data (DONE - )
# 4. Determine variables for X, Z, and U (DONE - )
# 5. Generate needed variables (DONE - )
# 6. Estimate and plot criterion (internal? external?) as a function of K:
# 		-- LDA and regression ( - )
# 		-- STM and regression ( - )
# 		-- regSTM ( - )
# 7. Cross-validate? Test on validation data?

# ### TO DO:
# Standardize variable names
# Standardize function arguments
# Write model-fitting functions that take K as an argument
# Write a readme
# Decide on model selection criterion
# Decide on a prediction regime

source( "split_train_test.R" )
# produces variables test_ids, train_ids, N_obs

plot_over_k <- function( diagnostic_function ){
	# diagnostic_function is some function of a model that is parameterized by K
	for (k in 1:K){
		plot( x=k , y= diagnostic_function(K) )
	}
}
