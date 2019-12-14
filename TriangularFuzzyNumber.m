classdef TriangularFuzzyNumber
    % Classes for triangular fuzzy numbers
    % Alpha-cut functions and standard approximation for sum, difference
    % and multiplication
    %
    % Author: Simone Giannico, 2019
    
    properties
        A=0;
        B=0;
        C=0;
    end
    
    methods
        function TFN = TriangularFuzzyNumber(A_value, B_value, C_value)
            if (nargin>0)
                TFN.A = A_value;
                TFN.B = B_value;
                TFN.C = C_value;
            end
        end
        
        function membership_value = membershipFunction(TFN, evaluated_point)
            if(evaluated_point < TFN.A)
                    membership_value = 0;
            elseif(evaluated_point <= TFN.B)
                    membership_value = (evaluated_point - TFN.A)/(TFN.B - TFN.A);
            elseif(evaluated_point <= TFN.C)
                    membership_value = (TFN.C - evaluated_point)/(TFN.C - TFN.B);
            else
                    membership_value = 0;
            end          
        end %end membership function
        
        function alphacut_values = alphacut(TFN, evaluated_cut)
             if(evaluated_cut <= 1 && evaluated_cut >= 0)
                 alpha_L = TFN.A + (evaluated_cut * (TFN.B - TFN.A));
                 alpha_U = TFN.C - (evaluated_cut * (TFN.C - TFN.B));
             end
             alphacut_values = [alpha_L, alpha_U];            
        end %end alphacut
        
        function alphasum = alphaAddTFN(TFN1, TFN2, alpha)
            a1 = alphacut(TFN1, alpha);
            a2 = alphacut(TFN2, alpha);
            alphasum = [a1(1) + a2(1), a1(2) + a2(2)];
        end %end alpha-cut addition function
        
        function alphadifference = alphaSubractTFN(TFN1, TFN2, alpha) %TFN1 (-) TFN2
            a1 = alphacut(TFN1, alpha);
            a2 = alphacut(TFN2, alpha);
            alphadifference = [a1(1) - a2(2), a1(2) - a2(1)];
        end %end alpha-cut subraction function
        
        function product = alphaMultiplyTFN(TFN1, TFN2, alpha) %TFN1 (.) TFN2
            a1 = alphacut(TFN1, alpha);
            a2 = alphacut(TFN2, alpha);
            product = [a1(1) * a2(1), a1(2) * a2(2)];
        end %end alpha-cut multiplication function
        
        function ratio = alphaDivideTFN(TFN1, TFN2, alpha) %TFN1 (:) TFN2
            a1 = alphacut(TFN1, alpha);
            a2 = alphacut(TFN2, alpha);
            ratio = [a1(1) / a2(2), a1(2) / a2(1)];
        end %end alpha-cut division function
        
        function sum = sumTFN(TFN1,TFN2) %TFN1 (+) TFN2
            sum = TriangularFuzzyNumber(TFN1.A + TFN2.A, TFN1.B + TFN2.B, TFN1.C + TFN2.C);
        end %end addition function
        
        function difference = subractTFN(TFN1, TFN2) %TFN1 (-) TFN2
            difference = TriangularFuzzyNumber(TFN1.A - TFN2.C, TFN1.B-TFN2.B, TFN1.C - TFN2.A);
        end %end subraction function
        
        function scalarmultiply = scalarTFN(TFN, k) % k*TFN
            if (k >= 0)
            scalarmultiply = TriangularFuzzyNumber(k*TFN.A, k*TFN.B, k*TFN.C);
            else
            scalarmultiply = TriangularFuzzyNumber(-k*TFN.C, -k*TFN.B, -k*TFN.A);
            end
        end %end scalar multiplication function
        
        function distance = distanceTFN(TFN1, TFN2)
            distance = sqrt(((TFN1.A-TFN2.A)^2+(TFN1.B-TFN2.B)^2+(TFN1.C-TFN2.C)^2)/3.0);
        end %end distance function
        
        function product = stdMultiply(TFN1, TFN2)
            vec= [TFN1.A*TFN2.A, TFN1.A*TFN2.C, TFN1.C*TFN2.A, TFN1.C*TFN2.C];
            product = TriangularFuzzyNumber(min(vec), TFN1.B*TFN2.B, max(vec));
        end
        
    end %end methods
end

