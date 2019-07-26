%% =========================================
% in this script a synthetic test of the MOD and the K-SVD algorithms 
% is performed. First, a random dictionary with normalized columns is 
% generated, and then a set of data signals, each as a linear 
% combination of 4 dictionary element is created, with noise level of 
% sigma. this set is given as input to the MOD/K-SVD algorithm.
%
% There are two different mode for activating these algorithms - 
% getting a fixed number of atoms in the representation, or until a 
% fixed error is reached in the sparse coding stage. This experiment
% chooses the first of the two.

%% ========== Create the data: Dictionary and signals =========

clear; clc; pack; randn('state',sum(10)); rand('state',sum(10));
param.L=4;   % number of elements in each linear combination
param.K=60; % number of dictionary elements
param.numIteration=50; % number of iterations

% Creating the data to train on 
N=4000; n=30; sigma=0.1;% number of signals, dimension, and noise level

% Creating the dictionary
Dictionary=randn(n,param.K);
Dictionary=Dictionary*diag(1./sqrt(sum(Dictionary.*Dictionary)));
param.TrueDictionary=Dictionary; 
param.InitializationMethod='DataElements'; % initial  by data elements 

% Creating the coefficients
coefs=zeros(param.K,N); coefs(1:param.L,:)=randn(param.L,N);
for i=1:N
    coefs(:,i)=coefs(randperm(param.K),i);
end
data=Dictionary*coefs;

% Adding noise to the data
noise=randn(size(data)); data=data+noise*sigma;
SNR=sum(sum((Dictionary*coefs)'*(Dictionary*coefs)))...
        /sum(sum((data-Dictionary*coefs)'*(data-Dictionary*coefs)));
disp(['SNR=',num2str(SNR)]); 

%% =========================================
% Training the dictionary with a fixed number of atoms (L)

RefError=sqrt(sum(sum((data-Dictionary*coefs).^2))/numel(data));
disp(['The ref. error (with the true dicitonary and coef.) is: ',...
    num2str(RefError)]);
disp('   ');

param.errorFlag=0; % decompose signals with a fixed number of atoms 
param.L=4;   
param.Method='MOD';
[DicMOD1,OutMOD1]=TrainDic(data,param);
disp('    '); 
disp('    '); 
param.Method='KSVD';
[DicKSVD1,OutKSVD1]=TrainDic(data,param);
disp('    '); 
disp('    '); 
param.Method='KSVDFast';
[DicKSVDF1,OutKSVDF1]=TrainDic(data,param);
disp('    '); 
disp('    '); 

%% ==========  Plotting the results  ============== 

figure(1); clf; 
h=plot(0:0.5:param.numIteration,OutMOD1.ratio,'b'); 
set(h,'LineWidth',2); hold on;
h=plot(0:0.5:param.numIteration,OutKSVD1.ratio,'r'); 
set(h,'LineWidth',2);
h=plot(0:0.5:param.numIteration,OutKSVDF1.ratio,'c'); 
set(h,'LineWidth',2); set(gca,'FontSize',14);
h=xlabel('Iteration'); set(h,'FontSize',14);
h=ylabel('Relative # of Recovered Atoms');
set(h,'FontSize',14); 
h=legend({'MOD','K-SVD','KSVD-Fast'}); 
pos=get(h,'Position'); pos(2)=0.2; 
set(h,'Position',pos); grid on;

figure(2); clf; 
h=plot(0:0.5:param.numIteration,OutMOD1.totalErr,'b'); 
set(h,'LineWidth',2); hold on;
h=plot(0:0.5:param.numIteration,OutKSVD1.totalErr,'r'); 
set(h,'LineWidth',2);
h=plot(0:0.5:param.numIteration,OutKSVDF1.totalErr,'c'); 
set(h,'LineWidth',2); set(gca,'FontSize',14);
h=xlabel('Iteration'); set(h,'FontSize',14);
h=ylabel('Average Representation Error');
set(h,'FontSize',14); 
legend({'MOD','K-SVD','KSVD-Fast'}); grid on;

