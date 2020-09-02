% (C) Rahul Bhadani
folder = "/home/ivory/CyverseData/JmscslgroupData/PandaData/2020_08_13";
file_name = "2020-08-13-13-26-45_2T3Y1RFV8KC014025_CAN_Messages.csv";
data2writefile= "/home/ivory/VersionControl/CodeExample/ExhaustiveSearchMat";
makeplot = false;

addpath("/home/ivory/VersionControl/CodeExample");
CANExhaustiveSearch(folder, file_name, data2writefile, makeplot);

fid = fopen(folder  + "/" + file_name);
data = textscan(fid,'%f %d %d %s %f','headerlines', 1, 'delimiter', ',');
fclose(fid);

n_col = length(data);
len_cols = zeros(1, n_col);

for i = 1:n_col
    len_cols(i) = length(data{i});
end

[val_min, index_min] = min(len_cols);

for i = 1:n_col
    if length(data{i}) > val_min
        data{i} = data{i}(1:end - ( length(data{i})  -val_min ));
    end
end

T = table(data{1}, data{2}, data{3}, data{4}, data{5});
T.Properties.VariableNames = ["Time", "Bus", "MessageID", "Message", "MessageLength"];


ts_speed = get_speed(T);
plot(ts_speed);