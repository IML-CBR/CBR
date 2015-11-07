function [TrainMatrix, TestMatrix] = readDataset(dataset_name, percentage_train)
    tmp = matlab.desktop.editor.getActive;
    cd(fileparts(tmp.Filename));

    
    filename = ['..\Datasets\' dataset_name '.arff'];
    data = arffparser('read',filename);
    
%     fprintf('Dataset read\n');
%     
%     field_names = fieldnames(data);
%     
%     % All class attributes are always the last attribute for the choosen
%     % datsets
%     class_name = field_names{length(field_names)}; %input('')};
%     
%     class=data.(class_name).values;
%     class=replaceByNum(class);
%     
%     data = rmfield(data,class_name);
%     at_list = fieldnames(data_orig);
    data = arff2array(data);
    
    [indexes_training, indexes_test] = getIndexesTrainAndTest(data, percentage_train);
    TrainMatrix = data(indexes_training,:);
    TrainMatrix(:,size(TrainMatrix,2))=...
            num2cell(replaceByNum(TrainMatrix(:,size(TrainMatrix,2))));
    TestMatrix = data(indexes_test,:);
    TestMatrix(:,size(TestMatrix,2))=...
            num2cell(replaceByNum(TestMatrix(:,size(TestMatrix,2))));
end