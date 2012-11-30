function [ similarity ] = simple_similarity( case1, case2 )
% similarity computes the similarity of 2 cases.
    % TODO - at least 3 different measures
    %similarity = size(union(case1, case2));
    similarity = jaccard_similarity(case1, case2);
    %similarity = levenshtein_similarity(case1, case2);
end


function [ similarity ] = jaccard_similarity( case1, case2 )
    problem_intersection = size(intersect(case1.problem, case2.problem));
    problem_union = size(union(case1.problem, case2.problem));
    similarity = problem_intersection / problem_union;
end

function [ similarity ] = dice_similarity( case1, case2 )
    numerator = 2 * size(intersect(case1.problem, case2.problem));
    denominator = size(case1.problem) + size(case2.problem);
    similarity = numerator / denominator;
end

function [similarity] = levenshtein_similarity( case1, case2 )
    cost = 0;
    problem1_size = size(case1.problem);
    problem2_size = size(case2.problem);

    if case1.problem(1) ~= case2.problem(1);
        cost = 1;
    end

    if problem1_size == 0
        similarity = problem2_size;
    elseif problem2_size == 0
        similarity = problem1_size;
    else
        smaller_prob1 = case1.problem(1:(problem1_size - 1));
        smaller_prob2 = case2.problem(1:(problem2_size - 1));
        
        similarities = zeros(3);
        similarities(1) = levenshtein_similarity(smaller_prob1, case2.problem) + 1;
        similarities(2) = levenshtein_similarity(case1.problem, smaller_prob2) + 1;
        similarities(3) = levenshtein_similarity(smaller_prob1, smaller_prob2) + cost;
        
        similarity = min(similarities);
    end
end