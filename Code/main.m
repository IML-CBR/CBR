datasets = {'waveform' 'segment' 'pen-based'};
dataset_name = datasets{2};
percentage_train = 0.7;
[TrainMatrix, TestMatrix] = readDataset(dataset_name, percentage_train);

 % This parameter indicates that the first column of the test matrix
 % stores the real class for every instance
class_column = size(TrainMatrix,2);

[NewTrainMatrix, classification, precision] = acbrAlgorithm(TrainMatrix ,TestMatrix, class_column);