function CM = acbrRetentionPhase(CM, current_instance, retrieved_cases, option)
    % TODO!!!
    if option == 1
        CM = acbrAlwaysRetentionPhase(CM, current_instance, retrieved_cases);
    elseif option == 2
        CM = acbrNoRetentionPhase(CM, current_instance, retrieved_cases);
    elseif option == 3
        % TODO: Think another method
        CM = acbrAlwaysRetentionPhase(CM, current_instance, retrieved_cases);
    else
        % TODO: Think another method
        CM = acbrAlwaysRetentionPhase(CM, current_instance, retrieved_cases);
    end
end