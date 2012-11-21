function [ net_out ] = trainNet( trainingInputs, trainingTargets, hiddenLayerNodes )
%trainNet Trains a neural network.

best = 100;
for i=1:10
    [net] = feedforwardnet(hiddenLayerNodes, 'trainrp');
    [net] = configure(net, trainingInputs, trainingTargets);

    for j=1:size(hiddenLayerNodes, 1)
        net.layers{j}.transferFcn = 'tansig';    
    end

    net.trainParam.epochs = 100;
    net.trainParam.showWindow = 0;

    net.divideParam.trainRatio = 67/100;
    net.divideParam.valRatio = 33/100;
    net.divideParam.testRatio = 0;
   
    
    [net, tr] = train(net, trainingInputs, trainingTargets);

    if tr.vperf(size(tr.vperf, 2)) < best
        net_out = net;

end
end
