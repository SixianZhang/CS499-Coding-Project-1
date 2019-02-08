#include <Eigen/Dense>
#include <iostream>
#include <omp.h> 
#include "NN1toKmaxPredict.h"

int NN1toKmaxPredict(
  const int n_train_observations,
  const int n_test_observations,
  const int n_features,
  const int max_neighbors,
  double *train_input_ptr,   // a matrix training data inputs
  double *train_output_ptr,  //a vector of training data outputs
  double *test_input_ptr,  // test input matrix
  double *test_prediction_ptr  //predication of test data
){
  if (n_train_observations < 1) {return ERROR_NO_TRAINDATA;}
  if (n_test_observations < 1) {return ERROR_NO_TESTDATA;}
  if (n_features < 1) {return ERROR_NO_FEATURES;}
  if (n_train_observations < max_neighbors) {return ERROR_TOO_MANY_NEIGHBORS;}
  if (max_neighbors < 1) {return ERROR_TOO_FEW_NEIGHBORS;}
  
  //Access training matrix or vector
  Eigen::Map <Eigen::MatrixXd> train_input_matrix(train_input_ptr, n_train_observations, n_features);
  Eigen::Map <Eigen::VectorXd> train_ouput_matrix(train_output_ptr, n_train_observations);
  
  
  return 0;
}