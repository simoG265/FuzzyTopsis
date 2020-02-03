clear;
lingclass = LinguisticClass();
alternatives = {"A1", "A2", "A3"};
criteria = ["c1", "c2", "c3"; ...
            "B",  "B",  "C"]; %last criteria is a cost
% The following lines are in case you want to use crisp weights
    crispweights =  [3,6,4]/10; %crisp weights scaled (must be <1)
    sizecw = size(crispweights,2);
    fuzzyweights(1,sizecw) = TriangularFuzzyNumber(); 
    % Creating crisp weights as a particular case of fuzzy 
    for i=1:size(crispweights,2)
        fuzzyweights(1,i) = TriangularFuzzyNumber(crispweights(1,i),crispweights(1,i),crispweights(1,i));
    end

DM1 = ["M",		"M",		"H";
"VH",		"L",		"H";	
"M",		"M",		"H"];
DM2 = ["H",		"L",		"H";
"VH",		"L",		"L";	
"H",		"H",		"H"];

probManager = DecisionProblemManager(alternatives, criteria, lingclass,DM1, DM2);
solution = solveMCDM(probManager, fuzzyweights);
disp("Closeness coefficients:");
fprintf('Alternative 1: %3.3f \n', solution(1)); 
fprintf('Alternative 2: %3.3f \n', solution(2));
fprintf('Alternative 3: %3.3f \n', solution(3));
