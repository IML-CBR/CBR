function choosen_class = acbrReusePhase(current_instance, retrieved_cases)
    labels = cell2mat(retrieved_cases(:,size(retrieved_cases,2)));

    option = 1;
    if option == 1
        % Most frequent class
        choosen_class = mode(labels);
    elseif option == 2
        
    end
%     choosen_class = cell2mat(retrieved_cases(1,size(retrieved_cases,2)));
end