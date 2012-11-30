function [ auvector ] = CreateAUVector( attributevector )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    auvector = [];
    for i=1:size(attributevector, 2)
        if attributevector(1, i) == 1
            auvector = [auvector i];
        end
    end
end

