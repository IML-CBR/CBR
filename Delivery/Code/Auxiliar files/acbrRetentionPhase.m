function CM = acbrRetentionPhase(CM, current_instance, retrieved_indexes, option, given_sol)
    % TODO!!!
    if option == 1
        CM = acbrNoRetentionPhase(CM, current_instance, retrieved_indexes);
    elseif option == 2
        CM = acbrAlwaysRetentionPhase(CM, current_instance, retrieved_indexes);
    elseif option == 3
        % TODO: Think another method
        CM = minimalGoodnessRetention(current_instance,retrieved_indexes,CM);
    elseif option == 4
        % TODO: Think another method
        CM = detrimentalRetention(CM, current_instance, retrieved_indexes, given_sol);
	else
		fprintf('ERROR: Option must be 1, 2, 3 or 4\n');
    end
end