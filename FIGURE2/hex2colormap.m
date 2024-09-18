function cmap = hex2colormap(hexlist, n_total)

n_colors = length(hexlist);
n_interp = round((n_total - n_colors)/(n_colors - 1));
cmap = zeros(n_total, 3);

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

hex = hex(2:end);
r = hex2dec(hex(1:2)) / 255;
g = hex2dec(hex(3:4)) / 255;
b = hex2dec(hex(5:6)) / 255;
rgb = [r, g, b];

end
