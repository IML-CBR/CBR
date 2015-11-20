function [CM, classification, precision] = ...
            acbrAlgorithm(CM, TestMatrix, real_classes, ...
            forget_option, retention_option, K)
    
    
    % This stores the classes decided for every test instance
    num_instances_test = size(TestMatrix,1);
    classification = zeros(num_instances_test,1); 
    
    % In case we know the true classes, this code stores them in
    % 'true_classes', and removes them from 'test_data'
    if real_classes ~= -1
        correctly_classified_instances = 0;
    end
    
    for i = 1:num_instances_test
        current_instance = TestMatrix(i,1:size(TestMatrix,2)-1);
        current_label = TestMatrix(i,size(TestMatrix,2)-1:end);
        
        % Here we get the K retrieved indexes, and later the K retrieved
        % cases to which these indexes correspond
        [retrieved_cases, retrieved_indexes] = acbrRetrievalPhase(CM.CB, current_instance, K);  
%         retrieved_cases = CM.CB(retrieved_indexes,:);
        
        % Here we have the final class that is choosen
        choosen_class = acbrReusePhase(current_instance, retrieved_cases);
        classification(i,1) = choosen_class;
        
        % In case we know the real class of each test instance
        if real_classes ~= -1 
            is_correctly_classified = acbrRevisionPhase(choosen_class, current_instance, CM, TestMatrix);  % We decide if it is correctly classified or not
            if is_correctly_classified == 1
                correctly_classified_instances = correctly_classified_instances + 1;    % If so, we count it as a correct instance
            end
        end
        
        CM = acbrReviewPhase(retrieved_indexes, CM, ...
                                current_instance, choosen_class, forget_option);
        CM = acbrRetentionPhase(CM, current_instance, retrieved_cases, retention_option);
    end
    
    if real_classes ~= -1
        precision = 100*correctly_classified_instances / num_instances_test;
    else
        precision = -1;
    end
end