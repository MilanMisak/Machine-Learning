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
[net] = feedforwardnet(6);
[net] = configure(net, trainingInputs, trainingTargets);
net.trainParam.epochs = 100;
[net, tr] = train(net, trainingInputs, trainingTargets);

%plotperform(tr);

predictions = testANN(net, validationInputs);





% 6 1-output networks
nets = cell(1, 6);
trs = cell(1, 6);
simulations = cell(1, 6);

for i=1:6
    trainingTargets2 = trainingTargets(i, :);
    [nets{i}] = feedforwardnet([15,20], 'traingdx');
    [nets{i}] = configure(nets{i}, trainingInputs, trainingTargets2);
    %nets{i}.layers{1}.transferFcn = '';
    %nets{i}.layers{2}.transferFcn = '';
    nets{i}.trainParam.mc = 0.95;
    nets{i}.trainParam.epochs = 1000;
    nets{i}.trainParam.lr = 0.015;
    [nets{i}, trs{i}] = train(nets{i}, testInputs, trainingTargets2);
    simulations{i} = sim(nets{i}, trainingInputs);

    fprintf('Best performance: %f\n', trs{i}.best_perf);
end


%plotperform(tr);

%plottrainstate(tr);
