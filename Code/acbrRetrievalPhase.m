function retrieved_cases = acbrRetrievalPhase(TrainMatrix,current_instance, K)
    % TODO!!!
	% I understand KNN should be implemented
    retrieved_indexes = zeros(K,1);
    num_instances = size(TrainMatrix,1);
    for i=1:K
        random = floor(rand*(num_instances-1)+1);
        while (any(retrieved_indexes==random))
            rand_aux = rand;
            random = floor(rand_aux*(num_instances)+1);
        end
        retrieved_indexes(i,1) = random;
    end
    
    retrieved_cases = TrainMatrix(retrieved_indexes,:);
end