function [areaVector,sfactor_opt] = shrinkFactorFunction(Xs,Ys,Zs,sStart,sEnd,N)

shrinkFactorVector = linspace(sStart,sEnd,N);
areaVector = zeros(1,numel(shrinkFactorVector));


parfor ii = 1:numel(areaVector)
[k2,~] = boundary(Xs,Ys,Zs,shrinkFactorVector(ii));


h = trisurf(k2,Xs,Ys,Zs);

Vertices = h.Vertices;
Faces = h.Faces;


A = Vertices(Faces(:, 2), :) - Vertices(Faces(:, 1), :);
B = Vertices(Faces(:, 3), :) - Vertices(Faces(:, 1), :);
C = cross(A, B, 2);

cell_area = 1/2 * sum(sqrt(sum(C.^2, 2)));

areaVector(ii) = cell_area;

end

dvector = diff(areaVector);
[~,idx] = max(dvector);
sfactor_opt = shrinkFactorVector(idx); 


end