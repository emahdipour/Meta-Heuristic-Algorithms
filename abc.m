clc;
clear all;
%% Problem Definition

CostFunction=@(x) Fitness(x);        % Cost Function

nVar=30;             % Number of Decision Variables

VarSize=[1 nVar];   % Decision Variables Matrix Size

xl= -500; %-5; %-10; %-2.048; % -5; %-100; %-32.768; %-600; %-5.12;
xh= 500; %10; %10; %2.048; %10; %100; %32.768; %600; %5.12;

VarMin=xl;       % Decision Variables Lower Bound
VarMax=xh;        % Decision Variables Upper Bound

%% ABC Settings

MaxIt=2000;              % Maximum Number of Iterations

nPop=100;               % Population Size (Colony Size)

nOnlooker=nPop;         % Number of Onlooker Bees

L=round(0.6*nVar*nPop); % Abandonment Limit Parameter (Trial Limit)

a=1;                    % Acceleration Coefficient Upper Bound

%% Initialization
for iter=1:20
    tic;
% Empty Bee Structure
empty_bee.Position=[];
empty_bee.Cost=[];

% Initialize Population Array
pop=repmat(empty_bee,nPop,1);

% Initialize Best Solution Ever Found
BestSol.Cost=inf;

% Create Initial Population
for i=1:nPop
    pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
    pop(i).Cost=CostFunction(pop(i).Position);
    if pop(i).Cost<=BestSol.Cost
        BestSol=pop(i);
    end
end

% Abandonment Counter
C=zeros(nPop,1);

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);

%% ABC Main Loop

for it=1:MaxIt
    
    % Recruited Bees
    for i=1:nPop
        
        % Choose k randomly, not equal to i
        K=[1:i-1 i+1:nPop];
        k=K(randi([1 numel(K)]));
        
        % Define Acceleration Coeff.
        phi=a*unifrnd(-1,+1,VarSize);
        
        % New Bee Position
        newbee.Position=pop(i).Position+phi.*(pop(i).Position-pop(k).Position);
        
        % Evaluation
        newbee.Cost=CostFunction(newbee.Position);
        
        % Comparision
        if newbee.Cost<=pop(i).Cost
            pop(i)=newbee;
        else
            C(i)=C(i)+1;
        end
        
    end
    
    % Calculate Fitness Values and Selection Probabilities
    F=zeros(nPop,1);
    MeanCost = mean([pop.Cost]);
    for i=1:nPop
        F(i) = exp(-pop(i).Cost/MeanCost); % Convert Cost to Fitness
    end
    P=F/sum(F);
    
    % Onlooker Bees
    for m=1:nOnlooker
        
        % Select Source Site
        i=RouletteWheelSelection(P);
        
        % Choose k randomly, not equal to i
        K=[1:i-1 i+1:nPop];
        k=K(randi([1 numel(K)]));
        
        % Define Acceleration Coeff.
        phi=a*unifrnd(-1,+1,VarSize);
        
        % New Bee Position
        newbee.Position=pop(i).Position+phi.*(pop(i).Position-pop(k).Position);
        
        % Evaluation
        newbee.Cost=CostFunction(newbee.Position);
        
        % Comparision
        if newbee.Cost<=pop(i).Cost
            pop(i)=newbee;
        else
            C(i)=C(i)+1;
        end
        
    end
    
    % Scout Bees
    for i=1:nPop
        if C(i)>=L
            pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
            pop(i).Cost=CostFunction(pop(i).Position);
            C(i)=0;
        end
    end
    
    % Update Best Solution Ever Found
    for i=1:nPop
        if pop(i).Cost<=BestSol.Cost
            BestSol=pop(i);
        end
    end
    
    % Store Best Cost Ever Found
    BestCost(it)=BestSol.Cost;
    
    % Display Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    epoch=it;
    if BestCost(it)<0.0001
        break;
    end
end
    
%% Results

%figure;
%plot(BestCost,'LineWidth',2);
% semilogy(BestCost,'LineWidth',2);
% xlabel('Iteration');
% ylabel('Best Cost');
% grid on;

disp('epoch: ');
disp(epoch);

timeElapsed=toc;
 runtime(iter)=timeElapsed;
 bestFit(iter)=min(BestCost);
 counter(iter)=epoch;
 disp('time');
 disp(timeElapsed);
 disp('iteration');
 disp(iter);
 
end
disp('Run time for ABC');
disp(runtime);
disp('variance best fitness for 20 run:');
vari=var(bestFit);
disp(vari);
disp('Standard Deviation for 20 run');
std_ABC=std(bestFit);
disp(std_ABC);
disp('mean run time');
mean_runtime=mean(runtime);
disp(mean_runtime);
disp('mean Epoch number');
mean_epoch=mean(counter);
disp(mean_epoch);