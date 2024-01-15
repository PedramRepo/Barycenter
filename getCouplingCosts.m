function [labeledCosts, orderedCosts] = getCouplingCosts(N,domain,labels)
% Return the collection of minimal costs corresponding to all possible 
% couplings

    % ind = 0;
    labeledCosts = zeros(N^N,2);
    labeledCosts(:,1) = labels(:,1);
    labelIndices = zeros(1,N+1);
    ind = zeros(1,N+1);
    ind(1,1:N)=1:N;
    ind(1,N+1)=1;

    for i=1:N^N
        cost = 0;
        labelIndices(1,1:N) = labels(i,3:2+N);
        labelIndices(1,N+1) = labels(i,3);
        for k=1:N
            b = labelIndices(1,k);
            e = labelIndices(1,k+1);
            cost = cost + norm(domain(b,:,ind(1,k))-domain(e,:,ind(1,k+1)))^2;
        end
        labeledCosts(i,2) = cost;
    end
    orderedCosts = sortrows(labeledCosts,2);
end
