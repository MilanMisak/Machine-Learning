function [ outputcase ] = retrieve ( cbr, newcase)
    
    bestsimilarity = -Inf;
    best = 0;
    
    for i=1:6
        newsimilarity = similarity(cbr.categories{i}.averageAUProblem, newcase.problem);
        if newsimilarity > bestsimilarity
            bestsimilarity = newsimilarity;
            best = i;
        end
    end
    
    outputcase = MakeCase(cbr.categories{best}.averageBinaryProblem, best);
end


function [ outputcase ] = OldRetrieve( cbr, newcase )
% retrieve retrieves a case that matches best with newcase from the given
% CBR system.
    bestsimilarity = -Inf;
    bestsimilarityarray = {};
    for i=1:size(cbr.cases, 2)
        othercase = cbr.cases{i};
        newsimilarity = similarity(othercase, newcase);

        if newsimilarity > bestsimilarity
           bestsimilarity = newsimilarity;
           bestsimilarityarray = {othercase};
        elseif newsimilarity == bestsimilarity
            bestsimilarityarray{size(bestsimilarityarray, 1) + 1} = othercase;
        end
    end
    
    typicalities = zeros(1, 6);
    for i=1:size(bestsimilarityarray, 2)
        candidatecase = bestsimilarityarray{1, i};
        typicalities(1, candidatecase.solution) = typicalities(1, candidatecase.solution) + candidatecase.typicality;
    end
    
    [C, maxtypicalityindex] = max(typicalities);

    for i=1:size(bestsimilarityarray, 2)
        candidatecase = bestsimilarityarray{1, i};
        if candidatecase.solution == maxtypicalityindex
            outputcase = candidatecase;
            return;
        end
    end
end