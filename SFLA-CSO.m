clear all;
clc;
dim=5;
memeplex=6;
low=-100; %-5.12
high=100; %5.12
num_pop=30; %number of population

double pop(num_pop,dim);
double fit(num_pop);

for i=1 :num_pop
    for j=1:dim-1
        pop(i,j,1)=rand()*(high-low);
        pop(i,j,2)=0;
        temp(j)=pop(i,j,1);
    end
    % Call Fitness   
    fit(i)=Fitness(temp);
end
[pop,fit]=sortSFLACSO(pop,fit);          
GBestFrog=pop(1);
fitGBest=fit(1);

