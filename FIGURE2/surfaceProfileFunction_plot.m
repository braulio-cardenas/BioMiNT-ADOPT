function [faces, verts,areaVector] = surfaceProfileFunction_plot(vol3D,umPerPixel,s_start,s_end,Nvals,isoval)

Nvol3D = vol3D./(max(max(max(vol3D))));

% Get the dimensions of Nvol3D
[m, n, p] = size(Nvol3D);

% Create the x, y, and z grids with the same dimensions as Nvol3D
[x, y, z] = meshgrid(1:n, 1:m, 1:p);

[~,verts] = isosurface(Nvol3D,isoval);

X = verts(:,1);
Y = verts(:,2);
Z = verts(:,3);

x0 = mean(X);
y0 = mean(Y);
z0 = mean(Z);

Xc = X-x0;
Yc = Y-y0;
Zc = Z-z0;

[areaVector,sfactor_opt] = shrinkFactorFunction(Xc,Yc,Zc,s_start,s_end,Nvals);

[k,~] = boundary([Xc,Yc,Zc],sfactor_opt);

idx1 =  k(:,1);
idx2 =  k(:,2);
idx3 =  k(:,3);

Xs = Xc(idx1);
Ys = Yc(idx2);
Zs = Zc(idx3);

aux = unique([Xs,Ys,Zs],'rows');

Xs = aux(:,1);
Ys = aux(:,2);
Zs = aux(:,3);


AvgRadius_s = umPerPixel*mean(sqrt(Xs.^2 + Ys.^2 + Zs.^2));

Ms = umPerPixel*sqrt(Xs.^2 + Ys.^2 + Zs.^2) -AvgRadius_s;

D = umPerPixel*sqrt((x-x0).^2+(y-y0).^2+(z-z0).^2)-AvgRadius_s;

figure,
isosurface((x-x0)*umPerPixel,(y-y0)*umPerPixel,(z-z0)*umPerPixel,Nvol3D,isoval,D);
[faces,verts] = isosurface((x-x0)*umPerPixel,(y-y0)*umPerPixel,(z-z0)*umPerPixel,Nvol3D,isoval,D);
axis equal;

hex_colors = {'#0E3580', '#0F4BA3', '#1D6DC4', '#389CE8', '#4DB2F8', '#7ED0F8', '#9AEDFB', '#C8F9FD', '#FFFFFF', '#FFFCDD', '#FFEA7F', '#FFC03E', '#FFA105', '#FE6100', '#FF3300', '#DF1500', '#C10000'};

cmap = hex2colormap(hex_colors,512);

colormap(cmap);
clim([min(Ms), max(Ms)]);

grid on;

end
