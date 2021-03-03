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

% root = '/home/julie/Sciences/Danionella';
root = '/media/ljp/Julie_Data/Data/Danionella/Calcium_imaging';
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

% load movie
path = fullfile(root,study,date,run_txt,'behavior',folder_name);

tstack = Tiff(fullfile(path,tifname));
[I,J] = size(tstack.read());
K = length(imfinfo(fullfile(path,tifname)));
data = zeros(I,J,K);
data(:,:,1)  = tstack.read();
for n = 2:K
    tstack.nextDirectory()
    data(:,:,n) = tstack.read();
     if mod(n,2000) == 0
        fprintf('opening image %d \n', n)
    end
    
end
