function [Kbase, K_indexes, K_distances] = KNN(CB, c_new, k)
    
CB_attributes = CB(:,1:size(CB,2)-1);  
    c_new = c_new(1:size(c_new,2)-1);
    
    if isempty(CB_attributes) || isempty(c_new) || (k == 0)
        Kbase = [];
        K_indexes = [];
        K_distances = [];
    else
        CB_labels = CB(:,size(CB,2));
        distances = zeros(1,size(CB_attributes,1));
        for i = 1:size(CB_attributes,1)
            c_old = CB_attributes(i,:);
            dist = 0;
            for j=1:size(c_new,2)
                att_new = c_new(j);
                att_old = c_old(j);

                if isempty(att_new{1}) || isempty(att_old{1})
                    dist_cur = 1;
                elseif isnumeric(att_new{1})
                    if isnan(cell2mat(att_new)) || isnan(cell2mat(att_old))
                        dist_cur = 1;
                    else
                        % Euclidean distance part
                        dist_cur = (cell2mat(att_new)-cell2mat(att_old)).^2;
                    end
                else
                    % If equal -> dist = 0, dist = 1 otherwise
                    dist_cur = ~strcmp(att_new, att_old);
                end
                dist = dist + dist_cur;
            end
            distances(i) = dist^0.5;
%             distances(i) = caseDistance(c_new, CB_attributes(i,:));
        end
        
        % order the data in ascendent the cases in descending order
        [distances, order] = sort(distances, 'ascend'); % sort cols low to high
        K_indexes = order(1:k);
        Kbase = [CB_attributes(K_indexes,:) CB_labels(K_indexes)];
        K_distances = distances(1:k);
    end
end

