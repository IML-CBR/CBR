function [CM, classification, precision] = ...
            acbrAlgorithm(CM, TestMatrix, real_classes, ...
            forget_option, retention_option, K)
% acbrAlgorithm This function classifies all instances in TestMatrix
%               using an ACBR.
%	 INPUT:
%    	- CM: The whole case base, which consists in three parts
%       	- CB: Cell matrix with all the instances in the case base
%       	- GB: Column vector with the goodness of every instance in the case base
%       	- GB0: Column vector with the initial goodness of every instances in the case base
%       - TestMatrix: Cell matrix containing all the instances to classify
%                     (each row is an instance)
%       - real_classes: if set to 1, it will use the last column in TestMatrix
%                   	as the class of the instance, and it will return
%                       the precision of the classification
%       - forget_option: if set to 1, it will perform the oblivion by
%                        goodness method and will, therefore, 
%                        forget some instances in CM.CB.
%                        Otherwise, it will not forget any instance
%   	- retention_option: 4 different options can be provided, any other
%                           value will be treated as a 1
%                            - 1: No new instance is retained
%                            - 2: All new instances are added
%                            - 3: New instances are added according to the
%                                 minimal goodness method (unsupervised)
%                            - 4: New instances are added according to the
%                                 detrimental retention method (it is a supervised
%                                 method and, therefore, real_classes must have
%                                 been set to 1)
%   	- K: It indicates the 'k' parameter to be used in the K-NN method
            
    
    % This stores the classes decided for every test instance
    num_instances_test = size(TestMatrix,1);
    classification = zeros(num_instances_test,1); 
    
    % In case we know the true classes, this code stores them in
    % 'true_classes', and removes them from 'test_data'
    if real_classes == 1
        correctly_classified_instances = 0;
    end
    
    for i = 1:num_instances_test
        current_instance = TestMatrix(i,:);
%         current_label = TestMatrix(i,size(TestMatrix,2)-1:end);
        
        % Here we get the K retrieved indexes, and later the K retrieved
        % cases to which these indexes correspond
        [retrieved_cases, retrieved_indexes] = acbrRetrievalPhase(CM.CB, current_instance, K);  
        if (max(retrieved_indexes) > 160)
            a = 1;
        end
        %         retrieved_cases = CM.CB(retrieved_indexes,:);
        
        % Here we have the final class that is choosen
        choosen_class = acbrReusePhase(current_instance, retrieved_cases);
        classification(i,1) = choosen_class;
        
        % In case we know the real class of each test instance
        if real_classes == 1 
            % We decide if it is correctly classified or not
            is_correctly_classified = acbrRevisionPhase(choosen_class, current_instance, CM, TestMatrix); 
            if is_correctly_classified == 1
                correctly_classified_instances = correctly_classified_instances + 1;    % If so, we count it as a correct instance
            end
        end
        if max(retrieved_indexes) > size(CM.CB,1)
            a=1;
        end
        [CM, retrieved_indexes] = acbrReviewPhase(retrieved_indexes, CM, ...
                                current_instance, choosen_class, forget_option);
        CM = acbrRetentionPhase(CM, current_instance, retrieved_indexes, retention_option, choosen_class);
    end
    
    if real_classes ~= -1
        precision = 100*correctly_classified_instances / num_instances_test;
    else
        precision = -1;
    end
end