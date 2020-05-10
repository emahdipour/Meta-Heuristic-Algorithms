function [pool,fitpool,len]=Mutation(pop,fit,pool,fitpool,len)
  x=length(fit);
  n2=30;
  for i=1:x
      x=rand()*100/100;
      if(x<0.1)
          for j=1:n2
            pool(len,j)=pop(i,j)*rand()*2;
           if (pool(len,j)<(-5.12))
               pool(len,j)=(-5.12);
           end
           if(pool(len,j)>5.12)
               pool(len,j)=5.12;
           end
          end          
           fitpool(len)=Fitness(pool(len,:));
           len=len+1;
      end
  end