clc;
clear all;
for iter=1:20
n1=100;
n2=30; 
xl= -500; %-5; %-10; %-2.048; % -5; %-100; %-32.768; %-600; %-5.12;
xh=500; %10; %10; %2.048; %10; %100; %32.768; %600; %5.12;
tic;

minRange=xl;
maxRange=xh;
np=2*n1;
pop=minRange+(maxRange-minRange)*rand(n1,n2);
    for i=1:n1        
        fit(i)=Fitness(pop(i,:));
    end
%hold same population for PSO    
pop_pso=pop;
fit_pso=fit;
%*****
maxCounter=5000;
counter=1;
Fit_plot(counter)=fit(1);
sw=0;
%======= Initializing PSO particles =======
particles(1:n1,1:n2)=pop_pso;
fitness(1:n1)=fit_pso;
pBest=particles;
pBestFitness=fitness;
velocity(1:n1,1:n2)=0;
%==== find GBest ====
min=1000000000000;
for i=1:n1
    if(pBestFitness(i)<min)
        min=pBestFitness(i);
        gBestFitness=min;
        gBest(1,:)=pBest(i,:);
    end
end
sw=0;
for i=1:maxCounter
    [gBest,gBestFitness,particles,fitness,pBest,pBestFitness,velocity]=PSO(particles,fitness,pBest,pBestFitness,velocity,gBest,gBestFitness,n1,n2);
    best(i)=gBestFitness;
    if(gBestFitness<0.001 && sw==0)
     best_point_pso=i;
     sw=1;
    end
end
% hold on;
% plot(best,'r');
disp('============== PSO ================');
disp('Gbest Fitness');
disp(gBestFitness);
disp('Gbest Population');
disp(gBest);
if(sw==1)
    epoch=best_point_pso;
    disp(best_point_pso);
else
    disp(maxCounter);  %means can not convergence yet 
    epoch=maxCounter;
end
disp('===================================');
%*******************************************
disp('epoch: ');
disp(epoch);

timeElapsed=toc;
 runtime(iter)=timeElapsed;
 bestFit(iter)=gBestFitness;
 counter(iter)=epoch;
 disp('time');
 disp(timeElapsed);
 disp('iteration');
 disp(iter);
 
end
disp('Run time for PSO');
disp(runtime);
disp('variance best fitness for 20 run:');
vari=var(bestFit);
disp(vari);
disp('Standard Deviation for 20 run');
std_pso=std(bestFit);
disp(std_pso);
disp('mean run time');
mean_runtime=mean(runtime);
disp(mean_runtime);
disp('mean Epoch number');
mean_epoch=mean(counter);
disp(mean_epoch);


