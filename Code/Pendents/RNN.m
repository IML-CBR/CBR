function TrainMatrix_reduced = RNN(TrainMatrix, already_reduced)
    if already_reduced ~= 1
        TrainMatrix = CNN(TrainMatrix);
    end
    TrainMatrix_reduced = TrainMatrix;
end