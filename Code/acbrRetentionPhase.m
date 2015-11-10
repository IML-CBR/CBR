function CM = acbrRetentionPhase(CM, current_instance, retrieved_cases, option)
    % TODO!!!
    if option == 1
        CM = acbrAlwaysRetentionPhase(CM, current_instance, retrieved_cases);
    elseif option == 2
        CM = acbrNoRetentionPhase(CM, current_instance, retrieved_cases);
    elseif option == 3
        % TODO: Think another method
        CM = acbrRetentionX(CM, current_instance, retrieved_cases);
    elseif option == 4
        % TODO: Think another method
        CM = acbrRetentionY(CM, current_instance, retrieved_cases);
	else
		fprintf('ERROR: Option must be 1, 2, 3 or 4\n');
    end
end