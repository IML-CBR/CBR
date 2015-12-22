function new_data = dataset_resizing(data, percentage)
    num_instances_old = size(data,1);
    num_instances = floor(percentage * num_instances_old);

    new_data = cell(num_instances, size(data,2));
    for i=1:num_instances
        index = floor(rand(1) * (num_instances_old-1) + 1);
        new_data(i,:)=data(index,:);
    end
end