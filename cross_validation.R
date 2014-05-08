set.seed(6)

split_train_test <- function(.data,)
  
  sweep_k <- function(model,){
    
    
    
  }

drawTheta <- function(){
  
  
  
}

predict_rmse <- function(){
  
  
  
}

predict_kldiv <- function(){
  
  
  
}

crossvalidate <- function( .model, .data, nfolds ){
  
  .data   <- split_train_test( .data )
  
  
  
  test    <- .data[[ reserved_fold ]]
  train   <- .data[[ -reserved_fold ]]
  
  result <- replicate(nfolds,list)
  
  for( xval_iteration in 1:nfolds ){
    
    model <- "lda"
    result[[xval_iteration]]$lda <- replicate(Kmax,list())
    for( K in 1:Kmax ){
      
      result[[xval_iteration]]$lda <- replicate(K,list())
      result[[xval_iteration]]$lda[[K]]$fit             <- sweep_k( model, train, K )
      result[[xval_iteration]]$lda[[K]]$simulated_theta <- drawTheta( model, train, result[[K]]$fit )
      result[[xval_iteration]]$lda[[K]]$rmse            <- predict_rmse( model, result[[K]]$fit, result[[K]]$simulated_theta, test )
      result[[xval_iteration]]$lda[[K]]$kldiv           <- predict_kldiv( model, result[[K]]$fit, result[[K]]$simulated_theta, test )
      
    }
    
    model <- "stm"
    result[[xval_iteration]]$stm <- replicate(Kmax,list())
    for( K in 1:Kmax ){
      
      result[[xval_iteration]]$stm <- replicate(K,list())
      result[[xval_iteration]]$stm[[K]]$fit             <- sweep_k( model, train, K )
      result[[xval_iteration]]$stm[[K]]$simulated_theta <- drawTheta( model, train, result[[K]]$fit )
      result[[xval_iteration]]$stm[[K]]$rmse            <- predict_rmse( model, test, result[[K]]$fit, result[[K]]$simulated_theta )
      result[[xval_iteration]]$stm[[K]]$kldiv           <- predict_kldiv( model, test, result[[K]]$fit, result[[K]]$simulated_theta )
      
    }
    
    model <- "rstm"
    result[[xval_iteration]]$rstm <- replicate(Kmax,list())
    for( K in 1:Kmax ){
      
      result[[xval_iteration]]$rstm <- replicate(K,list())
      result[[xval_iteration]]$rstm[[K]]$fit             <- sweep_k( model, train, K )
      result[[xval_iteration]]$rstm[[K]]$simulated_theta <- drawTheta( model, train, result[[K]]$fit )
      result[[xval_iteration]]$rstm[[K]]$rmse            <- predict_rmse( model, test, result[[K]]$fit, result[[K]]$simulated_theta )
      result[[xval_iteration]]$rstm[[K]]$kldiv           <- predict_kldiv( model, test, result[[K]]$fit, result[[K]]$simulated_theta )
      
    }
    
  }
  
  return(result)
  
}
