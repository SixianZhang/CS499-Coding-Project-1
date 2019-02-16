
binary.base.loss <- function(y.vec, fold.vec, n.folds){
  base.loss = c(rep(0, n.folds))
  index1 <- which(y.vec == 1)
  index0 <- which(y.vec == 0)
  if (length(index1) >= length(index0)){
    base.predict <- 1
  }else{
    base.predict <- 0
  }
  
  for (fold.i in seq(n.folds)){
    validation.index = which(fold.vec == fold.i)
    num.valid <- length(validation.index)
    base.predict.vec <- rep(base.predict, num.valid)
    num.miss.index <- which((base.predict.vec != y.vec[validation.index]) == 1)
    base.loss[fold.i] = length(num.miss.index) / num.valid 
  } 
  base.loss
}
  

#Data 1: spam
#----------------------Data Initialization-------------------------------
data(spam, package = "ElemStatLearn")
n.folds = 3L
X.mat <- data.matrix(subset(spam,select = -c(spam)))
y.vec <- spam$spam
levels(y.vec) <- c(0,1)
y.vec <- as.double(as.vector(y.vec))
testX.mat <- X.mat[c(1,nrow(X.mat)),]
max.neighbors <- 30L
fold.vec <- sample(rep(1:n.folds, l = nrow(X.mat)))
#------------------------------------------------------------------------

#-------------------Prediction vs original data--------------------------
#X.mat: double matrix; y.vec: double vector; testX.mat: samller double matrix
C.pred.model <- NNLearnCV(X.mat, y.vec, max.neighbors, fold.vec, n.folds)
prediction.output <- C.pred.model$predict(testX.mat)
original.output <- y.vec[c(1,nrow(X.mat))]
pred.vs.og <- rbind(original.output, prediction.output)
colnames(pred.vs.og) <- c("Test1","Test2")
pred.vs.og
#-------------------------------------------------------------------------

# ouput 2x3 matirx of nearst-neighbor-predicaton accuracy VS base-line prediction
base.loss <- binary.base.loss(y.vec, fold.vec, n.folds)
nnp.predict.loss <- colMeans(C.pred.model$validation.loss.mat)
nnploss.vs.baseloss <- rbind(nnp.predict.loss, base.loss)
colnames(nnploss.vs.baseloss) <- c("Fold1","Fold2","Fold3")
nnploss.vs.baseloss



barplot(
  nnploss.vs.baseloss,
  main = "Binary Classification: spam",
  xlab = "mean loss value",
  legend = (rownames(nnploss.vs.baseloss)),
  beside = TRUE
)

matplot(
  y = cbind(C.pred.model$validation.loss.vec, C.pred.model$train.loss.vec),
  xlab = "neighbors",
  ylab = "mean loss value",
  type = "l",
  lty = 1:2,
  pch = 15,
  col = c(17)
)

dot.x <- C.pred.model$selected.neighbors
dot.y <- C.pred.model$validation.loss.vec[dot.x]
matpoints(x = dot.x,
          y = dot.y,
          col = 2,
          pch = 19)
legend(
  x = max.neighbors,
  0,
  c("Validation loss", "Train loss"),
  lty = 1:2,
  xjust = 1,
  yjust = 0
)
#------------------------------------------------------------------------------

#Data 2: SAheart
#--------------------Data Initalization---------------------------
data(SAheart, package = "ElemStatLearn")
n.folds = 3L
X.mat <- data.matrix(subset(SAheart, select = -10))
y.vec <- SAheart[,10]
y.vec <- as.double(as.vector(y.vec))
testX.mat <- X.mat[c(1, nrow(X.mat)-1),]
max.neighbors <- 30L
fold.vec <- sample(rep(1:n.folds, l = nrow(X.mat)))
#------------------------------------------------------------------
#-----------------------Prediction vs original data----------------
C.pred.model <- NNLearnCV(X.mat, y.vec, max.neighbors, fold.vec, n.folds)
prediction.output <- C.pred.model$predict(testX.mat)
original.output <- y.vec[c(1,nrow(X.mat))]
pred.vs.og <- rbind(original.output, prediction.output)
colnames(pred.vs.og) <- c("Test1","Test2")
pred.vs.og
#-------------------------------------------------------------------------

# ouput 2x3 matirx of nearst-neighbor-predicaton accuracy VS base-line prediction
base.loss <- binary.base.loss(y.vec, fold.vec, n.folds)
nnp.predict.loss <- colMeans(C.pred.model$validation.loss.mat)
nnploss.vs.baseloss <- rbind(nnp.predict.loss, base.loss)
colnames(nnploss.vs.baseloss) <- c("Fold1","Fold2","Fold3")
nnploss.vs.baseloss

barplot(
  nnploss.vs.baseloss,
  main = "Binary Classification: SAheart",
  xlab = "mean loss value",
  legend = (rownames(nnploss.vs.baseloss)),
  beside = TRUE
)

dot.x <- C.pred.model$selected.neighbors
dot.y <- C.pred.model$validation.loss.vec[dot.x]

matplot(
  y = cbind(C.pred.model$validation.loss.vec, C.pred.model$train.loss.vec),
  xlab = "neighbors",
  ylab = "mean loss value",
  type = "l",
  lty = 1:2,
  pch = 15,
  col = c(17)
)

matpoints(x = dot.x,
          y = dot.y,
          col = 2,
          pch = 19)


legend(
  x = max.neighbors,
  0,
  c("Validation loss", "Train loss"),
  lty = 1:2,
  xjust = 1,
  yjust = 0
)

#Data 3: zip.train
#--------------------Data Initalization---------------------------
data(zip.train, package = "ElemStatLearn")
n.folds = 3L
entire.mat <- data.matrix(zip.train)
y.vec <- entire.mat[,1]
binary.index <- which((y.vec == 1) | (y.vec == 0))
X.mat <- entire.mat[binary.index,]
y.vec <- y.vec[binary.index]
testX.mat <- X.mat[c(1, nrow(X.mat)-1),]
max.neighbors <- 30L
fold.vec <- sample(rep(1:n.folds, l = nrow(X.mat)))

#------------------------------------------------------------------
#-----------------------Prediction vs original data----------------
C.pred.model <- NNLearnCV(X.mat, y.vec, max.neighbors, fold.vec, n.folds)
prediction.output <- C.pred.model$predict(testX.mat)
original.output <- y.vec[c(1,nrow(X.mat))]
pred.vs.og <- rbind(original.output, prediction.output)
colnames(pred.vs.og) <- c("Test1","Test2")
pred.vs.og
#-------------------------------------------------------------------------

# ouput 2x3 matirx of nearst-neighbor-predicaton accuracy VS base-line prediction
base.loss <- binary.base.loss(y.vec, fold.vec, n.folds)
nnp.predict.loss <- colMeans(C.pred.model$validation.loss.mat)
nnploss.vs.baseloss <- rbind(nnp.predict.loss, base.loss)
colnames(nnploss.vs.baseloss) <- c("Fold1","Fold2","Fold3")
nnploss.vs.baseloss

barplot(
  nnploss.vs.baseloss,
  main = "Binary Classification: zip.train",
  xlab = "mean loss value",
  legend = (rownames(nnploss.vs.baseloss)),
  beside = TRUE
)

dot.x <- C.pred.model$selected.neighbors
dot.y <- C.pred.model$validation.loss.vec[dot.x]

matplot(
  y = cbind(C.pred.model$validation.loss.vec, C.pred.model$train.loss.vec),
  xlab = "neighbors",
  ylab = "mean loss value",
  type = "l",
  lty = 1:2,
  pch = 15,
  col = c(17)
)

matpoints(x = dot.x,
          y = dot.y,
          col = 2,
          pch = 19)
legend(
  x = max.neighbors,
  0,
  c("Validation loss", "Train loss"),
  lty = 1:2,
  xjust = 1,
  yjust = 0
)