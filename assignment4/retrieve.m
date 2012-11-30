function [ outputcase ] = retrieve( cbr, newcase )
% retrieve retrieves a case that matches best with newcase from the given
% CBR system.
    bestsimilarity = Inf;
    bestsimilarityindex = 0;
    for i=1:size(cbr.cases, 2)
        othercase = cbr.cases{i};
        newsimilarity = similarity(othercase, newcase);

        if newsimilarity < bestsimilarity
           bestsimilarity = newsimilarity;
           bestsimilarityindex = i;
        end
    end

    outputcase = cbr.cases{bestsimilarityindex};
end