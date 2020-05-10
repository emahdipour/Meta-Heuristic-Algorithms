function [pop,fit,Bestpop,fitBestpop,Pi]=MainProcess(SMP,SPC,CDC,SRD,pop,fit,Bestpop,fitBestpop,MaxSpeed,flag,Xl,Xh,Pi)
        
            for i = 1: length(pop)
              if (flag == 1)
                
                   [pop,fit,Bestpop,fitBestpop]= TracingPop(i,MaxSpeed,SMP,SPC,CDC,SRD,pop,fit,Bestpop,fitBestpop,Xl,Xh);
                
                else
                
                   [pop,fit,Pi,Bestpop,fitBestpop]= SeekingPop(i,SMP,SPC,CDC,SRD,pop,fit,Bestpop,fitBestpop,Xl,Xh,Pi);
                   
              end
            end
end