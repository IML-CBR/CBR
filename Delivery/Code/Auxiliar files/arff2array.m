function data_parsed = arff2array(data)
    field_names = fieldnames(data);
    num_attributes = length(field_names);
    prov_fieldname = field_names{1};
    prov_attribute = data.(prov_fieldname).values;
    num_instances = length(prov_attribute);
    
    data_parsed = cell(num_instances, num_attributes);
%     if isnumeric(prov_attribute)
%         data_parsed(:,1) = num2cell(prov_attribute');
%     else
%         data_parsed(:,1) = prov_attribute';
%     end
    classes = data.(field_names{end}).values;
    class_names = unique(classes);
    
    for i = 1:num_attributes-1
        prov_fieldname = field_names{i};
        prov_attribute = data.(prov_fieldname).values;
        if isnumeric(prov_attribute)
			notNaN = ~isnan(prov_attribute);
			prov_attribute(~notNaN) = 0;
			howMany = sum(notNaN);
			columnTot = sum(prov_attribute);
			colMean = columnTot / howMany;
			if isnan(colMean)
				data_parsed(:,i)=[];
			else
				prov_attribute(find(notNaN==0))=colMean;
				data_parsed(:,i) = num2cell(prov_attribute');
            end
        else
            are_nan = cellfun(@(x) isempty(x), prov_attribute, 'UniformOutput',false);
            are_nan = cell2mat(are_nan);
            not_nan = prov_attribute(~are_nan);
            nan_values = prov_attribute(are_nan);
            not_nan_classes = classes(~are_nan);
            nan_classes = classes(are_nan);
            
            for j = 1:size(nan_values,2)
                nan_class = nan_classes(j);
                aux = not_nan(not_nan_classes==nan_class);
                [unique_strings, ~, string_map]=unique(aux);
                nan_values(j) = unique_strings(mode(string_map));
            end
            
            data_parsed(are_nan,i) = nan_values;
            data_parsed(~are_nan,i) = not_nan';
        end
    end
    if isnumeric(classes)
        data_parsed(:,end) = num2cell(classes');
    else
        data_parsed(:,end) = classes';
    end

end