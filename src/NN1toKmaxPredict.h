const int ERROR_NO_TRAINDATA = 1;
const int ERROR_NO_TESTDATA = 2;
const int ERROR_NO_FEATURES = 3;
const int ERROR_TOO_FEW_NEIGHBORS = 4;
const int ERROR_TOO_MANY_NEIGHBORS = 5;

int NN1toKmaxPredict(
    const int n_train_observations,
    const int n_test_observations,
    const int n_features,
    const int max_neighbors,
    double *train_input_ptr,
    double *train_output_ptr,
    double *test_input_ptr,
    double *test_prediction_ptr
    // int *another_ptr
);

