% Setting parameters
clear all;
clc;
for iter=1:20
 epoch= 1;
% MR= 0.15;      %mixture_ratio, MR - joining seeking mode with tracing mode
% SMP=50;             % seeking memory pool, 50 clones                (larger is better, but need more time)
% SPC=1; % True           # self-position considering
% CDC= 0.8;           % counts of dimension to change                 (larger is better)
% SRD= 0.15;            % seeking range of the selected dimension      (lower is better, but need more time)
% c1=0.4;

MR= 0.2;      %mixture_ratio, MR - joining seeking mode with tracing mode
SMP=5;             % seeking memory pool, 50 clones                (larger is better, but need more time)
SPC=1; % True           # self-position considering
CDC= 0.8;           % counts of dimension to change                 (larger is better)
SRD= 0.2;            % seeking range of the selected dimension      (lower is better, but need more time)
c1=2;
MaxSpeed=60;
% Run model
xl=-5.12; %-500; %-5; %-10; %-2.048; % -5; %-100; %-32.768; %-600; %
xh=5.12; %500; %10; %10; %2.048; %10; %100; %32.768; %600; %

low=xl;
high=xh;
num_pop=100; %number of population
dim=30;
double pop(num_pop,dim);
double fit(num_pop);
double Pi(SMP);
Pi(SMP)=0;

tic;

for i=1 :num_pop
    for j=1:dim
        pop(i,j,1)=rand()*(high-low);
        pop(i,j,2)=0;
        temp(j)=pop(i,j,1);
    end
    % Call Fitness   
    fit(i)=Fitness_func(temp);
end
[pop,fit]=sort_pop(pop,fit);
Bestpop=pop(1,:,:);
fitBestpop=fit(1);

flag = 0;  %False        # False: seeking mode , True: tracing mode
if rand() < MR
     flag = 1;
end
CounterMutations=0;
 while (CounterMutations<epoch && fit(1) ~= 0)
     CounterMutations= CounterMutations+1;                        
     [pop,fit,Bestpop,fitBestpop,Pi]=MainProcess(SMP,SPC,CDC,SRD,pop,fit,Bestpop,fitBestpop,MaxSpeed,flag,low,high,Pi);
     [pop,Bestpop,fitBestpop]=sort_cso(Pi,pop,MR,Bestpop,fitBestpop,fit,SPC);
     if fitBestpop<0.0001
         break;
     end
 end
 disp('results');
 disp('Best Fitness');
 disp(fitBestpop);
 disp(Bestpop(1,:,1));
 disp('epochs');
 disp(CounterMutations);
                            
 
timeElapsed=toc;
 runtime(iter)=timeElapsed;
 bestFit(iter)=fitBestpop;
 counter(iter)=CounterMutations;
 disp('time');
 disp(timeElapsed);
 disp('iteration');
 disp(iter);
 
 
end
disp('Run time for CSO');
disp(runtime);
disp('variance best fitness for 20 run:');
vari=var(bestFit);
disp(vari);
disp('Standard Deviation for 20 run');
std_cso=std(bestFit);
disp(std_cso);
disp('mean run time');
mean_runtime=mean(runtime);
disp(mean_runtime);
disp('mean Epoch number');
mean_epoch=mean(counter);
disp(mean_epoch);
                            
                       


