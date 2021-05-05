%% === To extract timestamp from behavior recording ===

% === Description ===
% 

% === Input ===
% 

% === Output ===
% 


%% ===== Main Code ===============================================
clear;
close all;
clc;

% root = '/home/julie/Sciences/Danionella';
% root = '/media/ljp/Julie_Data/Data/Danionella/Calcium_imaging';
% root = '/run/media/julie/Julie_Data/Data/Danionella/Calcium_imaging';
% root = '/home/julie/Sciences';
% root = '/home/ljp/Sciences';
root = '/media/ljp/Data2/Data/Danionella/Calcium_imaging';
study = '1_photon';
date = '2021-03-02';
run = 1;
d = floor(run/10);
u = floor(run - d*10);
run_txt = ['Run ' num2str(d) num2str(u)];

% movie's name
path = fullfile(root,study,date,run_txt,'behavior');
a = dir(path);
behavior_video = a(3).name;

% load
tic
v = VideoReader(fullfile(path,behavior_video));
toc

%% ===
fpsTh = 100;
durationVideo = 20; % in min
nbFrameTh = round(fpsTh * durationVideo * 60);

tic
% video = read(v,[1 nbFrameTh]);
nb_frame = 1000;
video = read(v,[1 nb_frame]);
toc
stack=squeeze(video(:,:,1,:));
pixelstmp = stack(1,1:4,:);
clear video

%% ---
timestmpVid = nan(1,nb_frame);
for t = 1:nb_frame
    timestmpVid(t) = fast_extract_timestamp(pixelstmp(:,:,t));
end
plot(timestmpVid)
