function [label] = labelMaker(N, indices)
% Convert digits in 'indices' variable to one concatenated string
% and then convert that back to an integer number

str = '';
for i=1:N
    str = strcat(str,num2str(indices(i)));
end
label = str2num(str);
end