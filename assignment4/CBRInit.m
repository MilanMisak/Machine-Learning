function [ cbr ] = CBRInit( x, y )
%CBRInit initialises a CBR system given a matrix of examples x and a vector
% of labels y.
    % TODO
    cbr.cases = {};
    for i=1:size(x, 1)
        cbr.cases(i) = []; % TODO - get case
    end
end
