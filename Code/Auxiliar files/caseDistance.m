function [ dist ] = caseDistance(c_new, c_old)
%     tic
%     empties_v1 = cellfun(@(x) isempty(x),c_new);
%     empties_v2 = cellfun(@(x) isempty(x),c_old);
%     empties = empties_v1 & empties_v2;
%     auxi_1 = sum(empties);
%     empties = ~empties;
%     new_c_new = c_new(empties);
%     new_c_old = c_old(empties);
% 
%     numerics = cellfun(@(x) isnumeric(x), new_c_new);
%     nominal = ~numerics;
%     new_numeric_atts = cell2mat(new_c_new(numerics));
%     old_numeric_atts = cell2mat(new_c_old(numerics));
%     
%     auxi_2 = new_numeric_atts - old_numeric_atts;
%     auxi_2 = sum(auxi_2.^2);
% 
%     new_nominal_atts = new_c_new(nominal);
%     old_nominal_atts = new_c_old(nominal);
%     auxi_3 = sum(~strcmp(new_nominal_atts,old_nominal_atts));
%     
%     dist = sqrt(auxi_1 + auxi_2 + auxi_3);
%     time_1 = toc
    
    % Euclidean distance
    dist = 0;
    for i=1:size(c_new,2)
%         dist = dist + distance(c_new(i), c_old(i));
        att_new = c_new(i);
        att_old = c_old(i);

%         if isempty(att_new{1}) || isempty(att_old{1}) || xor(isnumeric(att_new{1}),isnumeric(att_old{1}))
        if isempty(att_new{1}) || isempty(att_old{1})
            dist_cur = 1;
        elseif isnumeric(att_new{1})
            if isnan(cell2mat(att_new)) || isnan(cell2mat(att_old))
                dist_cur = 1;
            else
                % Euclidean distance part
                dist_cur = (cell2mat(att_new)-cell2mat(att_old)).^2;
            end
        else
            % If equal -> dist = 0, dist = 1 otherwise
            dist_cur = ~strcmp(att_new, att_old);
        end
        dist = dist + dist_cur;
    end
    dist = dist^0.5;
end