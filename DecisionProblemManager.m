%Class to manage a fuzzy TOPSIS decision making problem
%Author: Simone Giannico, 2019

classdef DecisionProblemManager
    % For each decision making problem, instatiate a DPM object
    % This will contain the decision matrices and will also receive a
    % Linguistic Class and a Criteria Array
    
    properties
        lingClass;
        criteria; % 2xN matrix containing names of criterias and weights
        alternatives;
        DM;
    end
    
    methods
        function DPM = DecisionProblemManager(alt, crit, linguisticClass, varargin)
            DPM.lingClass = linguisticClass;
            DPM.criteria = crit; %2xM matrix: 1row: name, 2row:benefit/cost
            DPM.alternatives = alt;
            if(nargin>3)
                for i=4:nargin
                    DPM.DM{i-3} = varargin{i-3};
                end
            end
        end
        
        %QUA SISTEMARE
%         function DPM = addDM(DPM, decisionMatrix)
%             if ((size(decisionMatrix,1)== size(DPM.alternatives,2)) && (size(decisionMatrix, 2) == size(DPM.criteria,2)))
%             DPM.DM = cat(1,DPM.DM, decisionMatrix);
%             else
%                 warning("Decision Matrix has wrong dimension");
%             end
%         end
        
        function solution = solveMCDM(DPM, weights)
            dFNIS = zeros(size(DPM.alternatives,2));
            dFPIS = zeros(size(DPM.alternatives,2));
            closenessCoeff = zeros(size(DPM.alternatives,2),1);
            TFN1s = TriangularFuzzyNumber(1,1,1);
            TFN0s = TriangularFuzzyNumber(0,0,0);
            Dtilde(size(DPM.alternatives,2), size(DPM.criteria,2)) = TriangularFuzzyNumber();
            Rtilde(size(DPM.alternatives,2), size(DPM.criteria,2)) = TriangularFuzzyNumber();
            Vtilde(size(DPM.alternatives,2), size(DPM.criteria,2)) = TriangularFuzzyNumber();

            maxC = zeros(1,size(DPM.criteria,2));
            minA = ones(1,size(DPM.criteria,2))*100000; %any big number
            if (size(weights,2)~= size(DPM.criteria,2))
            	warning("Number of weights must match number of criteria");
            else
                for q=1:(size(weights,2))
                    if(weights(1,q).A > 1 ||weights(1,q).B > 1 ||weights(1,q).C > 1 || ...
                            weights(1,q).A < 0 ||weights(1,q).B < 0 ||weights(1,q).C < 0)
                        warning("Weights must have range between 0 and 1");
                    end
                end % end of loop for weight feasibility checking
                % loop to convert and merge the decision matrices
                for r=1:size(DPM.alternatives,2)
                    for c=1:size(DPM.criteria,2)
                        for k=1:size(DPM.DM,2)
                            temp = scalarTFN(l2tfn(DPM.DM{k}(r,c),DPM.lingClass), 1/size(DPM.DM,1));
                            Dtilde(r,c) = sumTFN(Dtilde(r,c), temp);
                        end
                        % updating maxima and minima
                        if(Dtilde(r,c).C > maxC(1,c))
                            maxC(1,c) = Dtilde(r,c).C;
                        end
                        if(Dtilde(r,c).A < minA(1,c))
                            minA(1,c) = Dtilde(r,c).A;
                        end
                    end
                end
                % computation of normalized R matrix
                for r=1:size(DPM.alternatives,2)
                    for c=1:size(DPM.criteria,2)
                        if(strcmp(DPM.criteria(2,c), "B"))
                            Rtilde(r,c) = scalarTFN(Dtilde(r,c), 1.0/maxC(1,c));
                        elseif(strcmp(DPM.criteria(2,c), "C"))
                            Rtilde(r,c) = TriangularFuzzyNumber(minA(1,c)/Dtilde(r,c).C, minA(1,c)/Dtilde(r,c).B,minA(1,c)/Dtilde(r,c).A); 
                        else
                            warning("Wrong definition of benefit or criteria");
                        end
                    end
                end
                % computation of V matrix
                for r=1:size(DPM.alternatives,2)
                    for c=1:size(DPM.criteria,2)
                        Vtilde(r,c) = stdMultiply(Rtilde(r,c), weights(1, c));
                    end
                end
                % calculate distances from FNIS and FPIS
                for r=1:size(DPM.alternatives,2)
                    for c=1:size(DPM.criteria,2)
                        dFPIS(r) = dFPIS(r) + distanceTFN(TFN1s, Vtilde(r,c));
                        dFNIS(r) = dFNIS(r) + distanceTFN(TFN0s, Vtilde(r,c));
                    end
                    closenessCoeff(r) = dFNIS(r)/(dFNIS(r) + dFPIS(r));
                end
                solution = closenessCoeff;
            end
        end %end solve
        
    end
end

