function [ dist ] = distance(c_new, c_old)
% Euclidean distance
%     for i=1:1:size(c_new)
    dist = (sum((c_new-c_old).^2)).^0.5;
end