function [ similarity ] = simple_similarity( case1, case2 )
% similarity computes the similarity of 2 cases.
    % TODO - at least 3 different measures
    matching_attributes = 0;
    for i=1:size(case1.problem)
        if ismember(case1.problem(i), case2.problem)
            matching_attributes = matching_attributes + 1;
        end
    end
    unmatched_case2_attributes = size(case2.problem)-matching_attributes;
    similarity = matching_attributes/(size(case1.problem)+unmatched_case2_attributes);
end


function [ similarity ] = jaccard_similarity( case1, case2 )
    problem_intersection = size(intersect(case1.problem, case2.problem));
    problem_union = size(union(case1.problem, case2.problem));
    similarity = problem_intersection / problem_union;
end



