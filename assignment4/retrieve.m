function [ outputcase ] = retrieve( cbr, newcase )
% retrieve retrieves a case that matches best with newcase from the given
% CBR system.
    knearest = 3;
    worstsimilarity = Inf;
    cases = {};
    casesimilarities = {};
    
    %the first knearest cases are the current knearest most similar
    for i=1:knearest
        othercase = cbr.cases{i};
        cases{i} = othercase;
        newsimilarity = similarity(othercase, newcase);
        casesimilarities{i} = newsimilarity;
        
        if newsimilarity < worstsimilarity
            worstsimilarity = newsimilarity;
        end
    end
    
    for i=(knearest+1):size(cbr.cases, 2)
        othercase = cbr.cases{i};
        newsimilarity = similarity(othercase, newcase);

        if newsimilarity > worstsimilarity %the new case is a better fit
            newcases = {othercase};
            newcasesimilarities = {newsimilarity};
            tempworst = worstsimilarity;
            worstsimilarity = newsimilarity;
            caseno = 2;
            
            %only keep the cases that weren't the worst case in the set
            for j=1:size(cases, 2)
                tempsim = casesimilarities{j};
                if tempsim > tempworst
                    newcases{caseno} = cases{j};
                    newcasesimilarities{caseno} = tempsim;
                    caseno = caseno + 1;
                    if tempsim < worstsimilarity
                        worstsimilarity = tempsim;
                    end
                end
            end
            %if there were many with the worst similarity, and the group is
            %now smaller than knearest, we have to add them back in
            if size(newcases, 2) < knearest
                newcases = cases;
                newcases{size(cases, 2)} = othercase;
                newcasesimilarities = casesimilarities;
                newcasesimilarities{size(cases, 2)} = newsimilarity;
            end
            
            cases = newcases;
            casesimilarities = newcasesimilarities;
            
        elseif newsimilarity == worstsimilarity
            cases{size(cases, 2) + 1} = othercase;
            casesimilarities{size(cases, 2) + 1} = newsimilarity;
        end
    end
    
    typicalities = zeros(1, 6);
    for i=1:size(cases, 2)
        candidatecase = cases{i};
        typicalities(1, candidatecase.solution) = typicalities(1, candidatecase.solution) + candidatecase.typicality;
    end
    
    [C, maxtypicalityindex] = max(typicalities);

    for i=1:size(cases, 2)
        candidatecase = cases{i};
        if candidatecase.solution == maxtypicalityindex
            outputcase = candidatecase;
            return;
        end
    end
end