function is_correctly_classified = acbrRevisionPhase(choosen_class, current_instance, CM, TestMatrix)
  	% TODO!!!
    index_class = size(TestMatrix,2);
    if choosen_class == cell2mat(current_instance(index_class))
        is_correctly_classified = 1;
    else
        is_correctly_classified = 0;
    end
end