function CM = acbrAlwaysRetentionPhase(CM, current_instance, retrieved_cases)
    num_instances = size(CM.CB,1);
    CM.CB(num_instances+1,:) = current_instance;
    CM.GB0 = [CM.GB0; 0.5];
    CM.GB = [CM.GB; 0.5];
end