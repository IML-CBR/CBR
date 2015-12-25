function [ U_CaseBase, U_labels ] = CNN(TrainMatrix)
    % Call CNN function
    CB=TrainMatrix(:,1:size(TrainMatrix,2)-1);
    labels=TrainMatrix(:,end);
    U_CaseBase = [];
    U_labels = [];
    Repeat = 1;
    while(Repeat)
        Repeat = 0;
        order = (1:size(CB,1));
        rand_order = order(randperm(length(order)));
        rand_order = 1:size(CB,1);
        storedCases = [];
        for i=1:length(rand_order)
            x_case = CB(rand_order(i),:);
            y_label = labels(rand_order(i));
            [z_case, z_index] = KNN(U_CaseBase,x_case,1);
            z_label = cell2mat(U_labels(z_index));
            if isempty(z_case)
                U_CaseBase = [U_CaseBase; x_case];
                U_labels = [U_labels; y_label];
                Repeat = 1;
                storedCases = [storedCases,rand_order(i)];
            elseif isnumeric(cell2mat(y_label))
                if cell2mat(y_label) ~= z_label
                    U_CaseBase = [U_CaseBase; x_case];
                    U_labels = [U_labels; y_label];
                    Repeat = 1;
                    storedCases = [storedCases,rand_order(i)];
                end
            elseif ~strcmp(y_label, z_label)
                U_CaseBase = [U_CaseBase; x_case];
                U_labels = [U_labels; y_label];
                Repeat = 1;
                storedCases = [storedCases,rand_order(i)];
            end
        end
        CB(storedCases,:) = [];
    end
end