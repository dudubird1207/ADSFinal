set.seed(6)

split_train_test <- function( .data, nfolds ){

  permuted_rows <- sample.int( nrow(.data) )
  split_data <- split( .data[permuted_rows,], nfolds )

  return(split_data)

}
  
sweep_k <- function( model, data, K ){
  # returns a list with the following elements:
  # Theta - matrix
  # Phi - list of matrices
  # beta - vector
  # gamma - vector
  # Sigma_theta - matrix
  # kappa - list of matrices

  if( model = "lda" ){

    Theta <- # lda(data,K)$Theta
    Phi   <- # lda(data,K)$Phi
    beta  <- # lm(y ~ Theta + data)$coefficients
    gamma <- NULL
    Sigma_theta <- # lda(data,K)$sigma
    kappa <- NULL

    return(list(Theta,Phi,beta,gamma,Sigma_theta,kappa))

  }

  else if( model = "stm" ){

    Theta <- # stm(data,K)$theta
    Phi   <- # stm(data,K)$beta$beta
    beta  <- # lm(y ~ Theta + data)$coefficients
    Sigma_theta <- # stm(data,K)$sigma
    gamma <- # stm(data,K)$mu$gamma
    kappa <- # stm(data,K)$beta$kappa

    return(list(Theta,Phi,beta,gamma,Sigma_theta,kappa))

  }

  else if( model = "rstm" ){

    # gross

  }
  
}

drawTheta <- function(){
  
  
  
}

predict_rmse <- function(){
  
  
  
}

predict_kldiv <- function(){
  
  
  
}

nfolds <- 5
crossvalidate <- function( .model, .data, nfolds ){
  
  .data  <- split_train_test( .data, nfolds )
  
  result <- replicate(nfolds,list)
  
  for( xval_iteration in 1:nfolds ){

    test  <- .data[[ xval_iteration ]]
    train <- .data[[ -xval_iteration ]]

    # for each model, sweep from K=5 to K=Kmax by 5

    Kmax <- 100

    # result[[xval_iteration]]$`model`[[K]]$fit contains the following elements:
    # Theta - matrix
    # Phi - list of matrices
    # beta - vector
    # gamma - vector
    # Sigma_theta - matrix
    # kappa - list of matrices

    # result[[xval_iteration]]$`model`[[K]]$simulated_theta contains a matrix

    # result[[xval_iteration]]$`model`[[K]]$rmse contains a real number
    # result[[xval_iteration]]$`model`[[K]]$kldiv contains a real number
    
    model <- "lda"
    result[[xval_iteration]]$lda <- replicate(Kmax,list())
    for( K in seq(from=5,to=Kmax,by=5) ){
      
      result[[xval_iteration]]$lda[[K]]$fit             <- sweep_k( model, train, K )
      result[[xval_iteration]]$lda[[K]]$simulated_theta <- drawTheta( model, test, result[[K]]$fit )
      result[[xval_iteration]]$lda[[K]]$rmse            <- predict_rmse( model, train, test, result[[K]]$fit, result[[K]]$simulated_theta )
      result[[xval_iteration]]$lda[[K]]$kldiv           <- predict_kldiv( model, train, test, result[[K]]$fit, result[[K]]$simulated_theta )
      
    }
    
    model <- "stm"
    result[[xval_iteration]]$stm <- replicate(Kmax,list())
    for( K in seq(from=5,to=Kmax,by=5) ){
      
      result[[xval_iteration]]$stm[[K]]$fit             <- sweep_k( model, train, K )
      result[[xval_iteration]]$stm[[K]]$simulated_theta <- drawTheta( model, test, result[[K]]$fit )
      result[[xval_iteration]]$stm[[K]]$rmse            <- predict_rmse( model, train, test, result[[K]]$fit, result[[K]]$simulated_theta )
      result[[xval_iteration]]$stm[[K]]$kldiv           <- predict_kldiv( model, train, test, result[[K]]$fit, result[[K]]$simulated_theta )
      
    }
    
    model <- "rstm"
    result[[xval_iteration]]$rstm <- replicate(Kmax,list())
    for( K in seq(from=5,to=Kmax,by=5) ){
      
      result[[xval_iteration]]$rstm[[K]]$fit             <- sweep_k( model, train, K )
      result[[xval_iteration]]$rstm[[K]]$simulated_theta <- drawTheta( model, test, result[[K]]$fit )
      result[[xval_iteration]]$rstm[[K]]$rmse            <- predict_rmse( model, train, test, result[[K]]$fit, result[[K]]$simulated_theta )
      result[[xval_iteration]]$rstm[[K]]$kldiv           <- predict_kldiv( model, train, test, result[[K]]$fit, result[[K]]$simulated_theta )
      
    }
    
  }
  
  return(result)
  
}
