function [ U ] = CNN(CB, labels)
    U = {};
    
    
%     retrieved_indexes = zeros(K,1);
    
    i = 1;
    additions = 0;
    while(size(1,CB)>0)
        max_instances = size(CB,1);
        rand_aux = rand;
        random = floor(rand_aux*(max_instances)+1);
        x = CB(random);
        [z, index] = KNN(CB,x,1);
        if isnumeric(labels(index))
            if labels(index)~=labels(random)
                U(size(U,1)) = x;
            end
        elseif ~strcmp(labels(index),labels(rand))
            U(size(U,1)) = x;
        end
        
        
%         (i <= max_instances) && 
%     for i=1:K
%         random = floor(rand*(num_instances-1)+1);
%         while (any(retrieved_indexes==random))
%             rand_aux = rand;
%             random = floor(rand_aux*(num_instances)+1);
%         end
%         retrieved_indexes(i,1) = random;
    end
end

