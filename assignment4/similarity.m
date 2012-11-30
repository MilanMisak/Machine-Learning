function [ similarity ] = case_similarity( case1, case2 )
% similarity computes the similarity of 2 cases.
    %similarity = size(intersect(case1.problem, case2.problem));
    %similarity = dice_similarity(case1.problem, case2.problem);
    similarity = jaccard_similarity(case1.problem, case2.problem);
    %similarity = levenshtein_similarity(case1.problem, case2.problem);
end


function [ similarity ] = jaccard_similarity( prob1, prob2 )
    problem_intersection = size(intersect(prob1, prob2));
    problem_union = size(union(prob1, prob2));
    similarity = problem_intersection / problem_union;
end

function [ similarity ] = dice_similarity( prob1, prob2 )
    numerator = 2 * size(intersect(prob1, prob2));
    denominator = size(prob1) + size(prob2);
    similarity = numerator / denominator;
end

function [similarity] = levenshtein_similarity( prob1, prob2 )
    cost = 0;
    prob1_size = size(prob1);
    prob2_size = size(prob2);

    if prob1(1) ~= prob2(1);
        cost = 1;
    end

    if prob1_size == 0
        similarity = prob2_size;
        return;
    elseif prob2_size == 0
        similarity = prob1_size;
        return;
    end
    
    smaller_prob1 = prob1(1:(prob1_size - 1));
    smaller_prob2 = prob2(1:(prob2_size - 1));
    
    similarities = zeros(3);
    similarities(1) = levenshtein_similarity(smaller_prob1, prob2) + 1;
    similarities(2) = levenshtein_similarity(prob1, smaller_prob2) + 1;
    similarities(3) = levenshtein_similarity(smaller_prob1, smaller_prob2) + cost;
    
    similarity = min(similarities);
end
