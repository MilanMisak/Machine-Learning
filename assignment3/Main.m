cleandata = load('cleandata_students.mat');

[x2, y2] = ANNdata(cleandata.x, cleandata.y);


% Part 3 stuff
x = x2;
y = y2;

testInputs = x(:, 1:100);
testTargets = y(:, 1:100);

[net] = feedforwardnet(6);
[net] = configure(net, x, y);
net.trainParam.epochs = 100;
[net] = train(net, testInputs, testTargets);
Y = sim(net, testInputs);

nets = cell(1, 6);
simulations = cell(1, 6);

for i=1:6
    trainingTargets = x(i, :);
    [nets{i}] = feedforwardnet(6);
    [nets{i}] = configure(nets{i}, x2, y2);
    nets{i}.trainParam.epochs = 100;    
    nets{i} = train(nets{i}, testInputs, testTargets);
    simulations{i} = sim(nets{i}, testInputs);
end






