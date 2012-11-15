cleandata = load('cleandata_students.mat');

[x2, y2] = ANNdata(cleandata.x, cleandata.y)


% Part 3 stuff
x = x2;
y = y2;

test_inputs = x(:, 1:100);
test_targets = y(:, 1:100);

[net] = feedforwardnet(6);
[net] = configure(net, x, y);
net.trainParam.epochs = 100;
[net, tr] = train(net, test_inputs, test_targets);

plotperform(tr);

plottrainstate(tr);

%Y = sim(net, test_inputs);
%plot(test_inputs, test_targets, test_inputs, Y, 'r.');