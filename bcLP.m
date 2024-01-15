function [bcLpSol] = bcLP(N,labeledCosts)
% Return the barycenter actual support via solving the corresponding 
% linear programming problem

    A = zeros(N^2,N^N);
    B = (1/N)*ones(1,N^2);
    lb = zeros(N^N,1);
    
    for m=1:N
        filler = Imn(N,N^(N-m+1),N^(N-m));
        step = N^(m-1);
        col = N^(N+1-m);
        for k=1:step
            A((m-1)*N+1:(m-1)*N+N,(k-1)*col+1:(k-1)*col+col)=filler;
        end
    end
    
    options = optimoptions('linprog','Display','none');
    f = labeledCosts(:,2)';
    x = linprog(f,[],[],A,B,lb,[],options);
    rows = find(x ~= 0);
    bcLpSol = [labeledCosts(rows), x(rows), labeledCosts(rows,2)];
end

function [eI] = Imn(m,n,block)
% Return m by n sized identity sub-matrix

    eI = zeros(m,n);
    for i=1:m
        shift = (i-1)*block;
        for j=shift+1:shift+block
            eI(i,j)=1;
        end
    end
end
