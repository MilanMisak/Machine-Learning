function [ net_out ] = trainNet( trainingInputs, trainingTargets, hiddenLayerNodes )
%trainNet Trains a neural network.

max_fail = 10;
escape = 0;
perf = 100;
old_perf = 101;

while ~escape
    for i=1:10
        net = createNet(trainingInputs, trainingTargets, hiddenLayerNodes, max_fail);
        [net, tr] = train(net, trainingInputs, trainingTargets);
        
        vperf = tr.vperf(size(tr.vperf, 2));
        if perf > vperf
            perf = vperf;
            best_net = net;
        end
    end
    if old_perf < perf
        escape = 1;
    else
        old_perf = perf;
        max_fail = max_fail - 1;
        old_net = best_net;
        perf = 100;
    end
end

net_out = old_net;
end


function [ net ] = createNet ( trainingInputs, trainingTargets, hiddenLayerNodes, max_fail)
%createNet Helper function for creating a neural network.

[net] = feedforwardnet(hiddenLayerNodes, 'trainrp');
[net] = configure(net, trainingInputs, trainingTargets);

for j=1:size(hiddenLayerNodes, 1)
    net.layers{j}.transferFcn = 'tansig';
end

net.trainParam.epochs = 100;
net.trainParam.showWindow = 0;
net.trainParam.max_fail = max_fail;

temp_net.divideParam.trainRatio = 67/100;
temp_net.divideParam.valRatio = 33/100;
temp_net.divideParam.testRatio = 0;
end
