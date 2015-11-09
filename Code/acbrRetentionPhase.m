function TrainMatrix = acbrRetentionPhase(TrainMatrix, current_instance, option)
    % TODO!!!
    if option == 1
        TrainMatrix = acbrAlwaysRetentionPhase(TrainMatrix, current_instance);
    elseif option == 2
        TrainMatrix = acbrNoRetentionPhase(TrainMatrix, current_instance);
    elseif option == 3
        % TODO: Think another method
        TrainMatrix = acbrAlwaysRetentionPhase(TrainMatrix, current_instance);
    else
		% Last else could be error case, to ensure good input values
        % TODO: Think another method
        TrainMatrix = acbrAlwaysRetentionPhase(TrainMatrix, current_instance);
    end
end