#' 1 to k nearest neighbor algorithm
#' 
#' R function that wraps the C++ NN1toKmaxPredict method. 
#' 
#' @param X.mat numeric train feature matrix [n x p]
#' @param y.vec numeric train label vector [n x 1], 0/1 for binary classification, real number for regression.
#' @param testX.mat numeric test feature matrix 
#' @param max.neighbors scalar integer, max number of neighbor 
#'
#' @return numeric matrix of size [nrow(testX.mat) x max.neighbors], prediction of the test data using K from 1 to max.neighbors 
#' @export
#'
#' @examples 
#' #####################Regression#########################
#' data(zip.train, package = "ElemStatLearn")
#' X.mat <- zip.train[1:100, -1]
#' y.vec <- zip.train[1:100, 1]
#' testX.mat <- matrix(zip.train[101:105, -1],ncol = ncol(X.mat))
#' max.neighbors <- 30L
#' predict.list <- NN1toKmaxPredict(X.mat,y.vec,testX.mat,max.neighbors)
#' predict.list
#' zip.train[101:105, 1]
#' 
#' ##################Binary Classification#################
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


NN1toKmaxPredict <- function(X.mat,y.vec,testX.mat,max.neighbors){
  if(!all(is.matrix(X.mat),is.numeric(X.mat))){
    stop("X.mat must be a numeric matrix")
  }
  if(!all(is.numeric(y.vec), is.vector(y.vec),length(y.vec) == nrow(X.mat))){
    stop("y.vec must be a numeric vector of size(X.mat)")
  }
  if(!all(is.numeric(testX.mat), is.matrix(testX.mat), ncol(testX.mat) == ncol(X.mat))){
    stop("testX.mat must be a numeric matrix with ncol(X.mat) columns")
  }
  if(!all(is.integer(max.neighbors), length(max.neighbors) == 1)){
    stop("max.neighbors must be an integer scalar")
  }
  
  # rep(0,nrow(X.mat)*max.neighbors)
  
  result.list <- .C(
    "NN1toKmaxPredict_interface",
    n.observation = as.integer(nrow(X.mat)),
    n.test = as.integer(nrow(testX.mat)),
    n.feature = as.integer(ncol(X.mat)),
    max.neighbors = as.integer(max.neighbors),
    X.mat = as.double(X.mat),
    y.vec = as.double(y.vec),
    testX.mat = as.double(testX.mat),
    prediction = as.double(matrix(rep(0,nrow(testX.mat)*max.neighbors), nrow = nrow(testX.mat))),
    # test = as.integer(matrix(rep(0,nrow(testX.mat)*nrow(X.mat)), nrow = nrow(testX.mat))),
    # # dist = as.double(matrix(rep(0,nrow(testX.mat)*nrow(X.mat)), nrow = nrow(testX.mat))),
    PACKAGE = "NearestNeighbors"
  )
  result.list$prediction = matrix(result.list$prediction,ncol = max.neighbors)
  # result.list$test = matrix(result.list$test,ncol = nrow(X.mat))
  
  return(result.list$prediction)
  # return(result.list)
}