function Visualize_3D_reconstruction(vol3D,filename)
V = vol3D;

Vrot = permute(V,[3,2,1]);
Vrot = fliplr(Vrot);
Vrot = rot90(Vrot,-1);

intensity = [0 0.3 0.5 0.75 1]; %intensity and transparency map
alpha = [0 0 0.7 0.75 1];

queryPoints = linspace(min(intensity),max(intensity),256);
alphamap = interp1(intensity,alpha,queryPoints)';

colormap = viridis(256);

h = volshow(Vrot,Colormap=colormap,Alphamap=alphamap);
viewer = h.Parent;
viewer.BackgroundColor = [0 0 0];
viewer.LightColor = [1 1 1];
viewer.BackgroundGradient = "off";
center = [102.5000   72.5000   72.5000];

hFig = viewer.Parent;

thetad = 0:-1:-360;

vec1 = [0 150 0]';

viewer.CameraTarget = center;

VEC = zeros(length(thetad),3);
CAMUPVECTOR = zeros(length(thetad),3);

for idx = 1:length(VEC)
    viewer.CameraZoom = 2;

    Rx = [1 0 0; 0 cosd(thetad(idx)) sind(thetad(idx)); 0 -sind(thetad(idx)) cosd(thetad(idx)) ];
    VEC(idx,:) = (Rx*vec1)';
    viewer.CameraPosition = VEC(idx,:)+center;

    CAMUPVECTOR(idx,:) =  [0, cosd(thetad(idx)-45), -sind(thetad(idx)-45)];
    viewer.CameraUpVector = CAMUPVECTOR(idx,:);

    I = getframe(hFig);
    [indI,cm] = rgb2ind(I.cdata,256);

    % Write the frame to the GIF file
    if idx==1

    elseif idx == 2
        imwrite(indI,cm,filename,"gif",Loopcount=inf,DelayTime=0)
    else
        imwrite(indI,cm,filename,"gif",WriteMode="append",DelayTime=0)
    end
end

end