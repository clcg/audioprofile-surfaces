function [h ] = plotFittedAudioprofile( f, x, y, varargin )
%plotFittedAudioprofile plots a surface given:
%   f - fitted function
%   x - x array
%   y - y array both from fit_audioprofile_surface
%   h - handle of figure
%   See options below for varargin


p = inputParser;
p.CaseSensitive = true;
addOptional(p,'Title','');
addOptional(p,'Yrange',[min(y) max(y)]);
addOptional(p,'freq_version',1);
addOptional(p,'Normalize',0);
addOptional(p,'Colorbar',1);
addOptional(p,'UseSingleColor',0);
addOptional(p,'Color',[1 0 0]);
addOptional(p,'Ysamples',20);
addOptional(p,'LineStyle','-');
parse(p,varargin{:});

freq_labels = {'125 Hz','250 Hz','500 Hz','1 kHz','1.5 kHz','2 kHz','3 kHz','4 kHz','6 kHz','8 kHz'};

freq_version = p.Results.freq_version;

if freq_version == 1
    x_vals = linspace(1,10,20);
else
    freq_labels = {'.125','','.25','','.5','','1','','2','','4','','8'};
    x_vals = [1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7];
end

if p.Results.Normalize ~= 0
    x_vals = (x_vals - 1 ) /6;
end

if p.Results.Normalize ~= 0
    y_vals = linspace(max([min(y) p.Results.Yrange(1)/85]),min([max(y) p.Results.Yrange(2)/85]),p.Results.Ysamples);
else
    y_vals = linspace(max([min(y) p.Results.Yrange(1)]),min([max(y) p.Results.Yrange(2)]),p.Results.Ysamples);
end


[xx,yy] = meshgrid(x_vals,y_vals);

zz = zeros(numel(y_vals),numel(x_vals));

for i=1:numel(x_vals)
    for j=1:numel(y_vals)
        if p.Results.Normalize ~= 0
        	zz(j,i) = f( xx(j,i), yy(j,i) )*130;
        else
            zz(j,i) = f( xx(j,i), yy(j,i) );
        end
        
    end
end


if p.Results.Normalize ~= 0
    h = surf(xx,yy*85,zz,'LineStyle',p.Results.LineStyle);
else
    h = surf(xx,yy,zz,'LineStyle',p.Results.LineStyle);
end

set(gca, 'XGrid', 'on')
set(gca, 'YGrid', 'on')
set(gca, 'ZGrid', 'on')
set(gca,'ZDir','reverse');

ylim(p.Results.Yrange);
zlim([0 130]);

if p.Results.UseSingleColor ~= 0
   set(h,'FaceColor',p.Results.Color); 
end

if freq_version == 1
    xlim([1 10]);
    set(gca,'XTick',1:10);
else
    
    if p.Results.Normalize ~= 0
        xlim([0 1]);
        set(gca,'XTick',([1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7]-1)/6);
    else
        xlim([1 max(x_vals)]);
        set(gca,'XTick',[1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7]);
    end
end
title(p.Results.Title,'FontSize',18)
set(gca,'XTickLabel',freq_labels)
xlabel('Frequency (kHz)','FontSize',14)
ylabel('Age','FontSize',14)
zlabel('Hearing loss (dB)','FontSize',14)
 
set(gca,'FontSize',14)
view([66 26])
caxis([0 130])
if p.Results.Colorbar == 1
    h = colorbar;
    set(h, 'YDir', 'reverse' ); 
else

set(gca,'FontSize',14)

end