#' 1 to k nearest neighbor algorithm
#' 
#' R function that wraps the C++ code.
#' 
#' @param X.mat numeric train feature matrix [n x p]
#' @param y.vec numeric train label vector [n x 1], 0/1 for binary classification, real number for regression.
#' @param textX.mat numeric test feature matrix 
#' @param max.neighbors scalar integer, max number of neighbor 
#'
#' @return result.list 
#' @export
#'
#' @examples

NN1toKmaxPredict <- function(X.mat,y.vec,testX.mat,max.neighbors){
  if(!all(is.matrix(X.mat),is.numeric(X.mat))){
    stop("X.mat must be a numeric matrix")
  }
  if(!all(is.numeric(y.vec), is.vector(y.vec),length(y.vec) == nrow(X.mat))){
    stop("y.cec must be a numeric vector of size(X.mat)")
  }
  if(!all(is.numeric(testX.mat), is.matrix(testX.mat), ncol(testX.mat) == ncol(X.mat))){
    stop("testX.mat must be a numeric matrix with nrcol(X.mat) columns")
  }
  if(!all(is.integer(max.neighbors), length(max.neighbors) == 1)){
    stop("max.neighbors must be an integer scalar")
  }
  
  rep(0,nrow(X.mat)*max.neighbors)
  
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
    PACKAGE = "NearestNeighbors"
  )
  return(result.list)
}