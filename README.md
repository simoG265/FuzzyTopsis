# FuzzyTopsis
Fuzzy Topsis Matlab Code

FuzzyTopsisMCDM.m can be modified to utilize or test the library.

DecisionProblemManager class is the core of this system. It allows to create a fuzzy TOPSIS MCDM problem with multiple experts providing decision matrices. Payoff matrices are based on Linguistic Variables that can either be defined by the user or initialized with default values (VL, L, ML, M, MH, H, VH). The latter linguistic hedges correspond to triangular fuzzy numbers that are managed via the TriangularFuzzyNumber class. This class provides methods for a basic algebra of fuzzy numbers, based on standard approximation for operations on TFNs.
