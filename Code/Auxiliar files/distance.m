function [ dist ] = distance(att_new, att_old)
    % If wether one of both is NaN, or they are from diferent type, the
    % distance will be maximum -> dist = 1
    if isnan(att_new) || isnan(att_old) || ~xor(isnumeric(att_new),isnumeric(att_old))
        dist = 1;
    elseif isnumeric(att_new)
        % Euclidean distance part
        dist = (att_new-att_old).^2;
    else
        % If equal -> dist = 0, dist = 1 otherwise
        dist = ~strcmp(att_new, att_old);
    end
end