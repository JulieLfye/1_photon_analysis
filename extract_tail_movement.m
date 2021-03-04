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
pks = zeros(v.NumFrames,1);
locs = pks;

tic
% for k = 1:v.NumFrames
for k = 1:1501
    im = read(v,k);
    m = sum(im(:,:,1),2)';
    tail_matrix(k,:) = m/max(m);
    [p,l] = findpeaks(tail_matrix(k,:),'NPeaks',1,'MinPeakProminence',0.05);
    if isempty(p) == 0
        pks(k) = p;
        locs(k) = l;
    else
        pks(k) = nan;
        locs(k) = nan;
    end
    
    if mod(k,2000) == 0
        fprintf('image %d \n', k)
    end
end
toc

% pb im 1200, 1136

locs(1502:end,:) = [];
% time = 0:0.01:15;
plot(locs)

return

%% test correlation
close

tail_1 = read(v,1);
tail_1 = tail_1(:,:,1);
tail_1 = sum(tail_1,2);
tail_1 = tail_1/max(tail_1);

tail_2 = read(v,32802);
tail_2 = tail_2(:,:,1);
tail_2 = sum(tail_2,2);
tail_2 = tail_2/max(tail_2);

[xcc, lags] = xcorr(tail_1,tail_2, 'normalized');
w = conv(tail_1, tail_2);
[argvalue, argmax] = max(w);
dtw(tail_1, tail_2);
figure
plot(w);
figure
plot(tail_1);
hold on
plot(tail_2);
figure
plot(lags,xcc)

%% test peak
close all

[pks,locs] = findpeaks(tail_1,'NPeaks',1,'MinPeakProminence',0.05);
[pksw,locsw] = findpeaks(tail_1,'Npeaks',1,'MinPeakWidth',5);
plot(tail_1)
hold on
plot(locs,pks,'ro')
plot(locsw,pksw,'ko')