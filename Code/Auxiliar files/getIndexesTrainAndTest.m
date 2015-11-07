function [indexes_training, indexes_test] = getIndexesTrainAndTest(data, percentage_train)
    num_instances = size(data,1);
    num_instances_train = floor(num_instances*percentage_train);
    indexes_training = randperm(num_instances,num_instances_train);
    
    total_values = 1:num_instances;
    idx=ismember(total_values,indexes_training);
    indexes_test = total_values(~idx);
end