clear;close all;
addpath("/home/ivory/VersionControl/CANExhaustiveSearch/");

folder = "/home/ivory/CyverseData/JmscslgroupData/PandaData/2021_02_11";
can = "2021-02-11-19-58-29_2T3Y1RFV8KC014025_CAN_Messages.csv";
tst = "TechStream_2_11_2021_12:55:10_PM.csv";
canfile = sprintf("%s/%s", folder, can);
tstfile = sprintf("%s/%s", folder, tst);
c = CorrTSTCAN(canfile,...
     tstfile,...
    "Gradient of Road Surface");

c.ExhaustiveFeatureCorrelation(true);

%%
T1 = c.CANData;
T2 = c.TSTData;

t1time = T1.Time;
t2time = T2.("Sample Time");
w =  zeros(1, length(t1time) )+ 1;
x =  zeros(1, length(t2time) )+ 2;
figure;
hold on;
plot(t1time,w);
plot(t2time,x);
legend('T1', 'T2');
ylim([0,5]);
