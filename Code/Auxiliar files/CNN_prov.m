function [ U_CaseBase, U_labels ] = CNN(CB, labels)
    U_CaseBase = [];
    U_labels = [];
    order = (1:length(CB));
    Repeat = 1;
    while(Repeat)
        Repeat = 0;
        rand_order = order(randperm(length(order)));
        for i=1:length(rand_order)
            x_case = CB(rand_order(i),:);
            y_label = labels(rand_order(i));
            [z_case, z_index] = KNN(U_CaseBase,CB(rand_order(i)),1);
            z_label = U_labels(z_index);
            if isempty(z_case)
                U_CaseBase = [U_CaseBase; x_case];
                U_labels = [U_labels; y_label];
                Repeat = 1;
            elseif isnumeric(y_label)
                if y_label ~= z_label
                    U_CaseBase = [U_CaseBase; x_case];
                    U_labels = [U_labels; y_label];
                    Repeat = 1;
                end
            elseif ~strcmp(y_label, z_label)
                U_CaseBase = [U_CaseBase; x_case];
                U_labels = [U_labels; y_label];
                Repeat = 1;
            end
        end
    end
end

