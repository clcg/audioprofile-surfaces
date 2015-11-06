function [ f,x,y,z ] = fit_audioprofile_surface_cv( current_features )
% fit_audioprofile_surface_cv fits an audioprofile surface (APS) to a set of
% audiograms. The current features only contain the age and frequency
% values. This function also plots the APSs with the RMS value

PLOT = 1;

possible_surface = {'poly33','poly32','poly22'};

rms_values = zeros(numel(possible_surface),1);

f_vals = {};
x_vals = {};
y_vals = {};
z_vals = {};

%create cross validation sets
num_audiograms = size(current_features,1);
num_folds = 5;

IDX = crossvalind('Kfold', size(current_features,1), num_folds);

figure(10);
clf
ps = zeros(3,1);

for i=1:numel(possible_surface)
    rms_tmp = 0;
    
    for j=1:num_folds
        FOLD_IDX = find(j == IDX);
        [ f_temp, x_temp,y_temp,z_temp ] = fit_audioprofile_surface(current_features(FOLD_IDX,1:11),2,0,char(possible_surface(i)));
        rms_val = compute_rms(current_features,f_temp);
        rms_tmp = rms_tmp + rms_val;
    end
    rms_values(i) = rms_tmp/num_folds;
    display(['Curve: ',possible_surface(i),' RMS: ',num2str(rms_values(i))]);
    
    if PLOT == 1
       ps(i) = subplot(2,2,i);
       
       hold on;
       [ f_temp, x_temp,y_temp,z_temp ] = fit_audioprofile_surface(current_features(:,1:11),2,0,char(possible_surface(i)));
       plotFittedAudioprofile(f_temp,x_temp,y_temp,'Title',['Curve: ',char(possible_surface(i)),' RMS: ',num2str(rms_values(i))],'freq_version',2,'Yrange',[0 90]);
%        for j=1:num_audiograms
%             plotAudiogramIn3D(current_features(j,:),'-');
%        end
       hold off;
    end
    
end

f = f_temp;
x = x_temp;
y = y_temp;
z = z_temp;

linkprop(ps, {'CameraPosition','CameraUpVector'});


end

