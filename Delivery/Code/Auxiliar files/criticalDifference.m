function [ cd ] = criticalDifference( q_alfa, k, N )
% q_alfa->critical values q_alfa are based on the Studentized range
% statistics divided by 2^0.5; N->num of datasets; k->num of algorithms; 
% Critical Difference for rejecting the null-hypothesis of Friedman test
    cd = q_alfa*(k(k+1)/6*N).^0.5;
end

