function data_parsed = arff2array(data)
    field_names = fieldnames(data);
    num_attributes = length(field_names);
    prov_fieldname = field_names{1};
    prov_attribute = data.(prov_fieldname).values;
    num_instances = length(prov_attribute);
    
    data_parsed = cell(num_instances, num_attributes);
    if isnumeric(prov_attribute)
        data_parsed(:,1) = num2cell(prov_attribute');
    else
        data_parsed(:,1) = prov_attribute';
    end
    
    for i = 2:num_attributes
        prov_fieldname = field_names{i};
        prov_attribute = data.(prov_fieldname).values;
        if isnumeric(prov_attribute)
            data_parsed(:,i) = num2cell(prov_attribute');
        else
            data_parsed(:,i) = prov_attribute';
        end
    end
end