function [difference, result] = getDiff(minMonge,bcLpSol)
% Calculate the difference between the cost of the minimal Monge solution
% and the solution of LP.

    mongeCost = 0;
    bcLpCost = 0;
    bcLpSize = size(bcLpSol,1);
    minMongeSize = size(minMonge,1);
    for i=1:minMongeSize
        mongeCost = mongeCost + minMonge(i,3)/minMongeSize;
    end
    
    for i=1:bcLpSize
        bcLpCost = bcLpCost + bcLpSol(i,3)/bcLpSize;
    end
    difference = mongeCost - bcLpCost;
    result = [mongeCost, bcLpCost, difference, difference/mongeCost];
end
    