function [ Kbase ] = KNN(c_new,CB,k)
    distances = zeros(1,size(CB,1));
    for i=1:1:size(CB,1)
        distances(i) = caseDistance(c_new, CB(i,:));
    end
    % order the data in ascendent the cases in descending order
    [distances, order] = sort(diag(distances), 'descend');       %# sort cols low to high
    CB = CB(:,order);
    Kbase = CB(1:k,:);
end

