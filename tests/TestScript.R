data(spam, package = "ElemStatLearn")
X.mat = data.matrix(subset(spam,select = -c(spam)))

y.vec = spam$spam
levels(y.vec) <- c(0,1)
y.vec <- as.double(as.vector(y.vec))

testX.mat = X.mat[c(1,nrow(X.mat)),]
max.neighbors = 5L

C.pred.mat <-
  NN1toKmaxPredict(X.mat, y.vec, testX.mat, max.neighbors)
C.pred.mat

C.pred.model <- NNLearnCV(X.mat,y.vec,max.neighbors,NULL,5L)
C.pred.model$predict(testX.mat)