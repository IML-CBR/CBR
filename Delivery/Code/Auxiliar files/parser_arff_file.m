function [ResultMatrix, class_names] = parser_arff_file(filename)
    ResultMatrix = arffparser('read',filename);

    
    % We normalize the values
    ResultMatrix = arff2array(ResultMatrix);
    
    % We store the equivalence between numeric and nominal classes
    if isnumeric(ResultMatrix{1,size(ResultMatrix,2)})
        class_names = unique(cell2mat(ResultMatrix(:,size(ResultMatrix,2))));
    else
        class_names = unique(ResultMatrix(:,size(ResultMatrix,2)));
        ResultMatrix(:,size(ResultMatrix,2))=...
            num2cell(replaceByNum(ResultMatrix(:,size(ResultMatrix,2))));
    end
    
    % We turn the class variable into a numeric one
    
end