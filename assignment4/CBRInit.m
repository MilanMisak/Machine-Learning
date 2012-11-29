function [ cbr ] = CBRInit( x, y )
%CBRInit initialises a CBR system given a matrix of examples x and a vector
% of labels y.
    % TODO
    cbr.cases = {};
    for i=1:size(x, 1)
        % TODO - check if a case already exists and then update typicality
        cbr.cases(i) = MakeCase(x(i, :), y(i));
    end
end
