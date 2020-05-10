% Setting parameters
problem_size= 100;
domain_range= [-100, 100];
print_train= 1;
objective_func=C30;


epoch= 500;
pop_size= 100;
mixture_ratio= 0.15;      % MR - joining seeking mode with tracing mode
smp=50;             % seeking memory pool, 50 clones                (larger is better, but need more time)
spc=1; % True           # self-position considering
cdc= 0.8;           % counts of dimension to change                 (larger is better)
srd= 0.15;            % seeking range of the selected dimension      (lower is better, but need more time)
c1=0.4;
w_minmax= [0.4, 0.9];     %[0-1] -> [0.4-0.9]      Weight of bird

selected_strategy= 0;  % 0: roulette wheel, 1: random, 2: best fitness, 3: tournament


% Run model
low=-5.12;  %-100
high=5.12;  %100
num_pop=30; %number of population
double pop(num_pop,dim);
double fit(num_pop);


for i=1 :num_pop
    for j=1:dim
        pop(i,j,1)=rand()*(high-low);
        pop(i,j,2)=0;
        temp(j)=pop(i,j,1);
    end
    % Call Fitness   
    fit(i)=Fitness(temp);
end
flag = 0;  %False        # False: seeking mode , True: tracing mode
if rand() < mixture_ratio
     flag = 1;


md = BaseCSO(root_algo_paras=root_paras, cso_paras=cso_paras)
md._train__()

