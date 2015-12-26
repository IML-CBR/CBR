function CM = detrimentalRetention(CM, current_instance, retrieved_indexes, given_sol)
    true_class = cell2mat(current_instance(size(current_instance,2)));
    if true_class ~= given_sol
        K = CM.CB(retrieved_indexes,:);
        MC = mode(cell2mat(K(:,size(K,2))));
        if true_class ~= MC
            CM.CB = [CM.CB; current_instance];
            CM.GB = [CM.GB; 0.5];
            CM.GB0 = [CM.GB0; 0.5];
        end
    end
end