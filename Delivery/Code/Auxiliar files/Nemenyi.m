function [ NemenyiResult ] = Nemenyi(alpha, Ri, Rj, k, N)
% Nemeyi is a post-hoc test

    if(alpha == 0.05)
        qalpha = 2.569;
    else
        qalpha = 2.291;
    end
    % CD Nemenyi value
    CD = qalpha*(k*(k+1)/6*N).^0.5;
    % Nemenyi test formula for selecting the best alpha value
%     z = (Ri - Rj)/(k*(k+1)/6*N).^0.5;
    NemenyiResult = ((Ri-Rj) > CD);
end