function [ dist ] = distance(att_new, att_old)
    % If whether one of both is NaN, or they are from diferent type, the
    % distance will be maximum -> dist = 1
    if isempty(att_new) || isempty(att_old) || xor(isnumeric(att_new{1}),isnumeric(att_old{1}))
        dist = 1;
    elseif isnumeric(att_new{1})
        if isnan(cell2mat(att_new)) || isnan(cell2mat(att_old))
            dist = 1;
        else
            % Euclidean distance part
            dist = sqrt((cell2mat(att_new)-cell2mat(att_old)).^2);
        end
    else
        % If equal -> dist = 0, dist = 1 otherwise
        dist = ~strcmp(att_new, att_old);
    end
end