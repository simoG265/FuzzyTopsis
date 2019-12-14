classdef LinguisticClass
    %Class to manage fuzzy linguistic variables
    %Author: Simone Giannico, 2019
    properties
        %default values are initialized if the constructor is called with
        %no input arguments
%         levels = {'VL', 'L', 'ML', 'M', 'MH', 'H', 'VH'} %levels passed as a vector of strings 
        levels = {"VL", "L", "ML", "M", "MH", "H", "VH"}
        meaning = [TriangularFuzzyNumber(0,0,0.1),...
            TriangularFuzzyNumber(0.0,0.1,0.3),...
            TriangularFuzzyNumber(0.1,0.3,0.5),...
            TriangularFuzzyNumber(0.3,0.5,0.7),...
            TriangularFuzzyNumber(0.5,0.7,0.9),...
            TriangularFuzzyNumber(0.7,0.9,1.0),...
            TriangularFuzzyNumber(0.9,1.0,1.0)] %meaning of level passed as a vector of triangular fuzzy numbers
    end
    
    methods
        function LC = LinguisticClass(l,m)
            if (nargin>0)
                if(size(l,2) == size(m,2))
                LC.levels = l;
                LC.meaning = m;
                end
            end
        end
        
        function tfn = l2tfn(LV, linguisticClass)
            trigger = 0;
            for i=1:size(linguisticClass.levels,2) %look for the second dimension of levels
                if (strcmp(LV, linguisticClass.levels{i}))
                    tfn = linguisticClass.meaning(i);
                    trigger = 1;
                end
            end
            if (trigger == 0)
                warning('input must be valid value');
            end
        end
    end
end

