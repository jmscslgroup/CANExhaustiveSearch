% (C) Rahul Bhadani
% myCluster = parcluster('local');
% myCluster.NumWorkers = 8;  % 'Modified' property now TRUE
% saveProfile(myCluster);    % 'local' profile now updated,
% 
% parpool(myCluster, myCluster.NumWorkers);

%folder = "/home/u27/rahulbhadani/ExhaustiveSearch";
folder = "/home/ivory/CyverseData/JmscslgroupData/PandaData/2020_08_20";
fprintf("\n------------------------------------------------------------\n");
file_name = "2020-08-20-13-46-34_2T3Y1RFV8KC014025_CAN_Messages.csv";

fprintf("\nRunning Exhaustive Search for file (with separate bus)%s.\n", file_name);

%data2writefile= "/groups/sprinkjm/ExhaustiveSearch_2020-08-20-13-46-34_bus";
data2writefile = "/home/ivory/CyverseData/JmscslgroupData/PandaData/2020_08_20";
plot = true;

techstreamfolder = "/home/ivory/VersionControl/CANExhaustiveSearch";
%techstreamfolder = "/home/u27/rahulbhadani/ExhaustiveSearch";
file_name2 = "2020-08-20-Drive4_techstream.csv";
fid = fopen(techstreamfolder  + "/" + file_name2);
data = textscan(fid,'%s %f %f %f %f','headerlines', 1, 'delimiter', ',');
fclose(fid);

T_tech = table(data{1}, data{2}, data{3}, data{4}, data{5});
T_tech.Properties.VariableNames = ["Time", "VehicleSpeed", "EngineSpeed", "EngineFuelRate", "VehicleFuelRate"];
T_tech.Time = cell2mat(T_tech.Time);

 T_tech.TimeStamp = zeros(length(T_tech.Time), 1); 
for t  = 1:length(T_tech.Time)
    T_tech.TimeStamp(t) = stamp2sec(T_tech.Time(t,:));
end

% ts_techstream =timeseries( T_tech.VehicleSpeed,  T_tech.TimeStamp);
% ts_techstream.Name = sprintf("Techstream obtain Vehicle Speed");
% 
%  ts_techstream.Time = ts_techstream.Time + ts_CAN.Time(1);
%  
 
%addpath("/home/u27/rahulbhadani/ExhaustiveSearch");
CANExhaustiveSearch_techstream(folder, file_name, data2writefile, T_tech, plot);
fprintf("\n----------\nDone\n---------\n");
