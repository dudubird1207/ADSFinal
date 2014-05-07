# PLEASE READ!!

### Pipeline
```
data_processing.R > jobs.Rda
(optional) exploratory.R > jobs.Rda
VariableConstruction.R > jobs.Rda
fix_geocode_mising_data.R > jobs.Rda
split_train_test.R > jobs.RData
("master" model fitting script that calls a script for each model)
("master" script for plotting KL divergence and RMSE for each model)
```

### Notation
From `code_skeleton.R`:
```
Y 					= salary midpoint
K 					= number of topics
Kmax 				= the maximum K we will try
I 					= number of docs
N 					= number of words in the whole corpus,
						i.e. all the words strung together in one big document
N_i 				= number of words in doc i
i(n) 				= document i as a function of word n, i.e. the document that contains word n
theta_i 			= distribution over topics for doc i
phi_i,k 			= distribution over words for doc i, topic k
w_n 				= the nth word in the corpus
t_n 				= topic of the nth word in the corpus
T_i 				= imputed count of topics in doc i,
						e.g. (T_i)_k = 10 means "topic k appears 10 times in doc i" 
X_i 				= prevalence covariates
G 					= number of levels of Z, when it is converted into a single factor
g(i) 				= level of Z for document i.
Z_i 				= content covariates
U_i 				= salary-specific covariates
beta 				= regression coefficients for X, Z, U, and T
gamma 				= coefficients for X for prior on theta
mu 					= X' * gamma
kappa_0 			= word frequency in the whole corpus
kappa_k 			= word frequency within topic k
kappa_g 			= word frequency among all documents at level g of Z
kappa_k,g 			= word frequency within topic k at level g of Z
```

### Variable names
For data frame `jobs`

Y
```
salary 					= midpoint of salary, our dependent variable Y
```

X
```
agency.bin				= Agency
level.bin				= Level
```

Z
```
agency.bin				= Agency
level.bin				= Level
```

U
```
posting_type			= Posting type ( boxplots show nothing... candidate for interaction? )
level.bin				= Level
work_location			= Locations
residency_requirement	= Residency request
length_text				= Length of text
reading_score			= Reading score
```

### Research design
From `code_skeleton.R`:
```
1. Split sample into training and test data (DONE - split_train_test.R)
2. Clean the numerical data (DONE - data_processing.R)
3. Clean the text data (DONE - Yiran's Code??)
4. Determine variables for X, Z, and U (DONE)
5. Generate needed variables (DONE - VariableConstruction.R)
6. Estimate and plot criterion (internal? external?) as a function of K:
		-- LDA and regression ( - )
		-- STM and regression ( - )
		-- regSTM ( - )
7. Cross-validate? Test on validation data?
8. Repeat, excluding "level" from covariates to rule out overfitting
```

### TO DO:
From `TODO.txt`:
```
Standardize variable names
Standardize function arguments
Write model-fitting functions that take K as an argument
Write a readme
Decide on model selection criterion
Decide on a prediction regime
Perplexity function
```
