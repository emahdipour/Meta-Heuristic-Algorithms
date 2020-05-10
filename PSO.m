function [gBest,gBestFitness,particles,fitness,pBest,pBestFitness,velocity]=PSO(particles,fitness,pBest,pBestFitness,velocity,gBest,gBestFitness,n1,n2)
%======== Standard PSO Algorithms =========
    c1=2; % rand()*4;
    c2=2; %rand()*4;
    for j=1:n1
    velocity(j,:)=velocity(j,:)+c1*rand()*(pBest(j,:)-particles(j,:))+c2*rand()*(gBest(1,:)-particles(j,:));
    particles(j,:)=particles(j,:)+velocity(j,:);
    fitness(j)=Fitness(particles(j,:));
    %**** update pbest ****
        if(fitness(j)<pBestFitness(j))
            pBestFitness(j)=fitness(j);
            pBest(j,:)=particles(j,:);
        end
    %**** update gbest ****
        if(pBestFitness(j)<gBestFitness)
            gBestFitness=pBestFitness(j);
            gBest(1,:)=pBest(j,:);           
        end
    %**********************   
    end   

end