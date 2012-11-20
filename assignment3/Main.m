



cleandata = load('cleandata_students.mat');

[x2, y2] = ANNdata(cleandata.x, cleandata.y);
x = x2;
y = y2;
n = size(x, 2);

%f = floor(0.67*n)
%c = ceil(0.67*n)

%testInputs  = x(:, 1:floor(0.67*n));
%testTargets = y(:, 1:floor(0.67*n));
%validationInputs  = x(:, (floor(0.67*n) + 1):n);
%validationTargets = y(:, (floor(0.67*n) + 1):n);

% 6-output network
%[net] = feedforwardnet(6);
%[net] = configure(net, x, y);
%net.trainParam.epochs = 100;
%[net, tr] = train(net, testInputs, testTargets);

%predictions = testANN(net, validationInputs);



% 6 1-output networks
nets = cell(1, 6);
trs = cell(1, 6);
simulations = cell(1, 6);
performance = ones(1, 6);
best_performance = 0


for i=1:1
    trainingTargets = testTargets(i, :);
    for j=2:15
        vector = j; 
        [nets{i}, performance(i), trs{i}, simulations{i}] = get_fitness(x, y, nets{i}, performance(i), trs{i}, simulations{i}, vector);
        for k=2:15
            vector = [j,k]; 
            [nets{i}, performance(i), trs{i}, simulations{i}] = get_fitness(x, y, nets{i}, performance(i), trs{i}, simulations{i}, vector);
            for l=2:15
                vector = [j,k,l]; 
                [nets{i}, performance(i), trs{i}, simulations{i}] = get_fitness(x, y, nets{i}, performance(i), trs{i}, simulations{i}, vector);                         
            end            
        end
    end
    best_performance = best_performance + performance(i);
end



best_performance
trs{i}
%plotperform(tr);

%plottrainstate(tr);


