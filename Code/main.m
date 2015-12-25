%% Reset variables
clear all;
close all;
clc;

%% Move to working directory
tmp = matlab.desktop.editor.getActive;
cd(fileparts(tmp.Filename));

%% Data loading
datasets = {'credit-a' 'bal'};
dataset_name = datasets{2};


use_real_classes = 1;		% This parameter indicates that the first column of the test matrix
							% stores the real class for every instance


TrainMatrixes = cell(1,10);
TestMatrixes = cell(1,10);
TrainMatrixes_CNN = cell(1,10);
TrainMatrixes_RNN = cell(1,10);

tic
generate_data=false;
if generate_data
    for i=1:10
        % Load data
        [TrainMatrixes{i}, TestMatrixes{i}, class_names] = readDataset(dataset_name,i-1);
%         TrainMatrixes{i} = dataset_resizing(TrainMatrixes{i},3);
        [ TrainMatrix_CNN, Labels_CNN ] = CNN(TrainMatrixes{i});%,TrainLabels);
        TrainMatrixes_CNN{i} = [TrainMatrix_CNN Labels_CNN];
        
        TrainMatrixes_RNN{i}=RNN(TrainMatrixes_CNN{i}, 1, 0);
    end
    save(['../Data/TrainMatrixes_' dataset_name],'TrainMatrixes');
    save(['../Data/TestMatrixes_' dataset_name],'TestMatrixes');
    save(['../Data/TrainMatrixes_CNN_' dataset_name],'TrainMatrixes_CNN');
    save(['../Data/TrainMatrixes_RNN_' dataset_name],'TrainMatrixes_RNN');
else
    load(['../Data/TrainMatrixes_' dataset_name]);
    load(['../Data/TestMatrixes_' dataset_name]);
    load(['../Data/TrainMatrixes_CNN_' dataset_name]);
    load(['../Data/TrainMatrixes_RNN_' dataset_name]);
end
toc

 
%% ACBR parameters decision
generate_best_model = false;
if generate_best_model
    accuracies = zeros(1,24);
    index = 1;
    best_accuracy = 0;
    tic
    for K = 3:2:7
        for forget_option = 0:1
            for retention_option = 1:4
                total_accuracy = 0;
                for i=1:10
                    % Load data
                    TrainMatrix = TrainMatrixes{i};
                    TestMatrix = TestMatrixes{i};

                    % Instantiation of CM
                    num_instances_train = size(TrainMatrix,1);

                    initial_goodness = zeros(num_instances_train, 1)+0.5;
                    current_goodness = zeros(num_instances_train, 1)+0.5;

                    CM = struct('CB',{TrainMatrix},'GB0',initial_goodness,'GB',current_goodness);

                    % ACBR algorithm
                    [NewCM, classification, precision] = ...
                                        acbrAlgorithm(CM ,TestMatrix, use_real_classes, ...
                                        forget_option, retention_option, K);

                    % Quality measurements updated
                    total_accuracy = total_accuracy + precision;
                end
                total_accuracy = total_accuracy / 10;
                accuracies(index) = total_accuracy;
                index = index + 1;
                fprintf('Precision: %f\n',total_accuracy);

                if total_accuracy > best_accuracy
                    best_accuracy = total_accuracy;
                    best_K = K;
                    best_forget_option = forget_option;
                    best_retention_option = retention_option;
                end
            end
        end
    end
    best_model.k = best_K;
    best_model.forget_option = forget_option;
    best_model.retention_option = retention_option;
    save(['../Data/best_model_' dataset_name],'-struct','best_model');
else
    best_model = load(['../Data/best_model_' dataset_name]);
    best_K = best_model.k;
    best_forget_option = best_model.forget_option;
    best_retention_option = best_model.retention_option;
end
toc

%% Global results instantiation
ACBR_results=zeros(3,3);
CBR_results=zeros(3,3);

%% Raw data
total_accuracy_ACBR = 0;
total_accuracy_CBR = 0;
total_time_ACBR = 0;
total_time_CBR = 0;
total_size_ACBR = 0;
total_size_CBR = 0;

raw_data_tic = tic;
for i=1:10
    % Load data
    TrainMatrix = TrainMatrixes{i};
    TestMatrix = TestMatrixes{i};

    % Instantiation of CM
    num_instances_train = size(TrainMatrix,1);

    initial_goodness = zeros(num_instances_train, 1)+0.5;
    current_goodness = zeros(num_instances_train, 1)+0.5;

    CM = struct('CB',{TrainMatrix},'GB0',initial_goodness,'GB',current_goodness);


    % ACBR algorithm
    tic
	[NewCM_1, classification, precision_ACBR] = ...
			acbrAlgorithm(CM ,TestMatrix, use_real_classes, ...
			best_forget_option, best_retention_option, best_K);
    elapsed_time=toc;
	total_time_ACBR = total_time_ACBR + elapsed_time;
    total_accuracy_ACBR = total_accuracy_ACBR + precision_ACBR;
    total_size_ACBR = total_size_ACBR + size(NewCM_1.CB,1);

    % CBR algorithm
    tic
    [NewCM_2, classification, precision_CBR] = ...
			acbrAlgorithm(CM ,TestMatrix, use_real_classes, ...
            0, 1, best_K);
    elapsed_time=toc;
    total_time_CBR = total_time_CBR + elapsed_time;
    total_accuracy_CBR = total_accuracy_CBR + precision_CBR;
    total_size_CBR = total_size_CBR + size(NewCM_2.CB,1);
end
total_time_ACBR = total_time_ACBR / 10;
total_accuracy_ACBR = total_accuracy_ACBR / 10;
total_size_ACBR = total_size_ACBR / 10;
ACBR_results(1,:) = [total_accuracy_ACBR total_time_ACBR total_size_ACBR];

total_time_CBR = total_time_CBR / 10;
total_accuracy_CBR = total_accuracy_CBR / 10;
total_size_CBR = total_size_CBR / 10;
CBR_results(1,:) = [total_accuracy_CBR total_time_CBR total_size_CBR];

toc(raw_data_tic)


%% CNN
total_accuracy_ACBR = 0;
total_accuracy_CBR = 0;
total_time_ACBR = 0;
total_time_CBR = 0;
total_size_ACBR = 0;
total_size_CBR = 0;

CNN_tic = tic;
for i=1:10
    % Load data
    TrainMatrix = TrainMatrixes_CNN{i};
    TestMatrix = TestMatrixes{i};

	% Instantiation of CM
    num_instances_train = size(TrainMatrix,1);

    initial_goodness = zeros(num_instances_train, 1)+0.5;
    current_goodness = zeros(num_instances_train, 1)+0.5;

    CM = struct('CB',{TrainMatrix},'GB0',initial_goodness,'GB',current_goodness);

    % ACBR algorithm
    tic
	[NewCM, classification, precision_ACBR] = ...
			acbrAlgorithm(CM ,TestMatrix, use_real_classes, ...
			best_forget_option, best_retention_option, best_K);
    elapsed_time=toc;
    total_time_ACBR = total_time_ACBR + elapsed_time;
    total_accuracy_ACBR = total_accuracy_ACBR + precision_ACBR;
    total_size_ACBR = total_size_ACBR + size(NewCM.CB,1);
    
    % CBR algorithm
    tic
    [NewCM_2, classification, precision_CBR] = ...
			acbrAlgorithm(CM ,TestMatrix, use_real_classes, ...
			0, 1, best_K);
    elapsed_time = toc;
    total_time_CBR = total_time_CBR + elapsed_time;
    total_accuracy_CBR = total_accuracy_CBR + precision_CBR;
    total_size_CBR = total_size_CBR + size(NewCM_2.CB,1);
end
total_time_ACBR = total_time_ACBR / 10;
total_accuracy_ACBR = total_accuracy_ACBR / 10;
total_size_ACBR = total_size_ACBR / 10;
ACBR_results(2,:) = [total_accuracy_ACBR total_time_ACBR total_size_ACBR];

total_time_CBR = total_time_CBR / 10;
total_accuracy_CBR = total_accuracy_CBR / 10;
total_size_CBR = total_size_CBR / 10;
CBR_results(2,:) = [total_accuracy_CBR total_time_CBR total_size_CBR];

toc(CNN_tic)

%% RNN
total_accuracy_ACBR = 0;
total_accuracy_CBR = 0;
for i=1:10
    % Load data
    TrainMatrix = TrainMatrixes_RNN{i};
    TestMatrix = TestMatrixes{i};

    % Instantiation of CM
    num_instances_train = size(TrainMatrix,1);

    initial_goodness = zeros(num_instances_train, 1)+0.5;
    current_goodness = zeros(num_instances_train, 1)+0.5;

    CM = struct('CB',{TrainMatrix},'GB0',initial_goodness,'GB',current_goodness);

    % ACBR algorithm
    tic
	[NewCM, classification, precision_ACBR] = ...
            acbrAlgorithm(CM ,TestMatrix, use_real_classes, ...
            best_forget_option, best_retention_option, best_K);
    elapsed_time = toc;
    total_time_ACBR = total_time_ACBR + elapsed_time;
    total_accuracy_ACBR = total_accuracy_ACBR + precision_ACBR;
    total_size_ACBR = total_size_ACBR + size(NewCM.CB,1);
    
    % ACBR algorithm
    tic
    [NewCM_2, classification, precision_CBR] = ...
			acbrAlgorithm(CM ,TestMatrix, use_real_classes, ...
			0, 1, best_K);
    elapsed_time=toc;
    total_time_CBR = total_time_CBR + elapsed_time;
    total_accuracy_CBR = total_accuracy_CBR + precision_CBR;
    total_size_CBR = total_size_CBR + size(NewCM_2.CB,1);
end
total_time_ACBR = total_time_ACBR / 10;
total_accuracy_ACBR = total_accuracy_ACBR / 10;
total_size_ACBR = total_size_ACBR / 10;
ACBR_results(3,:) = [total_accuracy_ACBR total_time_ACBR total_size_ACBR];

total_time_CBR = total_time_CBR / 10;
total_accuracy_CBR = total_accuracy_CBR / 10;
total_size_CBR = total_size_CBR / 10;
CBR_results(3,:) = [total_accuracy_CBR total_time_CBR total_size_CBR];

%% Results summarizing
best_forget_option
best_retention_option
best_K

ACBR_results
CBR_results
save(['../Data/ACBR_results_' dataset_name],'ACBR_results');
save(['../Data/CBR_results_' dataset_name],'CBR_results');

load(['../Data/ACBR_results_' dataset_name]);
load(['../Data/CBR_results_' dataset_name]);