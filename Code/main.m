% %% Reset variables
% clear all;
% close all;
% clc;
% %% Move to working directory
% tmp = matlab.desktop.editor.getActive;
% cd(fileparts(tmp.Filename));


datasets = {'adult' 'colic' 'hypothyroid' 'credit-a' 'bal'};
dataset_name = datasets{5};

K = 3;  					% This value corresponds to the K in KNN, and to the CB size in the retreival fase
forget_option = 0; 			%seria potser millor utilitzar strings per comprencio
retention_option = 3; 		%idem


use_real_classes = 1;		% This parameter indicates that the first column of the test matrix
							% stores the real class for every instance

                            
TrainMatrixes = cell(1,10);
TestMatrixes = cell(1,10);
TrainMatrixes_CNN = cell(1,10);
TrainMatrixes_RNN = cell(1,10);
for i=1:10
    tic
    % Load data
    [TrainMatrixes{i}, TestMatrixes{i}, class_names] = readDataset(dataset_name,i-1);
    [ TrainMatrix_CNN, Labels_CNN ] = CNN(TrainMatrixes{i});%,TrainLabels);
    TrainMatrixes_CNN{i} = [TrainMatrix_CNN Labels_CNN];
%     tic
%     auxi = TrainMatrixes{i};
%     auxi = auxi(1:50,:);
	TrainMatrixes_RNN{i}=RNN(TrainMatrixes_CNN{i}, 1, 0);
    toc
end

accuracies = zeros(1,24);
index = 1;
best_accuracy = 0;
% for K = 3:2:7
for K = 5
% 	for forget_option = 0:1
	for forget_option = 1
% 		for retention_option = 1:4
		for retention_option = 3
			total_accuracy = 0;
			total_time = 0;
			total_size = 0;
			for i=1:10
				% Load data
				%[TrainMatrix, TestMatrix, class_names] = readDataset(dataset_name,i);

                TrainMatrix = TrainMatrixes{i};
                TestMatrix = TestMatrixes{i};
				
				% Case base mainatinance
%			    %% CNN
			    TrainMatrix_v1 = TrainMatrixes_CNN{i};
%			    %% RNN
                TrainMatrix_v2 = TrainMatrixes_RNN{i};

				% Instantiation of CM
				num_instances_train = size(TrainMatrix,1);
				
				initial_goodness = zeros(num_instances_train, 1)+0.5;
				current_goodness = zeros(num_instances_train, 1)+0.5;
			   
				CM = struct('CB',{TrainMatrix},'GB0',initial_goodness,'GB',current_goodness);
				
				
				% ACBR algorithm
				tic
				[NewCM, classification, precision] = ...
									acbrAlgorithm(CM ,TestMatrix, use_real_classes, ...
									forget_option, retention_option, K);
% 				[time_retr,time_reuse,time_review,time_retention, precision] = ...
%                         acbrAlgorithm_test(CM ,TestMatrix, use_real_classes, ...
% 									forget_option, retention_option, K);
				elapsed_time = toc;
                                
                % Quality measurements updated
				fprintf('Precision: %f\n',precision);
				
				total_time = total_time + elapsed_time;
				total_accuracy = total_accuracy + precision;
				total_size = total_size + size(CM.CB,1);
			end
			total_time = total_time / 10;
			total_accuracy = total_accuracy / 10;
			total_size = total_size / 10;
            accuracies(index) = total_accuracy;
            index = index + 1;
			if total_accuracy > best_accuracy
				best_accuracy = total_accuracy;
				best_k = K;
				best_forget_option = forget_option;
				best_retention_option = retention_option;
			end
		end
	end
end
