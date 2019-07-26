%% =========================================
% In this script a test of the MOD and the K-SVD algorithms is 
% performed on image patches. 
%

% Note: This code uses the Batch-OMP for speeding up the training 

%% =========================================
% Gathering the data to train on from an image

clear; clc; pack;

bb=8; % block size
K=121; % number of atoms in the dictionary

[IMin0,pp]=imread('barbara.png');
IMin0=im2double(IMin0);

figure(1); clf; 
imagesc(IMin0); axis image; axis off; colormap(gray(256));

if (length(size(IMin0))>2), IMin0 = rgb2gray(IMin0); end
if (max(IMin0(:))<2), IMin0 = IMin0*255; end

blkMatrix=im2col(IMin0,[bb,bb],'sliding');
TrainData=blkMatrix(:,1:10:end); % extract 1/10 of the patches
% TrainData=(eye(bb^2)-ones(bb^2)/bb^2)*TrainData; % removing the mean


%% =========================================
% Initial dictionary: The 2D (redundant) DCT

DCT=zeros(bb,sqrt(K));
for k=0:1:sqrt(K)-1
    V=cos([0:1:bb-1]'*k*pi/sqrt(K));
    if k>0, V=V-mean(V); end
    DCT(:,k+1)=V/norm(V);
end
DCT=kron(DCT,DCT);
I1=DispDict(DCT, sqrt(K),sqrt(K),bb,bb,0);
figure(1); clf; 
imagesc(I1); colormap(gray(256)); axis image; axis off; 

%% =========================================
% Training a dictionary

param.errorFlag=0;
param.K=K; 
param.numIteration=50; 
param.InitializationMethod='GivenMatrix'; 
param.TrueDictionary=0;
param.Method='MOD';
param.L=4;   
param.initialDictionary=DCT;
[DicMOD,OutMOD]=TrainDic_Fast(TrainData,param);
I2=DispDict(DicMOD,sqrt(K),sqrt(K),bb,bb,0);
disp('   ');
param.Method='KSVD';
[DicKSVD,OutKSVD]=TrainDic_Fast(TrainData,param);
I3=DispDict(DicKSVD,sqrt(K),sqrt(K),bb,bb,0);
disp('   ');
param.Method='KSVDFast';
[DicKSVDF,OutKSVDF]=TrainDic_Fast(TrainData,param);
I4=DispDict(DicKSVDF,sqrt(K),sqrt(K),bb,bb,0);
disp('   ');

h=figure(2); clf; set(h,'Position',[50 200 330 250]); 
imagesc(I2); colormap(gray(256)); axis image; axis off; 
h=figure(3); clf; set(h,'Position',[400 200 330 250]); 
imagesc(I3); colormap(gray(256)); axis image; axis off; 
h=figure(4); clf; set(h,'Position',[750 200 330 250]);
imagesc(I4); colormap(gray(256)); axis image; axis off; 

%% =========================================
% Presenting the error results as function of the iteration

figure(1); clf; 
h=plot(0:0.5:param.numIteration,OutMOD.totalErr,'b'); 
set(h,'LineWidth',2);
hold on;
h=plot(0:0.5:param.numIteration,OutKSVD.totalErr,'r'); 
set(h,'LineWidth',2);
h=plot(0:0.5:param.numIteration,OutKSVDF.totalErr,'c'); 
set(h,'LineWidth',2);
set(gca,'FontSize',14);
h=xlabel('Iteration');
set(h,'FontSize',14);
h=ylabel('Average Representation Error');
set(h,'FontSize',14);
legend({'MOD','K-SVD','Fast-K-SVD'}); 

figure(2); clf; 
[r,c,~]=size(I1); 
imagesc([I1, ones(r,5,3),I2; ones(5,2*c+5,3); I3, ones(r,5,3), I4]); 
axis off; axis image;

%% =========================================
% Checking the representation error for the complete set of patches

param.errorFlag=0;
param.K=K; 
param.numIteration=0; 
param.InitializationMethod='GivenMatrix'; 
param.TrueDictionary=0;
param.Method='MOD';
param.L=4;   
param.initialDictionary=DCT;
TrainDic_Fast(blkMatrix,param);
param.initialDictionary=DicMOD;
TrainDic_Fast(blkMatrix,param);
param.initialDictionary=DicKSVD;
TrainDic_Fast(blkMatrix,param);
param.initialDictionary=DicKSVDF;
TrainDic_Fast(blkMatrix,param);

%% =========================================
% Checking the distance between the MOD and the K-SVD dictionaries

original=DicMOD;
new=DicKSVD; 
T1=0.01;
catchCounter=0;
distances=abs(original'*new);
for i=1:1:size(original,2)
    minValue=1-max(distances(i,:));
    catchCounter=catchCounter+(minValue<T1);
end
disp('    '); 
disp([num2str(100*catchCounter/size(original,2)),'%']);

