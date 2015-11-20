function [ NemenyiResult ] = Nemenyi(alpha, Ri, Rj, k, N)
% Nemeyi is a post-hoc test
%    Nemenyi test (alpha == 0.05):
% Here we have precalculated q_alfa mentioned in Critical Distance
%     qalpha = [0.000 1.960 2.344 2.569 2.728 2.850 2.948 3.031 3.102 3.164 ...
%     3.219 3.268 3.313 3.354 3.391 3.426 3.458 3.489 3.517 3.544 ...
%     3.569 3.593 3.616 3.637 3.658 3.678 3.696 3.714 3.732 3.749 ...
%     3.765 3.780 3.795 3.810 3.824 3.837 3.850 3.863 3.876 3.888 ...
%     3.899 3.911 3.922 3.933 3.943 3.954 3.964 3.973 3.983 3.992 ...
%     4.001 4.009 4.017 4.025 4.032 4.040 4.046];

    % Nemeyi test formula
    z = (Ri - Rj)/(k(k+1)/6*N).^0.5;
    

% Then replace cv inside the code with:
% 
% cd = qalpha(k)*sqrt(k*(k+1)/(6*b));
% 
% So here we get cv using Nemenyi Test.
% 
% Please Advice.

end