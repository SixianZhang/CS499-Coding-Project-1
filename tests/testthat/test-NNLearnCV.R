library(testthat)
library(NearestNeighbors)
data(prostate, package = "ElemStatLearn")
X.mat <- data.matrix(subset(prostate, select = -c(train, lpsa)))
y.vec <- as.vector(data.matrix(subset(prostate, select = lpsa)))
testX.mat <- X.mat[1:5, ]
max.neighbors <- 3L
n.folds = 5L
fold.vec <- sample(rep(1:n.folds, l = nrow(X.mat)))



test_that("For a valid input,NNLearnCV returns a list",
          {
            C.pred.model <-
              NNLearnCV(X.mat, y.vec, max.neighbors, fold.vec, n.folds)
            expect_true(is.list(C.pred.model))
          })

test_that(
  "The predict function returns a numeric vecotor of size [max.neighbors]",
  {
    C.pred.model <-
      NNLearnCV(X.mat, y.vec, max.neighbors, fold.vec, n.folds)
    C.pred.mat <- C.pred.model$predict(testX.mat)
    expect_equal(length(C.pred.mat),nrow(testX.mat))
  }
)

test_that(
  "The predict function returns a numeric vecotor of size [nrow(testX.mat) x max.neighbors]",
  {
    expect_error(
      C.pred.model <-
        NNLearnCV(as.data.frame(X.mat), y.vec, max.neighbors, fold.vec, n.folds),
      "X.mat must be a numeric matrix",
      fixed = TRUE
    )
    expect_error(
      C.pred.model <-
        NNLearnCV(X.mat, y.vec[-1], max.neighbors, fold.vec, n.folds),
      "y.vec must be a numeric vector with the size of nrow(X.mat)",
      fixed = TRUE
    )
    expect_error(
      C.pred.model <-
        NNLearnCV(X.mat, y.vec, max.neighbors, fold.vec[-1], n.folds),
      "fold.vec must be a vector with the length of length(y.vec)",
      fixed = TRUE
    )
    expect_error(
      C.pred.model <-
        NNLearnCV(X.mat, y.vec, as.double(max.neighbors), fold.vec, n.folds),
      "max.neighbors must be an integer scalar",
      fixed = TRUE
    )
    expect_error(
      C.pred.model <-
        NNLearnCV(X.mat, y.vec, max.neighbors, fold.vec, as.double(n.folds)),
      "n.folds must be an integer scalar",
      fixed = TRUE
    )
  }
)

