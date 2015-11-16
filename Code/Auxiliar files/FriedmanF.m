function [ Ff ] = FriedmanF( N, k, RankMatrix )
% N->num of datasets; k->num of algorithms; RankMatrix->Matrix[N,k] with
% the rank on each cell
    R = mean(RankMatrix,1);
  % Classic Friedman function
    Xf_2 = 12*N/k(k+1)*(R*R' - k((k+1)^2)/4);
  % Friedman improved function, wich is distributed as a F-distribution
    Ff = (N-1)*Xf_2/(N(k-1)-Xf_2);
end

