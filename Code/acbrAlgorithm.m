function [TrainMatrix, classification, precision] = acbrAlgorithm(TrainMatrix, test_data, real_classes)
    K = 3;  % This value corresponds to the K in KNN
    num_instances_test = size(test_data,1);
    num_attributes = size(test_data,2);
    classification = zeros(num_instances_test,1); % This stores the classes decided for every test instance
    
    % In case we know the true classes, this code stores them in
    % 'true_classes', and removes them from 'test_data'
    if real_classes ~= -1
        correctly_classified_instances = 0;
    end
    
    for i = 1:num_instances_test
        current_instance = test_data(i,:);
        
        retrieved_cases = acbrRetrievalPhase(TrainMatrix, current_instance, K);  % Here we get the K retrieved cases
        choosen_class = acbrReusePhase(current_instance, retrieved_cases);      % Here we have the final class that is choosen
        
        classification(i,1) = choosen_class;
        
        if real_classes ~= -1 % In case we know the real class of each test instance
            is_correctly_classified = acbrRevisionPhase(choosen_class, current_instance, TrainMatrix, test_data);  % We decide if it is correctly classified or not
            if is_correctly_classified == 1
                correctly_classified_instances = correctly_classified_instances + 1;    % If so, we count it as a correct instance
            end
        end
        
        TrainMatrix = acbrReviewPhase(retrieved_cases, TrainMatrix, current_instance);
        TrainMatrix = acbrRetentionPhase(TrainMatrix, current_instance);
    end
    
    if real_classes ~= -1
        precision = 100*correctly_classified_instances / num_instances_test;
    else
        precision = -1;
    end
end