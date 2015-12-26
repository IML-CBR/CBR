function numeric_classes = replaceByNum(class)
    values = unique(class);
    if isnumeric(class)
        numeric_classes = class;
    else
        num_values = length(values);
        num_instances = length(class);
        numeric_classes = zeros(num_instances, 1);
        for i=1:num_values
            numeric_classes(strcmp(class, values(i)))=i;
        end
    end
end