clc;
clear;
for iter=1:20
n1=100;
n2=30;
np=200;
double pop(n1,n2);
double fit(n);
double pool(np,n2);
double fitpool(np);
counter=0;
double Fit_plot(500);
xl=-500; %-5; %-10; %-2.048; % -5; %-100; %-32.768; %-600; %-5.12;
xh= 500; %10; %10; %2.048; %10; %100; %32.768; %600; %5.12;

tic;
len=0;
 pop=rand(n1,n2)*xh;
    for i=1:n1
        for j=1:n2
           pop(i,j)=pop(i,j)*((-1).^j);
        end
        fit(i)=Fitness(pop(i,:));
      end
%Sort
[pop,fit]=sortGA(pop,fit);
counter=1;
Fit_plot(counter)=fit(1);
while(counter<5000)
    counter=counter+1;
    %Selection
    [pool(1:25,:),fitpool(1:25)]=Selection(pop,fit);
    len=26;
    %Crossover
    [pool,fitpool,len]=Crossover(pop,fit,pool,fitpool,len);

    %Mutation
    [pool,fitpool,len]=Mutation(pop,fit,pool,fitpool,len);
    
    %sort pool
    [pool,fitpool]=sortpoolGA(pool,fitpool);
    if(fitpool(1)< 0.001)
        disp('pool:');        
        disp(pool(1,:));
        fitGBest=fitpool(1);
        disp('Fitpool:');
        disp(fitpool(1));
        disp('counter');
        disp(counter);
        break;
    end
     fitGBest=fitpool(1);
    Fit_plot(counter)=fitpool(1);
    pop(1:n1,:)=pool(1:n1,:);
    fit(1:n1)=fitpool(1:n1);
end
%x=linspace(1,counter,counter);
%y=Fit_plot(x);
%plot(x,y,'b');
%title('Convergence Speed Diagram');
%xlabel('Iteration');
%ylabel('Cost');
disp('epoch: ');
disp(counter);
timeElapsed=toc;
 runtime(iter)=timeElapsed;
 bestFit(iter)=fitGBest;
 epoch(iter)=counter;
 disp('time');
 disp(timeElapsed);
 disp('iteration');
 disp(iter);
 
end
disp('Run time for GA');
disp(runtime);
disp('variance best fitness for 20 run:');
vari=var(bestFit);
disp(vari);
disp('Standard Deviation for 20 run');
std_ga=std(bestFit);
disp(std_ga);
disp('mean run time');
mean_runtime=mean(runtime);
disp(mean_runtime);
disp('mean Epoch number');
mean_epoch=mean(epoch);
disp(mean_epoch);
