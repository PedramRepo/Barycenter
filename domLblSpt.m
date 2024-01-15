function [domain, labels, bcSpt] = domLblSpt(N,d,gen)
% Return the following:
%  --> coordinates of the points on the domain of probability measures
%  --> labels of the domain of the barycenter
%  --> the barycenter support

    domain = zeros(N,d,N);
    bcSpt = zeros(N^N,d+1);
    labels = zeros(N^N,N+2);    

    if (gen)
        ind = 0;
        randomArray = -5 + 10*rand(1,N*N*d);
        for k=1:N
            for i=1:N
                for j=1:d
                    ind = ind + 1;
                    domain(i,j,k) = randomArray(ind);
                end
            end
        end
    else
        passArray = zeros(1:N);
        for k=1:N
            while(~passArray(k))
                prompt = sprintf("\nEnter the %d by %d support for probability measure P%d: ",N,d,k);
                value = input(prompt);
                [r,s] = size(value);
                if (r~=N || s~=d)
                    cprintf("Errors","The entered matrix is invalid! Try again.");
                    cprintf("Text", "\n\n");
                else
                    passArray(k)=1;
                    domain(:,:,k) = value;
                end
            end
        end
        % if (n==2)
        %     domain(:,:,1)=[1 0; 2 0];
        %     domain(:,:,2)=[0 1; 0 2];
        %     domain(:,:,3)=[1 1; 2 2];
        % elseif (n==3)
        %     domain(:,:,1)=[1 0; 2 0; 3 0];
        %     domain(:,:,2)=[0 1; 0 2; 0 3];
        %     domain(:,:,3)=[1 1; 2 2; 3 3];
        % end
    end
        start = ones(1,N);
        for i=0:N^N-1
            sum = 0;
            indices = dec2base(i,N,N)-'0' + start;
            labels(i+1,1) = labelMaker(N, indices);
            labels(i+1,2) = i + 1;
            labels(i+1,3:2+N) = indices(1,:);
            bcSpt(i+1,1) = labels(i+1,1);
            for j=1:N
                sum = sum + domain(indices(j),:,j);
            end            
            bcSpt(i+1,2:d+1) = sum/N;
        end
end
