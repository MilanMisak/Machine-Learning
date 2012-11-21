cleandata = load('cleandata_students.mat');

% TODO - just use x2 and y2 everywhere instead of x and y
[x2, y2] = ANNdata(cleandata.x, cleandata.y);
x = x2;
y = y2;
n = size(x, 2);

% Divide data into training and validation sets with a 67:23 split
splitIndex = floor(0.67*n);
trainingInputs  = x(:, 1:splitIndex);
trainingTargets = y(:, 1:splitIndex);
validationInputs  = x(:, (splitIndex + 1):n);
validationTargets = y(:, (splitIndex + 1):n);

% 6-output network
% TODO - change to use trainNet
%[net] = feedforwardnet(6);
%[net] = configure(net, trainingInputs, trainingTargets);
%net.trainParam.epochs = 100;
%net.trainParam.showWindow = 0;
%[net, tr] = train(net, trainingInputs, trainingTargets);

net = trainNet(trainingInputs, trainingTargets, [13 7]);

save('network.mat', 'net');

%plotperform(tr);

predictions = testANN(net, validationInputs);


CrossValidateOneOutput(x2, y2);

CrossValidateSixOutput(x2, y2);