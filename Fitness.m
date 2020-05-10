function y=Fitness(x)
 n=length(x);
 sum=0;
 %============== sphere  [-5.12, 5.12]===================
%  for i=1:n
%     sum=sum+x(1,n).^2;
%  end
%   y=sum;
 
  %============ griewangk's function [-600,600] =================
%   pi=3.1419;
%   sum=0;mul=1;
%   for i=1:n
%     sum=sum+x(i)^2/4000;
%   end
%   for i=1:n
%      s=x(i)/sqrt(i);
%      mul=mul*cos(s*pi/180);
%   end
%   y=sum-mul+1;
  
  %========== Rastrigin  [-5.12, 5.12] ==========
%   sum=0;  pi=3.1419;
%   for i=1:n
%     sum=sum+x(i)^2-10*cos(2*pi*x(i)*(pi/180));
%   end
%   y=10*n+sum;
  
  %=========Step [-5.12, 5.12]==========
%   for i=1:n
%     sum=sum+floor(x(i));
%   end
%    y=6*n+sum;
   
   %========= Ackley [-32.768, 32.768]===========
%    y=20+exp(1)-20*(1-exp(-0.2*sqrt(mean(x.^2))))+exp(1)-exp(mean(cos(2*pi*x))); 
   
   %===========Schewefel Double sum [-100,100]=============
%    sum2=0;
%    for i=1:n
%        sum1=0;
%        for j=1:i
%            sum1=sum1+x(j);
%        end
%        sum2=sum2+sum1^2;
%    end
%    y=sum2;
%    
   % ============== Rosenbrock   [-5, 10] %restricted:[-2.048, 2.048]

%     sum = 0;
%     for ii = 1:n-1
%         xi = x(ii);
%         xnext = x(ii+1);
%         new = 100*(xnext-xi^2)^2 + (xi-1)^2;
%         sum = sum + new;
%     end
% 
%     y = sum;
   
   %=========== Sum Squares Function [-10,10] ==================
%    sum=0;
%     for i=1:size(x,2)
%        sum=sum+(i*(x(i)^2));  
%     end
%     y=sum;
     
    %============= Zakharov Function  [-5, 10] ===============
%     sum1=0;
%     sum2=0;
%     sum3=0;
% 
%     for i=1:n
%    
%         sum1=sum1+(x(i)^2);
%         sum2=sum2+((i*x(i)*0.5));
%         sum3=sum3+((i*x(i)*0.5));
%     end
% 
%    y=sum1+(sum2^2)+(sum3^4);
   
   %============ SCHWEFEL FUNCTION [-500, 500] =================
   sum = 0;
   for i = 1:n
	xi = x(i);
	sum = sum + xi*sin(sqrt(abs(xi)));
   end
   y = 418.9829*n - sum;
%    
       
end