clear;close all;
addpath("/groups/sprinkjm/rahulbhadani/CorrTST/CANExhaustiveSearch/");
myCluster = parcluster('local');
myCluster.NumWorkers = 28;  % 'Modified' property now TRUE
saveProfile(myCluster);    % 'local' profile now updated,
parpool(myCluster, myCluster.NumWorkers);

%parpool(28);
folder = "/groups/sprinkjm/rahulbhadani/CorrTST/CANExhaustiveSearch/datafile";
can = "2021-02-11-19-58-29_2T3Y1RFV8KC014025_CAN_Messages.csv";
tst = "TechStream_2_11_2021_1_48_02_PM.csv";
canfile = sprintf("%s/%s", folder, can);
tstfile = sprintf("%s/%s", folder, tst);
c = CorrTSTCAN(canfile,...
     tstfile,...
    "Gradient of Road Surface",...
    "Vehicle Acceleration",...
    -2970.8215413093567);

c.ExhaustiveFeatureCorrelation(false);

