
#Data 1: spam
data(spam, package = "ElemStatLearn")
X.mat = data.matrix(subset(spam,select = -c(spam)))

y.vec = spam$spam
levels(y.vec) <- c(0,1)
y.vec <- as.double(as.vector(y.vec))

testX.mat = X.mat[c(1,nrow(X.mat)),]
max.neighbors = 5L


#X.mat: double matrix; y.vec: double vector; testX.mat: samller double matrix
C.pred.mat <-
  NN1toKmaxPredict(X.mat, y.vec, testX.mat, max.neighbors)
C.pred.mat

C.pred.model <- NNLearnCV(X.mat,y.vec,max.neighbors,NULL,3L)
C.pred.model$predict(testX.mat)
y.vec[c(1,nrow(X.mat))]

#Data 2: SAheart
rm(list = ls())
data(SAheart, package = "ElemStatLearn")
X.mat2 <- data.matrix(subset(SAheart, select = -10))

y.vec2 <- SAheart[,10]
y.vec2 <- as.double(as.vector(y.vec2))

testX.mat2 <- X.mat2[c(1, nrow(X.mat2)-1),]
max.neighbors = 5L

C.pred.mat2 <-
  NN1toKmaxPredict(X.mat2, y.vec2, testX.mat2, max.neighbors)
C.pred.mat2

C.pred.model2 <- NNLearnCV(X.mat2,y.vec2,max.neighbors,NULL,3L)
C.pred.model2$predict(testX.mat2)
y.vec2[c(1,nrow(X.mat2)-1)]

#Data 3: zip.train
rm(list = ls())
data(zip.train, package = "ElemStatLearn")
entire.mat <- data.matrix(zip.train)
y.vec3 <- entire.mat[,1]

binary.index <- which((y.vec3 == 1) | (y.vec3 == 0))
X.mat3 <- entire.mat[binary.index,]
y.vec3 <- y.vec3[binary.index]
testX.mat3 <- X.mat3[c(5,nrow(X.mat3)-7),]
max.neighbors = 5L

C.pred.mat3 <-
  NN1toKmaxPredict(X.mat3, y.vec3, testX.mat3, max.neighbors)
C.pred.mat3

C.pred.model3 <- NNLearnCV(X.mat3,y.vec3,max.neighbors,NULL,3L)
C.pred.model3$predict(testX.mat3)
y.vec3[c(5,nrow(X.mat3)-7)]