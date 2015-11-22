function TrainMatrix_reduced = RNN(TrainMatrix, already_reduced)
    if already_reduced ~= 1
        TrainMatrix = CNN(TrainMatrix);
    end
    
    TrainMatrix_reduced = TrainMatrix;
    class_index = size(TrainMatrix, 2);
    num_instances = size(TrainMatrix, 1);
    for i = num_instances:-1:1
        current_instance = TrainMatrix_reduced(i,:);
        aux_mat = true(1, size(TrainMatrix_reduced, 1));
        aux_mat(i) = false;
        TrainMatrix_reduced = TrainMatrix_reduced(aux_mat, :);
        
        for j = 1:num_instances
            current_test_instance = TrainMatrix(j,:);
            K = KNN(TrainMatrix_reduced, current_test_instance, 1);
            new_class = cell2mat(K(class_index));
            if new_class ~= cell2mat(current_test_instance(class_index))
                TrainMatrix_reduced = ...
                        [TrainMatrix_reduced(1:i-1,:);current_instance;...
                        TrainMatrix_reduced(i:end,:)];
                break;
            end
        end
    end
end