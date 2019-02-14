data(zip.train, package = "ElemStatLearn")
X.mat <- zip.train[1:100, -1]
y.vec <- zip.train[1:100, 1]
testX.mat <- matrix(zip.train[101:105, -1],ncol = ncol(X.mat))
testy <- zip.train[101:105, 1]
max.neighbors <- 3L
# ypredict <- 0
# .C(
#   "NN1toKmaxPredict_interface",
#   as.integer(nrow(X)),
#   as.integer(nrow(Xtest)),
#   as.integer(ncol(X)),
#   as.integer(max.neighbor),
#   as.double(X),
#   as.double(y),
#   as.double(Xtest),
#   as.double(ypredict)
# )
list <- NN1toKmaxPredict(X.mat,y.vec,testX.mat,max.neighbors)
list$prediction