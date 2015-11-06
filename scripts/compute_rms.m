function [ rms ] = compute_rms( audiograms, f1)
% COMPUTE_RMS Computes the RMS of a surface and audiograms

x_vals = [1 2 3 4 4.5 5 5.5 6 6.5 7];

y_vals = audiograms(:,1);

[xx,yy] = meshgrid(x_vals,y_vals);

zz1 = f1( xx, yy);

%clamp the values
zz1 = bsxfun(@min,zz1,130);
zz1 = bsxfun(@max,zz1,-10);

rms = min(sqrt(sum((zz1 - audiograms(:,2:11)).^2,2)));

end