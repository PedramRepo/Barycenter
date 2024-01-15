function [MongeCosts, minMonge] = getMongeCosts(N,MongeSpts,labeledCosts)
% Calculate the costs for each potential Monge solution and find the
% minimal Monge cost

    MongeCosts = MongeSpts;
    r = factorial(N)^(N-1);
    weights = 1/N*ones(1:N);
    for i=1:r
        for j=1:N
            label = MongeSpts(i,j);
            [r1,c1] = find(labeledCosts==label);
            MongeCosts(i,j+N) = labeledCosts(r1,2);
        end
        value = 0;
        for j=1:N
            value = value + MongeCosts(i,j+N);
        end
        MongeCosts(i,2*N+1) = value;
    end
    minCost = min(MongeCosts(:,2*N+1));
    [row,col] = find(MongeCosts==minCost);
    minMonge = [MongeCosts(row,1:N)',weights(1:N)',MongeCosts(row,N+1:2*N)'];
end