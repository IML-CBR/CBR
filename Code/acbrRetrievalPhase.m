function [retrievedCases, retreivedIndexes] = acbrRetrievalPhase(TrainMatrix, c_new, k_size)
    % Call to KNN function
    [retrievedCases, retreivedIndexes] = KNN(TrainMatrix, c_new, k_size);
end