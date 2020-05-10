clc;
clear all;
for iteration=1:20
n1=100;
n2=30;
double pop(n1,n2);
double fit(n1);
int32 visited(n1);
double f(n1,n1);
temp=4;
maxepoch=5000;
epoch=1;
xl=-5.12; %-500; %-5; %-10; %-2.048; % -5; %-100; %-32.768; %-600; %
xh=5.12; %500; %10; %10; %2.048; %10; %100; %32.768; %600; %

tic;  %start time
 pop=rand(n1,n2)*xh;  
 
 
    for i=1:n1
        for j=1:n2
           pop(i,j)=pop(i,j)*((-1).^j);
           
        end
        fit(i)=Fitness(pop(i,:));
        
    end
    [pop,fit]=sortSA(pop,fit);
    gbest=pop(1,:);
    gbestfit=fit(1);
   while(epoch<maxepoch && temp>0)
       for i=1:n1
           [pop(i,:),fit(i),gbest,gbestfit]=Simulatedannealing(pop(i,:),temp,gbest,gbestfit,xl,xh);
       end
       
       [pop,fit]=sortSA(pop,fit);
       if(fit(1)<0.001)
           disp('gbest');
           disp(gbest);
           disp('gbest fit');
           disp(gbestfit);
           disp('epoch');
           disp(epoch);
           break;
       end
       epoch=epoch+1;
       temp=temp-0.001;
   end
   disp('gbest');
   disp(gbest);
   disp('gbest fit');
   disp(gbestfit);
   disp('epoch');
   disp(epoch);
   
 timeElapsed=toc;
 runtime(iteration)=timeElapsed;
 bestFit(iteration)=gbestfit;
 counter(iteration)=epoch;
 disp('temp');
 disp(temp);
 disp('time');
 disp(timeElapsed);
end
disp('Run time for SA');
disp(runtime);
disp('variance best fitness for 20 run:');
vari=var(bestFit);
disp(vari);
disp('Standard Deviation for 20 run');
std_sa=std(bestFit);
disp(std_sa);
disp('mean run time');
mean_runtime=mean(runtime);
disp(mean_runtime);
disp('mean Epoch number');
mean_epoch=mean(counter);
disp(mean_epoch);


   