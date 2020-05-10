function [Population,Bestpop,fitBestpop]=sort_cso(P,Population,MR,Bestpop,fitBestpop,fit,SPCValue)


%false=0, true=1
leng=1;

            Dimension=length(Population(1,:,1));
            TracingMode = int32(P(1) * MR);
            int32 Flag(length(Population));
            Flag(1:length(Population)) = 0;
            SeekingMode = P(1) - TracingMode;
            for i=1: TracingMode
                j =randi([1, length(P)]);
                if (Flag(j) ~= 1)
                    Flag(j) = 1;
                else
                    i=i-1;
                end
            end
            
            for i =1: length(Population)
                j = i + 1;
                while (j < length(Population))
                
                    if (fit(i) < fit(j))
                        j=j+1;
                    else
                    
                        Temp = fit(j);
                        fit(j) = fit(i);
                        fit(i) = Temp;

                        TempBool = Flag(j);
                        Flag(j) = Flag(i);
                        Flag(i) = TempBool;

                        for k = 1:Dimension
                        
                            Temp = Population(j, k, 1);
                            Population(j, k, 1) = Population(i, k, 1);
                            Population(i, k, 1) = Temp;

                            Temp = Population(j, k, 2);
                            Population(j, k, 2) = Population(i, k, 2);
                            Population(i, k, 2) = Temp;
                         end
                        j=j+1;
                        end
                    end
                end
            
            if (fitBestpop > fit(1))
            
                %BestPop = new double[Dimension];
                for i = 1: Dimension
                    Bestpop(i) = Population(1, i, 1);
                end

                FSMin = fit(1);
                
                BestFitness(leng)=FSMin;
                leng=leng+1;
            end
            FSMax = fit(length(Population) - 1);
            %//?????? ???? ??
            intTemp = int32(P(1) * SPCValue);
            for i = 1: intTemp
                SPC(i) = 1;  %true
            end
end
