function [MongeSpts] = getMongeSpts(N,labels)
% Return the set of all Monge extremal tuples

    domain = labels;
    buffer = zeros(1,N);
    MongeSpts = zeros(factorial(N)^(N-1),N);
    cntr = 1;
    permutation(domain,0);
    
    function [] = permutation(domain,stepInd)
    % Find permutations
        stepInd = stepInd + 1;
        if (stepInd <= N)
            r = (N+1-stepInd)^(N-1);
            for i=1:r
                element = domain(i,:);
                buffer(stepInd) = labelMaker(N,element(1,3:2+N));
                subDomain = getSubDomain(element,domain);
                permutation(subDomain,stepInd);
            end            
        else
            MongeSpts(cntr,1:N) = buffer;
            cntr = cntr + 1;
            stepInd = stepInd - 1;
            buffer(stepInd) = 0;
        end
    end
end

% Internal functions
% ------------------
function [subDomain] = getSubDomain(element,domain)
% Return subdomain

    [domRow,domCol] = size(domain);
    domLblCol = domain(:,1);
    subCols = (domain(:,3) ~= element(3));
    for j=2:domCol-2
        subCols = subCols & (domain(:,2+j) ~= element(2+j));
    end
    subLabels = domLblCol(subCols);
    r = size((subLabels ~= 0),1);
    subDomain = zeros(r,domCol);
    for i=1:r
        for j=1:domRow
            if (subLabels(i) == domLblCol(j))
                subDomain(i,:) = domain(j,:);
            end
        end
    end
end
