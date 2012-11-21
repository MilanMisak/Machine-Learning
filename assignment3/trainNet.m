function [ net ] = trainNet( trainingInputs, trainingTargets, hiddenLayerNodes )
%trainNet Trains a neural network.

[net] = feedforwardnet(hiddenLayerNodes, 'trainrp');
[net] = configure(net, trainingInputs, trainingTargets);

for i=1:size(hiddenLayerNodes, 1)
    net.layers{i}.transferFcn = 'tansig';    
end

net.trainParam.epochs = 100;
net.trainParam.showWindow = 0;

net.divideParam.trainRatio = 67/100;
net.divideParam.valRatio = 33/100;
net.divideParam.testRatio = 0;
        
[net, tr] = train(net, trainingInputs, trainingTargets);
end