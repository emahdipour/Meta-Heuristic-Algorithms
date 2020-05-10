function [pop,fit,Bestpop,fitBestpop]=TracingPop(i, MaxSpeed,SMP,SPC,CDC,SRD,pop,fit,Bestpop,fitBestpop,Xl,Xh)
         Dimension=length(pop(1,:,1));
            double TempArrX(Dimension);
            for j = 1:Dimension
                r1 = rand();
                pop(i, j, 2) = pop(i, j, 2) + (r1 * 2 * (Bestpop(j) - pop(i, j, 1)));
                
                if (pop(i, j, 2) > MaxSpeed)
                    pop(i, j, 2) = MaxSpeed;
                end
                
                pop(i, j, 1) =pop(i, j, 1)+pop(i, j, 1);
                
                if (pop(i, j, 1) < Xl)
                    pop(i, j, 1) = Xl;
                else if (pop(i, j, 1) > Xh)
                    pop(i, j, 1) = Xh;
                TempArrX(j) = pop(i, j, 1);
                    end
                end
            end    
            
            Fitness(i) = Fitness_func(TempArrX);
end