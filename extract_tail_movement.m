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


%% code Georges
tic
video = read(v,[1 121200]);
toc
stack=squeeze(video(:,:,1,:));
clear video

 
grey_stack=mean(stack,3);
prof=mean(grey_stack,2);

 
x=[1:size(prof)];
y=nan(size(prof));
y([1:40])=prof([1:40]);
y([1:40])=prof([1:40]);
y([70:end])=prof([70:end]);

idxValid = [x(1:40), x(70:end)];
f=fit(x(idxValid)',y(idxValid),'smoothingspline');

plot(x,prof-f(x));

profiles=squeeze(mean(stack,2))-f(x);
toc
%%
close all
ref = 1;
comp = 1136;
[c, lags] = xcorr(profiles(:,ref), profiles(:,comp));

figure
plot(profiles(:,ref))
hold on
plot(profiles(:,comp))

figure
plot(lags,c)


for k = 2:length(profiles)
    