function cmap = hex2colormap(hexlist, n_total)
% HEX2COLORMAP_INTERPOLATED converts a list of hexadecimal color codes to a colormap
% with interpolated colors
% hexlist: a cell array of hexadecimal color codes
% n_interp: the number of interpolation values between each pair of colors
% cmap: the resulting colormap

n_colors = length(hexlist);
n_interp = round((n_total - n_colors)/(n_colors - 1));

% n_total = n_colors + (n_colors - 1) * n_interp;
cmap = zeros(n_total, 3);

% Convert hex codes to RGB and add interpolated values
for i = 1:n_colors-1
    c1 = hex2rgb(hexlist{i});
    c2 = hex2rgb(hexlist{i+1});
    for j = 0:n_interp
        idx = (i-1)*(n_interp+1) + j + 1;
        t = j / n_interp;
        cmap(idx, :) = (1-t) * c1 + t * c2;
    end
end
cmap(n_total, :) = hex2rgb(hexlist{n_colors});

end

function rgb = hex2rgb(hex)
% HEX2RGB converts a hexadecimal color code to an RGB triple
% hex: a hexadecimal color code
% rgb: the resulting RGB triple

hex = hex(2:end); % remove the leading '#'
r = hex2dec(hex(1:2)) / 255;
g = hex2dec(hex(3:4)) / 255;
b = hex2dec(hex(5:6)) / 255;
rgb = [r, g, b];

end



% function cmap = hex2colormap(hexlist)
% % HEX2COLORMAP converts a list of hexadecimal color codes to a colormap
% % hexlist: a cell array of hexadecimal color codes
% % cmap: the resulting colormap
% 
% n = length(hexlist);
% cmap = zeros(n, 3);
% for i = 1:n
%     cmap(i, :) = hex2rgb(hexlist{i});
% end
% 
% end
% 
% function rgb = hex2rgb(hex)
% % HEX2RGB converts a hexadecimal color code to an RGB triple
% % hex: a hexadecimal color code
% % rgb: the resulting RGB triple
% 
% hex = hex(2:end); % remove the leading '#'
% r = hex2dec(hex(1:2)) / 255;
% g = hex2dec(hex(3:4)) / 255;
% b = hex2dec(hex(5:6)) / 255;
% rgb = [r, g, b];
% 
% end
