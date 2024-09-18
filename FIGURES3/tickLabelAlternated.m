function [strCell] = tickLabelAlternated(vect)

%% Creates a list of string of values alternating between a tick value and a blank value ('')
% Its purpose is to be used within a ticklabel function
% 

% strMatrix = arrayfun(@(x) num2str(x), vect, 'uniformOutput', 'false');
strCell = arrayfun(@(x) num2str(x), vect, 'uniformOutput', 0);

Nend = numel(strCell);

Idx = 2:2:Nend;

strCell(Idx) = {''};


end