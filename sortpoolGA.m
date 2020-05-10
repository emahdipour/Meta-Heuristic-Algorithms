function [pool,fitpool]=sortpoolGA(x,y)
   n=length(y);
   n2=30;
   for i=1:n
       for j=1:(n-(i+1))
           if(y(j)>y(j+1))
               temp=y(j);
               y(j)=y(j+1);
               y(j+1)=temp;
               for k=1:n2
                  temp=x(j,k);
                  x(j,k)=x(j+1,k);
                  x(j+1,k)=temp;
               end
           end
       end
   end
   pool=x;
   fitpool=y;