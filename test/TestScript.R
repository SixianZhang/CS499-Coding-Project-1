data(zip.train, package = "ElemStatLearn")
X <- zip.train[1:5, -1]
y <- zip.train[1:5, 1]
Xtest <- matrix(zip.train[6:7, -1], ncol = ncol(X))
ytest <- (zip.train[6, 1])
max.neighbor <- 3L
ypredict <- 0
# .C(
#   "NN1toKmaxPredict_interface",
#   as.integer(nrow(X)),
#   as.integer(nrow(Xtest)),
#   as.integer(ncol(X)),
#   as.integer(max.neighbor)
#   as.double(X),
#   as.double(y),
#   as.double(Xtest),
#   as.double(ypredict)
# )
list <- NN1toKmaxPredict(X,y,Xtest,max.neighbor)
list <- NNLearnCV(X,y,max.neighbor,NULL,2L)
