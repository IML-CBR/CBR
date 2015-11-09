function [ResultMatrix, class_names] = parser_arff_file(filename)
    ResultMatrix = arffparser('read',filename);

    
    % We normalize the values
    ResultMatrix = arff2array(ResultMatrix);
    
    % We store the equivalence between numeric and nominal classes
    class_names = unique(ResultMatrix(:,size(ResultMatrix,2)));
    
    % We turn the class variable into a numeric one
    ResultMatrix(:,size(ResultMatrix,2))=...
            num2cell(replaceByNum(ResultMatrix(:,size(ResultMatrix,2))));
end