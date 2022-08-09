clear;close all;
addpath("/home/u27/rahulbhadani/CANExhaustiveSearch");
myCluster = parcluster('local');
myCluster.NumWorkers = 28;  % 'Modified' property now TRUE
saveProfile(myCluster);    % 'local' profile now updated,
parpool(myCluster, myCluster.NumWorkers);

%parpool(28);
folder = "Data";
can = "2020-10-01-11-01-37_2T3Y1RFV8KC014025_CAN_Messages.csv";
base = "base_speed_signal.csv"; % base signal file
canfile = sprintf("%s/%s", folder, can);
basefile = sprintf("%s/%s", folder, base);

B = readtable(basefile,'PreserveVariableNames',true);

c = CorrSignal(canfile,...
     B,...
    "Time",...
    "Time",...
    "Message", ...
    "./");

c.ExhaustiveFeatureCorrelation(true, [180]);

