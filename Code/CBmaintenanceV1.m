function NewTrainMatrix=CBmaintenanceV1(TrainMatrix)
    num_instances_train = size(TrainMatrix,1);
    num_instances_select = floor(0.7*num_instances_train);
    selected_indexes = randperm(num_instances_train, num_instances_select);
    
    NewTrainMatrix = TrainMatrix(selected_indexes,:);
end