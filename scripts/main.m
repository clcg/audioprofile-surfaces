%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Takes in a csv and fits multiple audioprofile surfaces to the audigrams.
% Also computes the RMS of the fitted surfaces.
% 
% Copyright, University of Iowa 2015
%
%%
%Load data from CSV
% Format <id>,<age>,<hl freq 125Hz>,<hl 250 Hz>,...,<hl 8kHz>,<Class>
data = csvread('../data/example.csv',0);


freq_labels = {'125 Hz','250 Hz','500 Hz','1K Hz','1.5 Hz','2K Hz','3K Hz','4K Hz','6K Hz','8K Hz'};

features = data(:,2:end-1);

class_labels = data(:,end);
class_values = unique(class_labels);
num_classes = numel(unique(class_labels));

[num_instances num_features] = size(features);

%Select class, in this case there is only one class
IDX = find(class_labels == 1);

current_features = features(IDX,:);
current_ids = data(IDX,1);
current_data = data(IDX,:);

locus = 'EXAMPLE';

%%
% Fit and plot surfaces
fit_audioprofile_surface_cv(current_features(:,1:11));