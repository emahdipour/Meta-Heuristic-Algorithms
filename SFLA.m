clear all;
clc;
for iter=1:20
dim=30;
memeplex=20;
num_pop=100; %number of population

double pop(num_pop,dim);
double fit(num_pop);
double fitmax(iter,2); %dimension 1 is fitmax(1), 2 is fitmax(t)
xl= -500; %-5; %-10; %-2.048; % -5; %-100; %-32.768; %-600; %-5.12;
xh= 500; %10; %10; %2.048; %10; %100; %32.768; %600; %5.12;
high=xh;
low=xl;
tic;
for i=1 :num_pop
    for j=1:dim
        pop(i,j,1)=rand()*(high-low); %*(-1^j);
        temp(j)=pop(i,j,1);
    end
    % Call Fitness   
    fit(i)=Fitness(temp);
end
[pop,fit]=sortSFLACSO(pop,fit);          
GBestFrog(1,:,1)=pop(1,:,1);
fitmax(iter,1)=fit(num_pop);
fitGBest=fit(1);
disp(GBestFrog);
disp(fitGBest);

%==================== SFLA-CSO ===================
iteration=2;
threshold=0.001;
epoch=0;
maxepoch=1000;
double TeX(dim);
group=int32(num_pop/memeplex);
double memp(memeplex,group,5);
double fitmem(memeplex,group);
while(epoch<maxepoch && fitGBest>threshold)
    k=1;
    u=0;
    %==== Set memeplexes =====
    memp(1,1,:,1)=pop(1,:,1);
    fitmem(1,1)=fit(1);
    memp(1,2,:,1)=pop(memeplex,:,1);
    
    fitmem(1,2)=fit(memeplex);
    memp(1,3,:,1)=pop(2*memeplex,:,1);
    
    fitmem(1,3)=fit(2*memeplex);
    memp(1,4,:,1)=pop(3*memeplex,:,1);
   
    fitmem(1,4)=fit(3*memeplex);
    memp(1,5,:,1)=pop(4*memeplex,:,1);
    
    fitmem(1,5)=fit(4*memeplex);
    for i=2:memeplex  
        memp(i,1,:,1)=pop(i,:,1);
        
        fitmem(i,1)=fit(i);
        memp(i,2,:,1)=pop(i+memeplex-1,:,1);
        fitmem(i,2)=fit(i+memeplex-1);
        memp(i,3,:,1)=pop(i+2*memeplex-1,:,1);
        
        fitmem(i,3)=fit(i+2*memeplex-1);
        memp(i,4,:,1)=pop(i+3*memeplex-1,:,1);
        
        fitmem(i,4)=fit(i+3*memeplex-1);
        memp(i,5,:,1)=pop(i+4*memeplex-1,:,1);
        
        fitmem(i,5)=fit(i+4*memeplex-1);
    end    
    %=== Local Search =====   
    while(k<memeplex)
        while(u<iteration)
            [memp,fitmem]=sortSFLACSO(memp,fitmem); 
           % disp('*** memeplex ***');
            %disp(fitmem);
            %=== set best frog and worst frog 
            bestFrog=memp(k,1,:,:);
            fitbestfrog=fitmem(k,1);
            worstFrog=memp(k,group,:,:);
            fitworstFrog=fitmem(k,group);
            %print("BestFrog",bestFrog)
            %print("WorstFrog",worstFrog)
        
            %==== move 1 ====
            
            r1=rand();
            c1=2;
            for i =1:dim
               Si(i) = rand()*bestFrog(:,:,i,1)-worstFrog(:,:,i,1);
               TeX(i)=worstFrog(:,:,i,1)+Si(i);
                    if(TeX(i)>high) 
                        TeX(i)=high;
                    end
                    if(TeX(i)<low)
                        TeX(i)=low;
                    end
                
            end
            FitNew=Fitness(TeX);
            if(FitNew<fitworstFrog)
                for i =1: dim
                    worstFrog(:,:,i,1)=TeX(i);
                end
                fitworstFrog=FitNew;
                disp('move1');
                
            else
                %======== move 2 =======
                           
                for i =1:dim
                    Si(i) = rand()*GBestFrog(1,i,1)-worstFrog(:,:,i,1);
                    TeX(i)=worstFrog(:,:,i,1)+Si(i);
                        if(TeX(i)>high)
                            TeX(i)=high;
                        end
                        if(TeX(i)<low)
                            TeX(i)=low;
                        end
                    
                end
                FitNew=Fitness(TeX);
                if(FitNew<fitworstFrog)
                    for i =1:dim
                        worstFrog(:,:,i,1)=TeX(i);
                    end
                    fitworstFrog=FitNew;
                    disp('move2');
                        
                else
                    %===== move 3 =====
                    for i =1:dim
                        worstFrog(:,:,i,1)=worstFrog(:,:,i,1)*rand()*2;
                        TeX(i)=worstFrog(:,:,i,1);
                        if(TeX(i)>high) 
                            TeX(i)=high;
                        end
                        if(TeX(i)<low)
                            TeX(i)=low;
                        end
                    end
                    
                    FitNew=Fitness(TeX);
                    fitworstFrog=FitNew ;
                    disp('move3');
                end
            end
            memp(k,group,:,:)=worstFrog;
            fitmem(k,group)=fitworstFrog;
            u=u+1;
        end 
        k=k+1 ;
    end
        
    epoch=epoch+1;

    %==== combine memeplexes and create new pop ====
    k=1;
    for i=1:memeplex
        for j=1:group
            pop(k,:,1)=memp(i,j,:,1);
            fit(k)=fitmem(i,j);
            k=k+1;
        end
    end
    [pop,fit]=sortSFLACSO(pop,fit);
    
   % disp('fitness');
   % disp(fit)
    GBestFrog(1,:,1)=pop(1,:,1);
    fitGBest=fit(1);
    disp('GBest: ');
    disp(GBestFrog(1,:,1));
    disp('fitGBest');
    disp(fitGBest);
end   
disp('epoch: ');
disp(epoch);
fitmax(iter,2)=fit(num_pop);
timeElapsed=toc;
 runtime(iter)=timeElapsed;
 bestFit(iter)=fitGBest;
 counter(iter)=epoch;
 disp('time');
 disp(timeElapsed);
 disp('iteration');
 disp(iter);
 disp('convergence speed');
 conv(iter)=log(sqrt(fitmax(iter,2)/fitmax(iter,1)));
 disp(conv(iter));
end
disp('Run time for SFLA');
disp(runtime);
disp('variance best fitness for 20 run:');
vari=var(bestFit);
disp(vari);
disp('Standard Deviation for 20 run');
std_sfla=std(bestFit);
disp(std_sfla);
disp('mean run time');
mean_runtime=mean(runtime);
disp(mean_runtime);
disp('mean Epoch number');
mean_epoch=mean(counter);
disp(mean_epoch);
disp('convergence speed');
mean_conv=mean(conv);
disp(mean_conv);




