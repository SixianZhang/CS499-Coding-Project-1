# include "NN1toKmaxPredict.h"
# include "R.h"
# include "R_ext/Rdynload.h"

void NN1toKmaxPredict_interface(
  const int *n_train_observations,
  const int *n_test_observations,
  const int *n_features,
  const int *max_neighbors,
  double *train_input_ptr,
  double *train_output_ptr,
  double *test_input_ptr,
  double *test_prediction_ptr,
  int *another_ptr
){
  int status = NN1toKmaxPredict(*n_train_observations,*n_test_observations,*n_features,*max_neighbors,train_input_ptr,train_output_ptr,test_input_ptr,test_prediction_ptr,another_ptr);
  if(status != 0){
    error("some error message");
  }
}

R_CMethodDef cMethods[] = {
  {"NN1toKmaxPredict_interface",(DL_FUNC) &NN1toKmaxPredict_interface,9},
  {NULL,NULL,0}
};

extern "C"{
  void R_init_NearestNeighbors(DllInfo *info){
    R_registerRoutines(info,cMethods,NULL,NULL,NULL);
    R_useDynamicSymbols(info,FALSE);
  }
}