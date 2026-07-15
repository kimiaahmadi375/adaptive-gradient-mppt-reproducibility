
%% TunedFis 

load("AnfisData.mat")
Inputs =  P2;
Targets = D2;

% 'trimf' 'psigmf' 'constant' 'linear'

fcm_options = genfisOptions("GridPartition","NumMembershipFunctions",7, ...
    'InputMembershipFunctionType','trimf', ...
    'OutputMembershipFunctionType' ,'linear');

fis=genfis(Inputs,Targets,fcm_options);

[in,out,rule] = getTunableSettings(fis);

tunefis_options = tunefisOptions("Method", "particleswarm"); 
% patternsearch particleswarm anfis
tunefis_options.OptimizationType = 'learning'; % tuning
tunefis_options.MethodOptions.MaxIterations = 1000;
tunefis_options.MethodOptions.FunctionTolerance = 1e-50;

fis = tunefis(fis,[in;out],Inputs,Targets,tunefis_options);

writeFIS(fis,'TunedFuzzyMPPT2.fis')

% fuzzy(fis)
% fuzzyLogicDesigner(fis)