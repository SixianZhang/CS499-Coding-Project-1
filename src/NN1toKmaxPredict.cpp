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
  Eigen::Map <Eigen::MatrixXd> train_input_matrix(train_input_ptr,
                                                  n_train_observations, n_features);
  Eigen::Map <Eigen::MatrixXd> test_input_matrix(test_input_ptr, 
                                                  n_test_observations, n_features);
  Eigen::MatrixXd dist_matrix(n_test_observations, n_train_observations);
  
  Eigen::VectorXi sorted_index_matrix(n_test_observations, n_train_observations);
  
  for (int test_index = 0; test_index < n_test_observations; test_index++)
  {
    for (int train_index = 0; train_index < n_train_observations; train_index++)
    {
      dist_matrix(test_index,train_index) = 
        (train_input_matrix.row(train_index) - test_input_matrix.row(test_index)).norm();
      
      sorted_index_matrix(test_index, train_index) = train_index; 
    }
  }
  
  for (int test_index = 0; test_index < n_test_observations; test_index++)
  {
    std::sort(sorted_index_matrix.row(test_index).data(),
               sorted_index_matrix.row(test_index).data() + n_train_observations, 
               [&dist_matrix, &test_index](int leftside, int rightside){
                   return dist_matrix(test_index, leftside) < dist_matrix(test_index, rightside);
                 });
  }

  
}