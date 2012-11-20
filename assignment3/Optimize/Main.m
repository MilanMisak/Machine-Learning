



cleandata = load('cleandata_students.mat');

[x2, y2] = ANNdata(cleandata.x, cleandata.y);
x = x2;
y = y2;
n = size(x, 2);

% 6 1-output networks
nets = cell(1, 7);
trs = cell(1, 7);
simulations = cell(1, 7);
performance = ones(1, 7);
vectors = cell(1, 7);
best_performance = 0;


for i=1:7
    if i == 7
        trainingTargets = y;
    else
        trainingTargets = y(i, :);
    end
    for j=3:20
        vector = j; 
        [nets{i}, performance(i), trs{i}, simulations{i}, vectors{i}] = get_fitness(x, trainingTargets, nets{i}, performance(i), trs{i}, simulations{i}, vectors{i}, vector);
        for k=3:20
            vector = [j,k]; 
            [nets{i}, performance(i), trs{i}, simulations{i}, vectors{i}] = get_fitness(x, trainingTargets, nets{i}, performance(i), trs{i}, simulations{i}, vectors{i}, vector);
        end
    end
    best_performance = best_performance + performance(i);
    vectors{i}
end
  


