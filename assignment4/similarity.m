function [ similarity_value ] = similarity( case1, case2 )
% similarity computes the similarity of 2 cases.
    similarity_value = size(intersect(case1.problem, case2.problem));
    similarity_value = similarity_value / max(size(case1.problem), size(case2.problem));


    %similarity_value = dice_similarity(case1.problem, case2.problem);

    %similarity_value = jaccard_similarity(case1.problem, case2.problem);

    %similarity_value = levenshtein_similarity(case1.problem, case2.problem);
end


function [ similarity_value ] = jaccard_similarity( prob1, prob2 )
    problem_intersection = size(intersect(prob1, prob2));
    problem_union = size(union(prob1, prob2));
    similarity_value = problem_intersection / problem_union;
end

function [ similarity_value ] = dice_similarity( prob1, prob2 )
    numerator = 2 * size(intersect(prob1, prob2));
    denominator = size(prob1) + size(prob2);
    similarity_value = numerator / denominator;
end

function [ similarity_value ] = levenshtein_similarity( prob1, prob2 )
    cost = 0;
    prob1_size = size(prob1, 2);
    prob2_size = size(prob2, 2);

    if prob1_size == 0
        similarity_value = prob2_size;
        return;
    end
    if prob2_size == 0
        similarity_value = prob1_size;
        return;
    end
    
    if prob1(1) ~= prob2(1);
        cost = 1;
    end
    
    smaller_prob1 = prob1(1:(prob1_size - 1));
    smaller_prob2 = prob2(1:(prob2_size - 1));
    
    similarities = zeros(1, 3);
    similarities(1) = levenshtein_similarity(smaller_prob1, prob2) + 1;
    similarities(2) = levenshtein_similarity(prob1, smaller_prob2) + 1;
    similarities(3) = levenshtein_similarity(smaller_prob1, smaller_prob2) + cost;
    
    similarity_value = 1 / min(similarities) + 1;
end
