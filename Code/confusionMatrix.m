function [ confMat ] = confusionMatrix( predLabels, realLabels )
    PredPos = find(predLabels==1);
    PredNeg = find(predLabels==-1);
    RealPos = find(realLabels==1);
    RealNeg = find(realLabels==-1);
    TruePos = intersect(PredPos,RealPos);
    TrueNeg = intersect(PredNeg,RealNeg);
    FalsPos = intersect(PredPos,RealNeg);
    FalsNeg = intersect(PredNeg,RealPos);
    confMat = [size(TruePos,1),size(FalsPos,1);size(FalsNeg,1),size(TrueNeg,1)];
end

