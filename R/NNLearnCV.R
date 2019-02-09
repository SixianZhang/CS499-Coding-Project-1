#' Cross-validation using nearest neighbors
#'
#' Using nearest neighbors algorithm for cross validation to find out the best K and give a prediction of the test data based on it.
#'
#' @param X.mat numeric train feature matrix [n x p]
#' @param y.vec numeric train label vector [n x 1], 0/1 for binary classification, real number for regression.
#' @param max.neighbors scalar integer, max number of the neighbors
#' @param fold.vec integer vector that holds fold ID number [n x 1]
#' @param n.folds scalar integer, number of the folds
#'
#' @return
#' @export
#'
#' @examples
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
    
    if (!all(
      !is.null(fold.vec),
      is.vector(fold.vec),
      is.numeric(fold.vec),
      length(fold.vec) == length(y.vec)
    )) {
      stop("fold.vec must be a vector with the length of length(y.vec)")
    }
    
    if (!all(is.integer(n.folds), length(n.fold) == 1)) {
      stop("n.fold must be an integer scalar")
    }
    
    # Assign random fold sequence if it is null
    if (is.null(fold.vec)) {
      fold.vec <- sample(rep(1:n.folds, l = nrow(X.mat)))
    }
    
    #
    for (fold.i in seq_len(n.fold)) {
      validation.index <- which(fold.vec == fold.i)
      train.index <- which(fold.vec != fold.i)
      for (prediction.set.name in c("train", "validation")) {
        if(predictioni.set.name == "train"){
        predict.mat <-
          NN1toKmaxPredict(X.mat[train.index,], y.vec[train.index], X.mat[train.index], max.neighbors)
        loss.mat <- 
        }
      }
    }
    
    
    
  }