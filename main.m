data = load('diabetes');
x = data.x;
y = data.y;

%% QUESTION 1
num_instances = size(x,2);
dimensionality = size(x,1);
means = mean(x,2);

%% QUESTION 2 - JULIÀ


%% QUESTION 3 - XAVI
x_v2 = [ones(1,num_instances);x(7:8,:)];
w = analyticLinearRegression(x_v2,y);

% Plane normal vector
w(2:3)

% Threshold
w(1)

%% QUESTION 4 - JULIÀ


%% QUESTION 5 - JULIÀ


%% QUESTION 6 - XAVI