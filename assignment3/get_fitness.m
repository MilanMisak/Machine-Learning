function [net_out, per_out, tr_out, sim_out] = get_fitness(x, y, net_in, per_in, tr_in, sim_in, vector)

        %Set outputs incase the topology is not an improvement
        net_out = net_in;
        per_out= per_in;
        tr_out = tr_in;
        sim_out = sim_in;

        temp_net = feedforwardnet(vector, 'trainrp');
        temp_net = configure(temp_net, x, y);
        
        for i=1:size(vector)
            temp_net.layers{i}.transferFcn = 'tansig';
        end
                
        temp_net.trainParam.epochs = 100;
        temp_net.divideParam.trainRatio = 67/100;
        temp_net.divideParam.valRatio = 33/100;
        temp_net.divideParam.testRatio = 0;
        
        [temp_net, tr] = train(temp_net, x, y);
        
        if tr.best_vperf < per_in
            net_out = temp_net;
            tr_out = tr;
            per_out = tr.best_perf;
            sim_out = sim(net_out, x);
        end

end

