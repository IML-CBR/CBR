function [ dist ] = caseDistance(c_new, c_old)
% Euclidean distance
    dist = 0;
    for i=1:1:size(c_new)
        dist = dist + distance(c_new(i), c_old(i));
    end
    dist = dist^0.5;
end