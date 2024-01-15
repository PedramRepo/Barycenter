clear all;
format short g;

modePassKey = 0;
passArray = zeros(1:2);
strArray = ["",""];
sizeLowerLimit = 1;
dimenLowerLimit = 1;

% mode variable has thw following possible options:
% 1-'check' : Finding a minimal Monge and the Wasserstein Barycenter for
% probability measures with user-defined supports.
% 2-'catch' : Running the code until one non-Monge Barycenter is found.
codeMode = '';
% Number of discrete probability measures and the size of their supports
N = 0;
% Dimension of the underlying space (R^d)
d = 0;

while(~modePassKey)
    value = input("Select the code running mode (catch/check): ",'s');
    modeType = isa(value,"char");
    if (modeType)
        normalizedValue = lower(value);
        if (strcmp(normalizedValue,"check"))
            strArray(1) = "\nEnter the number of discrete probability measures (1<N<10): ";
            strArray(2) = "\nEnter the dimension of the underlying space (1<d): ";
            codeMode = value;
            sizeLowerLimit = 1;
            modePassKey = 1;            
        elseif (strcmp(normalizedValue,"catch"))
            strArray(1) = "\nEnter the number of discrete probability measures (2<N<10): ";
            strArray(2) = "\nEnter the dimension of the underlying space (1<d): ";
            codeMode = value;
            sizeLowerLimit = 2;
            modePassKey = 1;
        else          
            cprintf("Errors","Selected mode is invalid! Try again.");
            cprintf("Text", "\n\n");
        end
    else
        cprintf("Errors","Entered value is not a string.");
        cprintf("Text", "\n\n");
    end
end

while(~passArray(1))
    value = input(strArray(1));
    sizeCheck = isa(value,"double");
    if (sizeCheck)
        if (sizeLowerLimit < value && value < 10)
            N = value;
            passArray(1) = 1;
        else
            cprintf("Errors","Entered number is not in the valid range! Try again.");
            cprintf("Text", "\n\n");
        end
    else
        cprintf("Errors","Entered value is not a number.");
        cprintf("Text", "\n\n");
    end        
end            

while(~passArray(2))
    value = input(strArray(2));
    sizeCheck = isa(value,"double");
    if (sizeCheck)
        if (value > dimenLowerLimit)
            d = value;
            passArray(2) = 1;
        else
            cprintf("Errors","Entered number is not in the valid range! Try again.");
            cprintf("Text", "\n\n");
        end
    else
        cprintf("Errors","Entered value is not a number.");
        cprintf("Text", "\n\n");
    end        
end               


if (strcmp(codeMode,'check'))
    [domain, labels, bcSpt] = domLblSpt(N,d,0);
    [labeledCosts, orderedCosts] = getCouplingCosts(N,domain,labels);
    MongeSpts = getMongeSpts(N,labels);
    [MongeCosts, minMonge] = getMongeCosts(N,MongeSpts,labeledCosts);
    bcLpSol = bcLP(N,labeledCosts);
    [diff, result] = getDiff(minMonge,bcLpSol);

    % domain          % Coordinates of the supports of all measures
    % bcSpt           % Coordinates of the Barycenter support
    % labels          % Labels corresponding to possible couplings
    % labeledCosts    % Coupling costs corresponding to labels
    % orderedCosts    % Coupling costs in order from min to max
    % MongeSpts       % Supports of all potential Monge solutions 
    % MongeCosts      % Costs corresponding to each potential Monge solution
    minMonge        % The minimal Monge cost
    bcLpSol         % The Wasserstein Barycenter support and cost
    fprintf("Minimal Monge cost: %f\n", result(1));
    fprintf("Barycenter cost: %f\n", result(2));
    fprintf("Cost difference: %f\n\n", result(3));

elseif (strcmp(codeMode,'catch'))
    diff = 0;
    fprintf("\nFinding a Barycenter whose LP solution has no Monge-type solution...\n");    
    while (~diff)
        [domain, labels, bcSpt] = domLblSpt(N,d,1);
        [labeledCosts, orderedCosts] = getCouplingCosts(N,domain,labels);
        MongeSpts = getMongeSpts(N,labels);
        [MongeCosts, minMonge] = getMongeCosts(N,MongeSpts,labeledCosts);
        bcLpSol = bcLP(N,labeledCosts);
        [diff, result] = getDiff(minMonge,bcLpSol);
    end
    % domain          % Coordinates of the supports of all measures
    % bcSpt           % Coordinates of the Barycenter support
    % labels          % Labels corresponding to possible couplings
    % labeledCosts    % Coupling costs corresponding to labels
    % orderedCosts    % Coupling costs in order from min to max
    % MongeSpts       % Supports of all potential Monge solutions 
    % MongeCosts      % Costs corresponding to each potential Monge solution
    minMonge        % The minimal Monge cost
    bcLpSol         % The Wasserstein Barycenter support and cost
    fprintf("Minimal Monge cost: %f\n", result(1));
    fprintf("Barycenter cost: %f\n", result(2));
    fprintf("Cost difference: %f\n\n", result(3));
else
    disp("Selected mode is invalid!");
end
        



