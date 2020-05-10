function [pool,fitpool,len]=Crossover(pop,fit,pool,fitpool,len)
   n=length(fit);   
   for i=1:(n-1)
       x=rand()*100/100;
       if(x<0.7)          
             pool(len,:)=(pop(i,:)+pop(i+1,:))/2;
           if (pool(len,:)<(-5.12))
               pool(len,:)=(-5.12);
           end
           if(pool(len,:)>5.12)
               pool(len,:)=5.12;
           end         
           fitpool(len)=Fitness(pool(len,:));
           len=len+1;
       end
   end