clear;
lingclass = LinguisticClass();
alternatives = {"a1", "a2"};
criteria = ["c1", "c2"; "B", "B"];
weights = [TriangularFuzzyNumber(0.3,0.5,0.5), TriangularFuzzyNumber(0.4,0.6,0.6)]; %manca metodo per il "merge" di pesi diversi o per fuzzyfication di pesi reali

DM1 = ["M", "H"; "H", "M"];
DM2 = ["H", "H"; "L", "L"];
disp(strcmp(DM1(1,2), lingclass.levels{2}));
%Create new DecisionProblemManager
probManager = DecisionProblemManager(alternatives, criteria, lingclass,DM1, DM2);

%Add Decision Matrices
%probManager = addDM(probManager, DM1);

% disp(probManager.DM{1});
% disp(strcmp(probManager.DM{1}(1,2), lingclass.levels{2}));



solution = solveMCDM(probManager, weights);
disp("Closeness coefficients:");
fprintf('Alternative 1: %3.3f \n', solution(1)); 
fprintf('Alternative 2: %3.3f \n', solution(2)); 

disp(size(probManager.DM, 2));