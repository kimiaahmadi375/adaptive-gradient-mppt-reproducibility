
%% ANFIS 

load("AnfisData.mat")
Inputs = P2;
Targets = D2;

fcm_options = genfisOptions("GridPartition","NumMembershipFunctions",7, ...
    'InputMembershipFunctionType','psigmf', ...
    'OutputMembershipFunctionType' ,'constant');

fis=genfis(Inputs,Targets,fcm_options);

anfis_options = anfisOptions('InitialFIS', fis, 'EpochNumber', 10000, ...
    'ErrorGoal', 0, 'OptimizationMethod', 1);

fis = anfis([Inputs Targets],anfis_options);

writeFIS(fis,'AnfisMPPT2.fis')

fuzzy(fis)
