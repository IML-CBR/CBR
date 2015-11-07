function TrainMatrix = acbrAlwaysRetentionPhase(TrainMatrix, current_instance)
    num_instances = size(TrainMatrix,1);
    TrainMatrix(num_instances+1,:) = current_instance;
end