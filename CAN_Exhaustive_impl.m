% (C) Rahul Bhadani
myCluster = parcluster('local');
myCluster.NumWorkers = 8;  % 'Modified' property now TRUE
saveProfile(myCluster);    % 'local' profile now updated,

parpool(myCluster, myCluster.NumWorkers);

folder = "/home/u27/rahulbhadani/ExhaustiveSearch";
fprintf("\n------------------------------------------------------------\n");
file_name = "2020-08-20-13-46-34_2T3Y1RFV8KC014025_CAN_Messages.csv";

fprintf("\nRunning Exhaustive Search for file (with separate bus)%s.\n", file_name);

data2writefile= "/groups/sprinkjm/ExhaustiveSearch_2020-08-20-13-46-34_bus";
plot = true;

addpath("/home/u27/rahulbhadani/ExhaustiveSearch");
CANExhaustiveSearch(folder, file_name, data2writefile, plot);
fprintf("\n----------\nDone\n---------\n");
