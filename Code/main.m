%% Reset all
clear all;
close all;
%% Move to working directory
tmp = matlab.desktop.editor.getActive;
cd(fileparts(tmp.Filename));
%% Load Data
data = load('../Data/diabetes');
x = data.x;
y = data.y;

%% QUESTION 1
num_instances = size(x,2);
dimensionality = size(x,1);
means = mean(x,2);

%% QUESTION 2 - JULIÀ
%D1
D1 = struct('x',replaceNaNbyMean(x),'y',y);
%D2
D2 = struct('x',replaceNaNbyMeanOfClass(x,y),'y',y);

%Means
means1 = mean(D1.x,2);
means2 = mean(D2.x,2);

%% QUESTION 3 - XAVI
x_v2 = [ones(1,num_instances);x(7:8,:)];
w = analyticLinearRegression(x_v2,y);

% Plane normal vector
w(2:3)

% Threshold
w(1)

%% QUESTION 4 - JULIÀ
%a)
clear all;
close all;
clc;
data = load('../Data/diabetes');
x = data.x;
y = data.y;
%b)
D2 = struct('x',replaceNaNbyMeanOfClass(x,y),'y',y);
%c)
sizeTrain = ceil(4 * size(data.x,2)/5);
sizeTest = size(data.x,2)-sizeTrain;

data2train = struct('x',D2.x(:,1:sizeTrain),'y',D2.y(1:sizeTrain,:));
data2test = struct('x',D2.x(:,sizeTrain+1:end),'y',D2.y(sizeTrain+1:end,:));

%d)
x_v3 = [ones(1,sizeTrain);data2train.x];
x_v4 = [ones(1,sizeTest);data2test.x];
w = analyticLinearRegression(x_v3,(data2train.y));

%e)
% Train
pred_y_train = double((x_v3'*w)>0);
pred_y_train(find(pred_y_train==0))=-1;

differences_train = find(pred_y_train~=data2train.y);
% Test
pred_y_test = double((x_v4'*w)>0);
pred_y_test(find(pred_y_test==0))=-1;

differences_test = find(pred_y_test~=data2test.y);


%% QUESTION 5 - JULIÀ


%% QUESTION 6 - XAVI