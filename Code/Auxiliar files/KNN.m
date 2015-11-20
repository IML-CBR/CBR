function [Kbase, K_indexes, K_distances] = KNN(CB, c_new, k)
    if isempty(CB) || isempty(c_new) || (k == 0)
        Kbase = [];
        K_indexes = [];
        K_distances = [];
    else
        distances = zeros(1,size(CB,1));
        for i=1:1:size(CB,1)
            distances(i) = caseDistance(c_new, CB(i,:));
        end
        % order the data in ascendent the cases in descending order
        [distances, order] = sort(diag(distances), 'descend'); % sort cols low to high
        K_indexes = order(1:k);
        Kbase = CB(K_indexes,:);
        K_distances = distances(1:k);
    end
end

