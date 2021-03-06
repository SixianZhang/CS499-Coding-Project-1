#' Cross-validation using nearest neighbors
#'
#' Using nearest neighbors algorithm for cross validation to find out the best K and 
#' give a prediction of the test data based on it.
#'
#' @param X.mat numeric train feature matrix [n x p]
#' @param y.vec numeric train label vector [n x 1], 0/1 for binary classification, 
#' real number for regression.
#' @param max.neighbors scalar integer, max number of the neighbors
#' @param fold.vec integer vector that holds fold ID number [n x 1]
#' @param n.folds scalar integer, number of the folds
#'
#' @return A list that contains training features and labels, loss matrix and loss 
#' vector of training and validation sets, best neighbor number, and a predict 
#' function using learning result
#' @export
#'
#' @examples 
#' ####################Regression#################
#' data(zip.train, package = "ElemStatLearn")
#' X.mat <- zip.train[1:100, -1]
#' y.vec <- zip.train[1:100, 1]
#' testX.mat <- matrix(zip.train[101:105, -1],ncol = ncol(X.mat))
#' max.neighbors <- 30L
#' cv.list <- NNLearnCV(X.mat,y.vec,max.neighbors,NULL,5L)
#' cv.list$predict(testX.mat)
#' zip.train[101:105, 1]
#' 
#' #################Binary Classification################
#' data(spam, package = "ElemStatLearn")
#' n.folds = 3L
#' X.mat <- data.matrix(subset(spam,select = -c(spam)))
#' y.vec <- spam$spam
#' levels(y.vec) <- c(0,1)
#' y.vec <- as.double(as.vector(y.vec))
#' testX.mat <- X.mat[c(1,nrow(X.mat)),]
#' max.neighbors <- 30L
#' fold.vec <- sample(rep(1:n.folds, l = nrow(X.mat)))
#' C.pred.model <- NNLearnCV(X.mat, y.vec, max.neighbors, fold.vec, n.folds)
#' prediction.output <- C.pred.model$predict(testX.mat)
#' prediction.output
#' y.vec[c(1,nrow(X.mat))]
#' 
NNLearnCV <-
  function(X.mat,
           y.vec,
           max.neighbors = 30L,
           fold.vec = NULL,
           n.folds = 5L) {
    # Check type and dimension
    if (!all(is.matrix(X.mat), is.numeric(X.mat))) {
      stop("X.mat must be a numeric matrix")
    }
    
    if (!all(is.vector(y.vec),
             is.numeric(y.vec),
             length(y.vec) == nrow(X.mat))) {
      stop("y.vec must be a numeric vector with the size of nrow(X.mat)")
    }
    
    if (!all(is.integer(max.neighbors), length(max.neighbors) == 1)) {
      stop("max.neighbors must be an integer scalar")
    }
    
    if (!is.null(fold.vec) && !all(is.vector(fold.vec),
                                   is.numeric(fold.vec),
                                   length(fold.vec) == length(y.vec))) {
      stop("fold.vec must be a vector with the length of length(y.vec)")
    }
    
    if (!all(is.integer(n.folds), length(n.folds) == 1)) {
      stop("n.folds must be an integer scalar")
    }
    
    # Assign random fold sequence if it is null
    if (is.null(fold.vec)) {
      fold.vec <- sample(rep(1:n.folds, l = nrow(X.mat)))
    }
    
    # Initialize train and validation loss matrices
    label.is.binary = (y.vec == 0) || (y.vec == 1)
    train.loss.mat = matrix(rep(0, max.neighbors * n.folds), nrow = max.neighbors)
    validation.loss.mat = matrix(rep(0, max.neighbors * n.folds), nrow = max.neighbors)
    
    
    # Learning process for each fold
    for (fold.i in seq_len(n.folds)) {
      for (prediction.set.name in c("train", "validation")) {
        train.index <- which(fold.vec != fold.i)
        if (prediction.set.name == "train") {
          validation.index = which(fold.vec != fold.i)
        } else{
          validation.index = which(fold.vec == fold.i)
        }
        
        CV.result <-
          NN1toKmaxPredict(X.mat[train.index,], y.vec[train.index], X.mat[validation.index, ], max.neighbors)
        
        CV.result <-
          matrix(CV.result, ncol = max.neighbors)
        
        
        loss.mat <- if (label.is.binary) {
          ifelse(CV.result > 0.5, 1, 0) != y.vec[validation.index]
        } else{
          (CV.result - y.vec[validation.index]) ^ 2
        }
        
        if (prediction.set.name == "train") {
          train.loss.mat[, fold.i] <- colMeans(loss.mat)
        } else{
          validation.loss.mat[, fold.i] <- colMeans(loss.mat)
        }
      }
    }
    
    # Assign results to the output
    train.loss.vec <- rowMeans(train.loss.mat)
    validation.loss.vec <- rowMeans(validation.loss.mat)
    selected.neighbors <- which.min(validation.loss.vec)
    
    # Predict function
    predict <- function(testX.mat) {
      # type demesion check
      if (!all(is.numeric(testX.mat),
               is.matrix(testX.mat),
               ncol(testX.mat) == ncol(X.mat))) {
        stop("testX.mat must be a numeric matrix with ncol(X.mat) columns")
      }
      
      prediction.result <-
        NN1toKmaxPredict(X.mat, y.vec, testX.mat, as.integer(selected.neighbors))
      prediction.vec <-
        prediction.result[, selected.neighbors]
      if (label.is.binary){
        prediction.vec <- ifelse(prediction.vec > 0.5, 1, 0)
      }
      return(prediction.vec)
    }
    
    # Return result
    result.list <-
      list(
        X.mat = X.mat,
        y.vec = y.vec,
        train.loss.mat = train.loss.mat,
        validation.loss.mat = validation.loss.mat,
        train.loss.vec = rowMeans  (train.loss.mat),
        validation.loss.vec = rowMeans(validation.loss.mat),
        selected.neighbors = which.min(validation.loss.vec),
        predict = predict
      )
  }