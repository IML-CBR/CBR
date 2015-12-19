time_distances_total = 0;
time_total_plus = 0;
time_sort_total = 0;
for i = 1:5
    [time_distances,total_time,time_sort,mean_dist] =...
            KNN_delete(TrainMatrix, current_instance, 1);
    time_distances_total = time_distances_total + time_distances;
    time_total_plus = time_total_plus + total_time;
    time_sort_total = time_sort_total + time_sort;
end
mean_dist
time_total_plus

size_1 = size(TrainMatrix, 1);
distances = zeros(size_1,size_1);
for i = 1:size_1
    c_new = TrainMatrix(i,:);
    for j = 1:size_1-i
        c_old = TrainMatrix(j,:);
        tic
    	distances(i,j) = caseDistance(c_new, c_old);
        aux=toc
    end
end