function [ RankAverage ] = getRankAverage( ResultsMatrix )
% ResultsMatrix contains the accuracy obtained by each algorithm used in the
% classification task, having the datasets as rows and the algorithms as columns
	RankAverage = mean(RsultsMatrix);
end

