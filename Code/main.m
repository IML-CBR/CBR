datasets = {'adult' 'colic' 'hypothyroid'};
dataset_name = datasets{3};

K = 3;  % This value corresponds to the K in KNN
forget_option = 1;
retention_option = 2;

for i=0:9
    [TrainMatrix, TestMatrix, class_names] = readDataset(dataset_name,i);
    
     % This parameter indicates that the first column of the test matrix
     % stores the real class for every instance
    class_column = size(TrainMatrix,2);

    TrainMatrix_v1=maintenanceAlgorithmX(TrainMatrix);
    TrainMatrix_v2=maintenanceAlgorithmY(TrainMatrix);

    num_instances_train = size(TrainMatrix,1);
    
    % First column is the initial goodness, and the second one is the
    % current goodness
    initial_goodness = zeros(num_instances_train, 1)+0.5;
    current_goodness = zeros(num_instances_train, 1)+0.5;
    
    CM = struct('CB',{TrainMatrix},'GB0',initial_goodness,'GB',current_goodness);
    [NewCM, classification, precision] = ...
        acbrAlgorithm(CM ,TestMatrix, class_column, ...
        forget_option, retention_option, K);
    fprintf('Precision: %f\n',precision);
end