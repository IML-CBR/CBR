function TrainMatrix_reduced = RNN(TrainMatrix, already_reduced, knn)
    if already_reduced ~= 1
        TrainMatrix = CNN(TrainMatrix);
    end
    elapsed_time = 0;
%     initial_timer = tic;
    TrainMatrix_reduced = TrainMatrix;
    class_index = size(TrainMatrix, 2);
    num_instances = size(TrainMatrix, 1);
    indexes = true(size(TrainMatrix, 1),1);
    
    if knn == 0
    distances = ones(num_instances)+100;
    for i = 1:num_instances
        c_new = TrainMatrix(i,:);
        c_new = c_new(1:size(c_new,2)-1);
        for k = i:num_instances
            c_old = TrainMatrix(k,:);
            c_old = c_old(1:size(c_old,2)-1);
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
            distances(i,k) = dist^0.5;
        end
    end
    end
    
    for i = num_instances:-1:1
        indexes(i) = false;
        keep = false;
        for j = 1:num_instances
            indexes(j) = 0;
            current_test_instance = TrainMatrix(j,:);
            if knn == 1
                inside_timer = tic;
                TrainMatrix_aux = TrainMatrix_reduced(indexes,:);
                K = KNN(TrainMatrix_aux, current_test_instance, 1);
                elapsed_time = elapsed_time + toc(inside_timer);
                new_class_1 = cell2mat(K(class_index));
            else
                [m,I]=min(distances(j,indexes));
                [m2,I2]=min(distances(indexes,j));
                if (m < m2)
                    aux = TrainMatrix(indexes,:);
                    K_2 = aux(I,:);
                else
                    aux = TrainMatrix(indexes,:);
                    K_2 = aux(I2,:);
                end

                new_class_1 = cell2mat(K_2(class_index));
            end
            if new_class_1 ~= cell2mat(current_test_instance(class_index))
                keep = true;
                indexes(j) = 1;
                break;
            end
            indexes(j) = 1;
        end
        
        if keep == true
            indexes(i) = true;
        end
    end
    TrainMatrix_reduced = TrainMatrix_reduced(indexes,:);
%     total_elapsed_time = toc(initial_timer)
    elapsed_time
end














