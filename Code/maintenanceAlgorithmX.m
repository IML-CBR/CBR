function [ ReducedCaseBase, ReducedLabels ] = maintenanceAlgorithmX(TrainMatrix)
    % Call CNN function
    TrainCases=TrainMatrix(:,1:size(TrainMatrix,2)-1);
    TrainLabels=TrainMatrix(:,size(TrainMatrix,2)-1:end);
    [ ReducedCaseBase, ReducedLabels ] = CNN(TrainCases, TrainLabels);
end