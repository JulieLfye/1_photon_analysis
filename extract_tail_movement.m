%% === To extract tail motion to determine when the DT is swimming ===

% === Description ===
% 

% === Input ===
% You need a cropped movie from the behavior recorded during calcium
% activity acquisition

% === Output ===
% 


%% ===== Main Code ===============================================
clear;
close all;
clc;

root = '/home/julie/Sciences/Danionella';
% root = '/run/media/julie/Julie_Data/Data/Danionella/Calcium_imaging';
% root = '/home/julie/Sciences';
% root = '/home/ljp/Sciences';
study = '1_photon';
date = '2021-02-19';
run = 4;
d = floor(run/10);
u = floor(run - d*10);
run_txt = ['Run ' num2str(d) num2str(u)];

%% === Input ===

% name of the movie
folder_name = 'tail_cropped';
tifname = 'trial_1_grey.tif';

% load 1 frame
path = fullfile(root,study,date,run_txt,'behavior',folder_name);

infoTiff = imfinfo(fullfile(path,tifname));


% prepare memory
im = zeros(infoTiff(1).Height,infoTiff(1).Width,length(infoTiff));

% load all movie frames
tic
for k = 1:length(infoTiff)
    im(:,:,k) = imread(fullfile(path,tifname),'Index',k);
    if mod(k,2000) == 0
        fprintf('opening image %d \n', k)
    end
end
toc