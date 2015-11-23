%% Reset variables
clear all;
clc;
%% Load data
datasets = {'adult' 'colic' 'hypothyroid'};
dataset_name = datasets{3};
1
%%
K = 3;  % This value corresponds to the K in KNN, and to the CB size in the retreival fase
forget_option = 0; %seria potser millor utilitzar strings per comprencio
retention_option = 3; %idem

tic
% for i=0:9
i=0;
2
    [TrainMatrix, TestMatrix, class_names] = readDataset(dataset_name,i);
3

%%    
    % This parameter indicates that the first column of the test matrix
    % stores the real class for every instance
    use_real_classes = 1;

    
    %%
    % TODO: falta dividir el train matrix entre atributs i labels
    [ TrainMatrix_v1, Labels_v1 ] = CNN(TrainMatrix);%,TrainLabels);
    4
    TrainMatrix_v2=RNN(TrainMatrix_v1, 1);
5
    num_instances_train = size(TrainMatrix,1);
    
    % First column is the initial goodness, and the second one is the
    % current goodness
    initial_goodness = zeros(num_instances_train, 1)+0.5;
    current_goodness = zeros(num_instances_train, 1)+0.5;
6    
    CM = struct('CB',{TrainMatrix},'GB0',initial_goodness,'GB',current_goodness);
 7   
    [NewCM, classification, precision] = ...
                        acbrAlgorithm(CM ,TestMatrix, use_real_classes, ...
                        forget_option, retention_option, K);
                    8
    fprintf('Precision: %f\n',precision);
    9
% end
toc
