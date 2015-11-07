function out = arff2matrix(ds, mode)
    % mode 0: all data is transformed
    % mode 1: just numeric data is transformed
    fnames = fieldnames(ds);
    out_num = [];
    out_nom = [];
    for field_index = 1:numel(fnames)
        b = ischar(ds.(fnames{field_index}).kind) && strcmp(ds.(fnames{field_index}).kind, 'numeric');
        if mode == 0 && ~b
            if isempty(out_nom)
               out_nom = [(ds.(fnames{field_index}).values)']; 
            else
                out_nom = [out_nom (ds.(fnames{field_index}).values)'];
            end
        elseif b
            if isempty(out_num)
               out_num = (ds.(fnames{field_index}).values)'; 
            else
                out_num = [out_num (ds.(fnames{field_index}).values)'];
            end
        end
    end
    num_attributes = length(out_num);
    num_instances = length(out_num');
    if mode == 1
        out = out_num;
    else
        out = {};
        for i = 1:num_instances
            out{i} = num2cell(out_num(i,:));
        end
        out = out';
    end
    
    notNaN = ~isnan(out);
    out(~notNaN) = 0;
    howMany = sum(notNaN);
    columnTot = sum(out);
    colMean = columnTot ./ howMany;

    for i = 1:length(colMean)
        if isnan(colMean(i))
            out(:,i)=[];
        else
            out(find(notNaN(:,i)==0),i)=colMean(i);
        end
    end
end