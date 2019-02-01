int NN1toKmaxPredict(
    const int n_train_observations,
    const int n_test_observations,
    const int n_features,
    const int max_neighbors,
    const double *train_input_ptr,
    const double *train_output_ptr,
    const double *test_input_ptr,
    double *test_prediction_ptr
);