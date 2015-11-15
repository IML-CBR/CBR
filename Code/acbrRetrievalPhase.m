function [retrievedCases, retreivedIndexes] = acbrRetrievalPhase(TrainMatrix, c_new, k_size)
    % Call to KNN function
    [retrievedCases, retreivedIndexes] = KNN(TrainMatrix(:,1:size(TrainMatrix,2)-1), c_new, k_size);
end