function [ f, x,y,z ] = fit_audioprofile_surface( current_features,varargin )
% fit_audioprofile_surface fits and audioprofile surface to set of
% features. 
%   fit_audioprofile_surface( current_features,"poly33" ) first a 3rd order
%   polynomial in both x and y to the audiograms.
% See http://www.mathworks.com/help/curvefit/surface-fitting.html

if nargin > 1
    freq_version = varargin{1};
else
    freq_version = 1;
end

if nargin > 2
    norm_freq = varargin{2};
else
    norm_freq = 0;
end

[num_audiograms num_features] = size(current_features);

freq_x_vals = [1 2 3 4 4.5 5 5.5 6 6.5 7];

if norm_freq ~= 0
    freq_x_vals = (freq_x_vals - 1 ) ./ 6;
end

x = [];
y = [];
z = [];
for i=1:10
    if freq_version == 1
        x = [x; repmat(i,size(current_features(:,1),1),1)];
    else
        x = [x; repmat(freq_x_vals(i),size(current_features(:,1),1),1)];   
    end
    
    y = [y; current_features(:,1)];
    z = [z; current_features(:,i+1)];
end


polynomial = varargin{3};    

f = fit( [x, y], z, polynomial,'Normalize','on','Robust','Bisquare' );

end
