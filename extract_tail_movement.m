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
% root = '/media/ljp/Julie_Data/Data/Danionella/Calcium_imaging';
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
avi_name = 'trial_1_grey.avi';

% load movie
path = fullfile(root,study,date,run_txt,'behavior',folder_name);

v = VideoReader(fullfile(path,avi_name));

%%
tail_matrix = zeros(v.NumFrames,v.Height);

tic
for k = 1:v.NumFrames
    im = read(v,1);
    m = im(:,:,1);
    tail_matrix(k,:) = sum(m,2)';
    if mod(k,2000) == 0
        fprintf('image %d \n', k)
    end
end
toc