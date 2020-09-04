% (C) Rahul Bhadani
clear;
close all;
set(0,'DefaultFigureWindowStyle','docked');
folder = "/home/ivory/CyverseData/JmscslgroupData/PandaData/2020_08_20";
file_name = "2020-08-20-13-46-34_2T3Y1RFV8KC014025_CAN_Messages.csv";

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

T_CAN = table(data{1}, data{2}, data{3}, data{4}, data{5});
T_CAN.Properties.VariableNames = ["Time", "Bus", "MessageID", "Message", "MessageLength"];

Msg_id = 1800;
Signal_Pos =  33;
Signal_Length = 8;
Bus = 2;
[time, detectedmessages, flag] = detect_signal(T_CAN, Msg_id, Bus, Signal_Pos, Signal_Length);
ts_CAN =timeseries(detectedmessages, time);
ts_CAN.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
 Signal_Length, Bus);

%%
techstreamfolder = "/home/ivory/VersionControl/CANExhaustiveSearch";
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

ts_techstream =timeseries( T_tech.EngineFuelRate,  T_tech.TimeStamp);
ts_techstream.Name = sprintf("Techstream obtain Engine Fuel Rate");

 ts_techstream.Time = ts_techstream.Time + ts_CAN.Time(1);
 
 ts_techstream2 =timeseries( T_tech.VehicleFuelRate,  T_tech.TimeStamp);
ts_techstream2.Name = sprintf("Techstream obtain Vehicle  Fuel Rate");

 ts_techstream2.Time = ts_techstream2.Time + ts_CAN.Time(1);
 
f = figure('visible', 'on');
set(f,'Units','Inches');
% f.Position = [0.8646 2.0625 18.1250 5.6042];
hold on;
plot(ts_techstream.Time,ts_techstream.Data,'-o','color', [102, 137, 161]/255, 'MarkerSize',3,'MarkerEdgeColor',[3, 4, 94]/255,...
'MarkerFaceColor',[102, 137, 161]/255);

plot(ts_techstream2.Time,ts_techstream2.Data,'-o','color', [82, 121, 111]/255, 'MarkerSize',3,'MarkerEdgeColor',[82, 121, 111]/255,...
'MarkerFaceColor',[82, 121, 111]/255);


grid on;
grid minor;
ax = gca;
ax.GridColor = [130, 130, 130]/255;
set(gca,'Color', [235, 235, 235]/255);
set(gca,'FontSize',16);
set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');
xlabel('Time (s)','Interpreter','latex');
ylabel({'Signal [unit]'},...
'Interpreter','latex');

set(gcf, 'InvertHardCopy', 'off');
 
T_Crop =  T_CAN(T_CAN.Time< ts_techstream.Time(end), :);

 hold on;
 %%
 Msg_id = 865;
Signal_Pos =  25;
Signal_Length = 11;
Bus = 0;
 [time, detectedmessages, flag] = detect_signal(T_Crop, Msg_id, Bus, Signal_Pos, Signal_Length);
ts_CAN865_25_11 =timeseries(detectedmessages, time);
ts_CAN865_25_11.Name = sprintf("Message ID: %d, Signal Pos: %d, Signal Length: %d, Bus: %d, divided by 256, added 0.26", Msg_id, Signal_Pos, ...
 Signal_Length, Bus);

 Msg_id = 865;
Signal_Pos =  25;
Signal_Length = 9;
Bus = 0;
 [time, detectedmessages, flag] = detect_signal(T_Crop, Msg_id, Bus, Signal_Pos, Signal_Length);
ts_CAN865_25_9 =timeseries(detectedmessages, time);
ts_CAN865_25_9.Name = sprintf("Message ID: %d, Signal Pos: %d, Signal Length: %d, Bus: %d, divided by 64, added 0.26", Msg_id, Signal_Pos, ...
 Signal_Length, Bus);


% f = figure('visible', 'on');
% set(f,'Units','Inches');
% f.Position = [0.8646 2.0625 18.1250 5.6042];
plot(ts_CAN865_25_11.Time,ts_CAN865_25_11.Data(1,:)/256 + 0.26,'-d','color', [84, 11, 14]/255, 'MarkerSize',3,'MarkerEdgeColor',[84, 11, 14]/255,...
'MarkerFaceColor',[181, 101, 118]/255);

plot(ts_CAN865_25_9.Time,ts_CAN865_25_9.Data(1,:)/64 + 0.26,'-d','color', [200, 1, 1]/255, 'MarkerSize',3,'MarkerEdgeColor',[200, 1, 1]/255,...
'MarkerFaceColor',[200, 20, 20]/255);

 Msg_id = 865;
Signal_Pos =  6;
Signal_Length =11;
Bus = 0;
 [time, detectedmessages, flag] = detect_signal(T_Crop, Msg_id, Bus, Signal_Pos, Signal_Length);
ts_CAN865_6_11 =timeseries(detectedmessages, time);
ts_CAN865_6_11.Name = sprintf("Message ID: %d, Signal Pos: %d, Signal Length: %d, Bus: %d, divided by 32, subtracted by 0.4", Msg_id, Signal_Pos, ...
 Signal_Length, Bus);

plot(ts_CAN865_6_11.Time,ts_CAN865_6_11.Data(1,:)/32 - 0.4,'-d','color', [255, 159, 28]/255, 'MarkerSize',2,'MarkerEdgeColor',[255, 159, 28]/255,...
'MarkerFaceColor',[255, 159, 128]/255);

grid on;
grid minor;
ax = gca;
ax.GridColor = [130, 130, 130]/255;
set(gca,'Color', [235, 235, 235]/255);
set(gca,'FontSize',16);
set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');
xlabel('Time (s)','Interpreter','latex');
ylabel({'Signal [unit]'},...
'Interpreter','latex');

legend([ts_techstream.Name, ts_techstream2.Name, ts_CAN865_25_11.Name, ts_CAN865_25_9.Name, ts_CAN865_6_11.Name], 'FontSize', 10, 'Interpreter','latex');

set(gcf, 'InvertHardCopy', 'off');