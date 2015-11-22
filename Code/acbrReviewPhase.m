function CM = acbrReviewPhase(retrieved_indexes, CM, current_instance, ...
                                    choosen_class, forget_option)
    alpha = 0.2;    % TODO: Decidir
    retrieved_instances = CM.CB(retrieved_indexes,:);
    class_index = size(retrieved_instances,2);
    for i=1:size(retrieved_instances,1)
        instance = retrieved_instances(i,:);
        index = retrieved_indexes(i);
        if cell2mat(instance(class_index)) == choosen_class
            r = 1;
        else
            r = 0;
        end
        CM.GB(index) = CM.GB(index) + alpha*(r-CM.GB(index));
        if forget_option == 1
            if CM.GB(index) < CM.GB0(index)
                aux_mat = true(1, size(CM.GB, 1));
                aux_mat(index) = false;
                CM.CB = CM.CB(aux_mat, :);
                clear('CM.CB');   % distract the JIT
                CM.GB = CM.GB(aux_mat, :);
                clear('CM.GB');   % distract the JIT
                CM.GB0 = CM.GB0(aux_mat, :);
                clear('CM.GB0');   % distract the JIT
            end
        end
    end
end