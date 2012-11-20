function [net_out, per_out, vec_out] = get_fitness(x, y, net_in, per_in, vec_in, vector)

        %Set outputs incase the topology is not an improvement
        net_out = net_in;
        per_out= per_in;
        vec_out = vec_in;

        temp_net = feedforwardnet(vector, 'trainrp');
        temp_net = configure(temp_net, x, y);
        
        for i=1:size(vector)
            temp_net.layers{i}.transferFcn = 'tansig';
        end
                
        temp_net.trainParam.epochs = 100;
        temp_net.divideParam.trainRatio = 67/100;
        temp_net.divideParam.valRatio = 33/100;
        temp_net.divideParam.testRatio = 0;
        
        temp_net.trainParam.showWindow = 0;
        
        perf = 0;
        for i=1:5        
            [temp_net, tr] = train(temp_net, x, y);
            perf = perf + (tr.vperf(size(tr.vperf, 2)) / 5);
        end
            
        if perf < per_in
            net_out = temp_net;
            per_out = perf;
            vec_out = vector;
        end

end

