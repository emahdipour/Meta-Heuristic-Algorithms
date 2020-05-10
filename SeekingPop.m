function [pop,fit,Pi,Bestpop,fitBestpop]=SeekingPop(i,SMP,SPC,CDC,SRD,pop,fit,Bestpop,fitBestpop,Xl,Xh,Pi)
          double PopulatioSMP(SMP, Dimension, 2);
          double FitnessSMP(SMP);
          %double Pi(SMP);
          FSMax=Xh;
          FSMin=Xl;
           Dimension=length(pop(1,:,1));
            for j = 1:SMP
            
                for k = 1: Dimension
                    PopulatioSMP(j, k, 1) = pop(i, k, 1);
                    PopulatioSMP(j, k, 2) = pop(i, k, 2);
                end
             end

           
            intTemp = int32(Dimension * CDC);
            StartSmp = 0;
            if (SPC == 1)
                StartSmp = 1;
                FitnessSMP(1) = fit(i);
            end

            for t = StartSmp:SMP
                for u = 1: intTemp
                    Random = randi([1, Dimension]);
                    if (randi([1, 2]) == 1)
                   
                        PopulatioSMP(t, Random, 1) =PopulatioSMP(t, Random, 1)+PopulatioSMP(t, Random, 1) * SRD;
                        if (PopulatioSMP(t, Random, 1) < Xl)
                            PopulatioSMP(t, Random, 1) = Xl;
                        else if (PopulatioSMP(t, Random, 1) > Xh)
                            PopulatioSMP(t, Random, 1) = Xh;
                            end
                        end
                    else
                        PopulatioSMP(t, Random, 1) =PopulatioSMP(t, Random, 1)- PopulatioSMP(t, Random, 1) * SRD;
                        if (PopulatioSMP(t, Random, 1) < Xl)
                            PopulatioSMP(t, Random, 1) = Xl;
                        else if (PopulatioSMP(t, Random, 1)> Xh)
                            PopulatioSMP(t, Random, 1) = Xh;
                            end
                        end
                    end
                end
            end

            
            for t = StartSmp: SMP
                double TempArrX(Dimension);
                for U = 1: Dimension
                    TempArrX(U) = PopulatioSMP(t, U, 1);
                end
                FitnessSMP(t) = Fitness_func(TempArrX);
            end

            
            checkFitness = 0;
            for item=1:length(FitnessSMP)-1
               if (FitnessSMP(item) ~= FitnessSMP(item + 1))              
                    checkFitness = 1;
               end
            end
            if (checkFitness == 1)
                for T = 1: SMP
                    x = FitnessSMP(T) - FSMax;
                    if (x < 0)
                        x =x* -1;
                    end
                    Pi(T) = x / (FSMax - FSMin);
                end
            
            else
           
                for S = 1:Dimension
                    pop(i, S, 1) = PopulatioSMP(1, S, 1);
                end
                fit(i) = FitnessSMP(1);
                return;
            end

            
            index = 1;
            for s = 1: length(Pi)
               if (Pi(s)> Pi(index))
                    index = s;
               end
            end

           
            for S = 1:Dimension
                pop(i, S, 1) = PopulatioSMP(index, S, 1);
            end
            fit(i) = FitnessSMP(index);

end