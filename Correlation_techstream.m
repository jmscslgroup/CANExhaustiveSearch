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


f = figure('visible', 'on');
set(f,'Units','Inches');
% f.Position = [0.8646 2.0625 18.1250 5.6042];
scatter(ts_CAN.Time,ts_CAN.Data(1,:),10, 'MarkerEdgeColor',[3, 4, 94]/255,...
'MarkerFaceColor',[102, 137, 161]/255, 'MarkerFaceAlpha', 0.85);
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
title(ts_CAN.Name, 'FontSize', 20, 'Interpreter','latex');
set(gcf, 'InvertHardCopy', 'off');

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

ts_techstream =timeseries( T_tech.VehicleSpeed,  T_tech.TimeStamp);
ts_techstream.Name = sprintf("Techstream obtain Vehicle Speed");

 ts_techstream.Time = ts_techstream.Time + ts_CAN.Time(1);
 
f = figure('visible', 'on');
set(f,'Units','Inches');
% f.Position = [0.8646 2.0625 18.1250 5.6042];
scatter(ts_techstream.Time,ts_techstream.Data,10, 'MarkerEdgeColor',[3, 4, 94]/255,...
'MarkerFaceColor',[102, 137, 161]/255, 'MarkerFaceAlpha', 0.85);
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
title("Techstream obtain Vehicle Speed", 'FontSize', 20, 'Interpreter','latex');
set(gcf, 'InvertHardCopy', 'off');


% %%
 frequency_1 = 1/mean(diff(ts_CAN.Time));
 frequency_2 = 1/mean(diff(ts_techstream.Time));
 frequency = min(frequency_1, frequency_2);
 
[ts_can_resampled, ts_tech_resampled] = synchronize(ts_CAN, ts_techstream, 'Uniform','Interval', 1.0/frequency, 'InterpMethod','zoh');

 % Calculate correlation Coefficient
 cf= corrcoef(ts_can_resampled.Data(1,:)', ts_tech_resampled.Data);
 cf2 = cf(2);
 
 
 % %
 frequency_1 = 1/mean(diff(ts_CAN.Time));
 frequency_2 = 1/mean(diff(ts_techstream.Time));
 frequency = min(frequency_1, frequency_2);
 
[ts_can_resampled, ts_tech_resampled] = synchronize(ts_CAN, ts_techstream, 'Uniform','Interval', 1.0/frequency, 'InterpMethod','zoh');

 % Calculate correlation Coefficient
 cf= corrcoef(ts_can_resampled.Data(1,:)', ts_tech_resampled.Data);
 cf2 = cf(2);
 cf2
 
 %%
Msg_id = 180;
Signal_Pos =  41;
Signal_Length = 16;
Bus = 2;
T_Crop =  T_CAN(T_CAN.Time< ts_techstream.Time(end), :);
[time, detectedmessages, flag] = detect_signal(T_Crop, Msg_id, Bus, Signal_Pos, Signal_Length);
ts_CAN180 =timeseries(detectedmessages, time);
ts_CAN180.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
 Signal_Length, Bus);
ts_CAN180.Data = ts_CAN180.Data*0.01;
f = figure('visible', 'on');
set(f,'Units','Inches');
% f.Position = [0.8646 2.0625 18.1250 5.6042];
scatter(ts_CAN180.Time,ts_CAN180.Data(1,:),10, 'MarkerEdgeColor',[3, 4, 94]/255,...
'MarkerFaceColor',[102, 137, 161]/255, 'MarkerFaceAlpha', 0.85);
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
title(ts_CAN.Name, 'FontSize', 20, 'Interpreter','latex');
set(gcf, 'InvertHardCopy', 'off');

 frequency_1 = 1/mean(diff(ts_CAN180.Time));
 frequency_2 = 1/mean(diff(ts_techstream.Time));
 frequency = min(frequency_1, frequency_2);
 
[ts_can180_resampled, ts_tech_resampled] = synchronize(ts_CAN180, ts_techstream, 'Uniform','Interval', 1.0/frequency, 'InterpMethod','zoh');

 % Calculate correlation Coefficient
 cf= corrcoef(ts_can180_resampled.Data(1,:)', ts_tech_resampled.Data);
 cf2_speed= cf(2);
 
 %%
 Msg_id = 865;
Signal_Pos =  25;
Signal_Length = 4;
Bus = 0;
 [time, detectedmessages, flag] = detect_signal(T_Crop, Msg_id, Bus, Signal_Pos, Signal_Length);
ts_CAN865 =timeseries(detectedmessages, time);
ts_CAN865.Name = sprintf("Message ID: %d, Signal Pos: %d, Signal Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
 Signal_Length, Bus);
f = figure('visible', 'on');
set(f,'Units','Inches');
% f.Position = [0.8646 2.0625 18.1250 5.6042];
plot(ts_CAN865.Time,ts_CAN865.Data(1,:));
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
title(ts_CAN865.Name, 'FontSize', 20, 'Interpreter','latex');
set(gcf, 'InvertHardCopy', 'off');


%%
 Msg_id = 705;
Signal_Pos =  49;
Signal_Length = 3;
Bus = 0;
 [time, detectedmessages, flag] = detect_signal(T_Crop, Msg_id, Bus, Signal_Pos, Signal_Length);
ts_CAN865 =timeseries(detectedmessages, time);
ts_CAN865.Name = sprintf("Message ID: %d, Signal Pos: %d, Signal Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
 Signal_Length, Bus);
f = figure('visible', 'on');
set(f,'Units','Inches');
% f.Position = [0.8646 2.0625 18.1250 5.6042];
plot(ts_CAN865.Time,ts_CAN865.Data(1,:));
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
title(ts_CAN865.Name, 'FontSize', 20, 'Interpreter','latex');
set(gcf, 'InvertHardCopy', 'off');