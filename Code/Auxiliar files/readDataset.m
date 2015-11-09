function [TrainMatrix, TestMatrix, class_names] = readDataset(dataset_name, i)
    tmp = matlab.desktop.editor.getActive;
    cd(fileparts(tmp.Filename));

    
    filename_train = ...
        ['..\Datasets\' dataset_name '\' dataset_name '.fold.00000' num2str(i) '.train.arff'];
    
    TrainMatrix = parser_arff_file(filename_train);
    
    
    filename_test = ...
        ['..\Datasets\' dataset_name '\' dataset_name '.fold.00000' num2str(i) '.test.arff'];
    
    [TestMatrix, class_names] = parser_arff_file(filename_test);

    
end