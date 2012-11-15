cleandata = load('cleandata_students.mat');

[x2, y2] = ANNdata(cleandata.x, cleandata.y);
x = x2;
y = y2;
n = size(x, 2);

%f = floor(0.67*n)
%c = ceil(0.67*n)

testInputs  = x(:, 1:floor(0.67*n));
testTargets = y(:, 1:floor(0.67*n));
validationInputs  = x(:, (floor(0.67*n) + 1):n);
validationTargets = y(:, (floor(0.67*n) + 1):n);

% 6-output network
[net] = feedforwardnet(6);
[net] = configure(net, x, y);
net.trainParam.epochs = 100;
[net, tr] = train(net, testInputs, testTargets);

predictions = testANN(net, validationInputs);



% 6 1-output networks
nets = cell(1, 6);
trs = cell(1, 6);
simulations = cell(1, 6);

for i=1:6
    trainingTargets = testTargets(i, :);
    [nets{i}] = feedforwardnet([15,20], 'traingdx');
    [nets{i}] = configure(nets{i}, testInputs, trainingTargets);
    %nets{i}.layers{1}.transferFcn = '';
    %nets{i}.layers{2}.transferFcn = '';
    nets{i}.trainParam.mc = 0.95;
    nets{i}.trainParam.epochs = 1000;
    nets{i}.trainParam.lr = 0.015;
    [nets{i}, trs{i}] = train(nets{i}, testInputs, trainingTargets);
    simulations{i} = sim(nets{i}, testInputs);
end


%plotperform(tr);

%plottrainstate(tr);
