cleandata = load('cleandata_students.mat');

[x2, y2] = ANNdata(cleandata.x, cleandata.y)


% Part 3 stuff
x = x2;
y = y2;

test_inputs = x(:, 1:100);
test_targets = y(:, 1:100);

[net] = feedforwardnet(50);
[net] = configure(net, x, y);
[net] = train(net, test_inputs, test_targets);