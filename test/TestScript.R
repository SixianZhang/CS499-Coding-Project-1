data(zip.train, package = "ElemStatLearn")
X <- zip.train[1:5, -1]
y <- zip.train[1:5, 1]
Xtest <- matrix(zip.train[6, -1],ncol = ncol(X))
ytest <- zip.train[6, 1]
max.neighbor <- 3
ypredict <- 0
.C(
  "NN1toKmaxPredict_interface",
  as.integer(nrow(X)),
  as.integer(nrow(Xtest)),
  as.integer(ncol(X)),
  as.integer(max.neighbor),
  as.double(X),
  as.double(y),
  as.double(Xtest),
  as.double(ypredict)
)

