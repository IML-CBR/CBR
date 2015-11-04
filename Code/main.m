TrainMatrix = [2; 2; 2; 2; 2];
TestMatrix = [2 1; 2 1; 2 1];
class_column = 1; % This parameter indicates that the first column of the test matrix stores the real class for every instance

[NewTrainMatrix, classification, precision] = acbrAlgorithm(TrainMatrix ,TestMatrix, class_column)