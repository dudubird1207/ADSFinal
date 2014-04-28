## This is a skeleton of what our code will eventually look like.
## We can fill in pieces as we develop, write, and test them.

#### NOTATION:
# Y = salary midpoint
# K = number of "brackets" for Y
# k = referring to the kth bracket, out of K total
# Kmax = the maximum K we will try
# X'(K) = set of protowords, as a function of K. Remember that if we have J
#        protowords for each bracket, then we will have K*J predictors in this set.
# Z = set of other features such as posting length.
# X(K) = X'(K) U Z


#### STEPS:
# 1. Split sample and reserve test data.
# 2. Use exploratory/graphical methods to determine Kmax
# 3. For each K in 2:Kmax
#		Derive the set of protowords for each class k as a function of K
# 4. Come up with appropriate specifications for each of our models:
#	a. Regression
#	b. Ordinal GLM
#	c. Probability model
#	d. Decision tree
# 5. For every K, fit each model
# 6. For every model and every K, compute a variety of diagnostics:
#	a. Some indicator of predictive accuracy... (MAE, MAPE, MSE?)
#	b  i. Average log predictive density
#	b ii. K-L distance of test data to posterior predictive
#	c. Bayes factor

source( "split_train_test.R" )
# produces variables test_ids, train_ids, N_obs

load ( Z_variables )
# load in Z variables as a formula object

protowords <- function( K ){
	# Yiran's code goes here
	# bin Y into K classes
	# derive some optimal number of protowords
	# call Python code to do this?
	protowords <- # matrix or data frame of all the protoword indicators
}

linearRegression <- function( formula, K ){

}

GLM <- function( formula, K ){

}

naiveBayes <- function( formula, K ){

}

decisionTree <- function( formula, K ){

}

predictive_accuracy <- function( model, K ){
	# percentage-based?
	# `model` is one of the four functions defined above
	# `K` gets passed to `model`

	protowords <- protowords(K)
	X <- data.frame( protowords, Z )
	formula <- as.formula(paste("Y ~ ", paste(names(X),collapse= "+") ))

	if (model == linearRegression){
		Y <- jobs$salary_midpoint
	}
	else{
		Y <- cut(x = jobs$salary_midpoint, breaks = K)
		# use the same K for the protowords and the model itself
	}

	result <- match.fun(model)( formula, K )

}

plot_over_k <- function( diagnostic_function ){
	# diagnostic_function is some function of a model that is parameterized by K
	for (k in 1:K){
		plot( x=k , y= diagnostic_function(K) )
	}
}
