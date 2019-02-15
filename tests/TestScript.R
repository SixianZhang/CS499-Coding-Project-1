data(spam, package = "ElemStatLearn")
X.mat = data.matrix(subset(spam,select = -c(spam)))
y.vec = as.vector(data.matrix(subset(spam,select = c(spam))))
testX.mat = X.mat[1:5,]
max.neighbors = 5L

C.pred.mat <-
  NN1toKmaxPredict(X.mat, y.vec, testX.mat, max.neighbors)