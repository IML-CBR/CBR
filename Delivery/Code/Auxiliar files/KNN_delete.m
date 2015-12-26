function [time_distances,total_time,time_sort,mean_distances] = ...
            KNN_delete(CB, c_new, k)
    CB_attributes = CB(:,1:size(CB,2)-1);  
    c_new = c_new(1:size(c_new,2)-1);
    
    if isempty(CB_attributes) || isempty(c_new) || (k == 0)
        Kbase = [];
        K_indexes = [];
        K_distances = [];
    else
        CB_labels = CB(:,size(CB,2));
        distances = zeros(1,size(CB_attributes,1));
        for i=1:size(CB_attributes,1)
            distances(i) = caseDistance(c_new, CB_attributes(i,:));
        end
        
        % order the data in ascendent the cases in descending order
        [distances, order] = sort(distances, 'ascend'); % sort cols low to high
        K_indexes = order(1:k);
        Kbase = [CB_attributes(K_indexes,:) CB_labels(K_indexes)];
        K_distances = distances(1:k);
    end
end
