% New datasets should be selected in order to be using categorical labels to
datasets = {'waveform' 'segment' 'pen-based'};
dataset_name = datasets{2};
percentage_train = 0.7;
% Is it necessary to normalize data?
% Because arffparser does it as a default
[TrainMatrix, TestMatrix] = readDataset(dataset_name, percentage_train);

 % This parameter indicates that the first column of the test matrix
 % stores the real class for every instance
class_column = size(TrainMatrix,2);

TrainMatrix_v1=CBmaintenanceV1(TrainMatrix);
TrainMatrix_v2=CBmaintenanceV2(TrainMatrix);

[NewTrainMatrix, classification, precision] = ...
    acbrAlgorithm(TrainMatrix ,TestMatrix, class_column, 1, 2);