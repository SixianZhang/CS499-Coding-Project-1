BaselinePredict <- function(y.vec,fold.vec,n.folds){
  prediction <- rep(NA,n.folds)
  prediction.loss <- rep(NA,n.folds)
  for (fold.i in seq_len(n.folds)){
    train.index <- which(fold.vec != fold.i)
    validation.index <- which(fold.vec == fold.i)
    prediction[fold.i] <- mean(y.vec[train.index])
    prediction.loss[fold.i] <- mean((y.vec[validation.index] - prediction[fold.i])^2)
  }
  return(prediction.loss)
}


# Data 4: prostate

data(prostate, package = "ElemStatLearn")
X.mat = data.matrix(subset(prostate,select = -c(lpsa,train)))
y.vec = as.vector(prostate$lpsa)
n.folds <- 3L
fold.vec <- sample(rep(1:n.folds, l = nrow(X.mat)))

NN.pred.mat <- NNLearnCV(X.mat = X.mat, y.vec = y.vec, fold.vec = fold.vec, n.folds = n.folds)
NN.loss.vec <- NN.pred.mat$train.loss.mat[NN.pred.mat$selected.neighbors,]

baseline.loss.vec <- BaselinePredict(y.vec,fold.vec,n.folds)
result <- t(cbind(NN.loss.vec,baseline.loss.vec))
rownames(result) <- c("Nearest Neighbors","Baseline")
colnames(result) <- c("Fold 1","Fold 2","Fold 3")
result
barplot(result,main = "Regression: prostate",xlab = "mean loss value",legend = (rownames(result)),beside = TRUE)
plot()
# #Data 5: ozone 
# rm(list = ls())
data(ozone, package = "ElemStatLearn")
X.mat = data.matrix(subset(ozone,select = -c(ozone)))
y.vec = as.vector(ozone$ozone)
n.folds <- 3L
fold.vec <- sample(rep(1:n.folds, l = nrow(X.mat)))

NN.pred.mat <- NNLearnCV(X.mat = X.mat, y.vec = y.vec, fold.vec = fold.vec, n.folds = n.folds)
NN.loss.vec <- NN.pred.mat$train.loss.mat[NN.pred.mat$selected.neighbors,]

baseline.loss.vec <- BaselinePredict(y.vec,fold.vec,n.folds)
result <- t(cbind(NN.loss.vec,baseline.loss.vec))
rownames(result) <- c("Nearest Neighbors","Baseline")
colnames(result) <- c("Fold 1","Fold 2","Fold 3")
result
barplot(result,main = "Regression: ozone", xlab = "mean loss value",legend = (rownames(result)),beside = TRUE)