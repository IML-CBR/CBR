function is_correctly_classified = acbrRevisionPhase(choosen_class, current_instance, TrainMatrix, test_data)
  	% TODO!!!
    index_class = size(test_data,2);
    if choosen_class == cell2mat(current_instance(index_class))
        is_correctly_classified = 1;
    else
        is_correctly_classified = 0;
    end
end