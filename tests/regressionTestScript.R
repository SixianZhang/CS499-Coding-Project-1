# Data 4: prostate

data(prostate, package = "ElemStatLearn")
X.mat = data.matrix(subset(prostate,select = -c(lpsa,train)))
y.vec = prostate$lpsa

testX.mat = X.mat[c(1,2,7,10,nrow(X.mat)),]
max.neighbors = 5L

C.pred.mat <-
  NN1toKmaxPredict(X.mat, y.vec, testX.mat, max.neighbors)
C.pred.mat

C.pred.model <- NNLearnCV(X.mat,y.vec,max.neighbors,NULL,3L)
C.pred.model$predict(testX.mat)
y.vec[c(1,2,7,10,nrow(X.mat))]


#Data 5: ozone 
rm(list = ls())
data(ozone, package = "ElemStatLearn")
X.mat = data.matrix(subset(ozone,select = -1))
y.vec = ozone[,ncol(ozone)]

testX.mat = X.mat[c(1,2,7,10,nrow(X.mat)),]
max.neighbors = 5L

C.pred.mat <-
  NN1toKmaxPredict(X.mat, y.vec, testX.mat, max.neighbors)
C.pred.mat

C.pred.model <- NNLearnCV(X.mat,y.vec,max.neighbors,NULL,3L)
C.pred.model$predict(testX.mat)
y.vec[c(1,2,7,10,nrow(X.mat))]
