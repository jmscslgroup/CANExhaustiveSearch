% (C) Rahul Bhadani

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

T = table(data{1}, data{2}, data{3}, data{4}, data{5});
T.Properties.VariableNames = ["Time", "Bus", "MessageID", "Message", "MessageLength"];

%%
Msg_id = 898;
Signal_Pos =  33;
Signal_Length = 8;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signal Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
f = figure('visible', 'on');
set(f,'Units','Inches');
% f.Position = [0.8646 2.0625 18.1250 5.6042];
scatter(ts.Time,ts.Data(1,:), 'MarkerEdgeColor',[3, 4, 94]/255,...
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
title(ts.Name, 'FontSize', 20, 'Interpreter','latex');
set(gcf, 'InvertHardCopy', 'off');


[bw,flo,fhi,power] = powerbw(ts.Data(1,:))
figure;
powerbw(ts.Data(1,:));

 v= var(ts.Data(1,:))
 
 k = kurtosis(ts.Data(1,:))
 
  figure;pyulear(ts.Data(1,:),3)
%%
Msg_id = 898;
Signal_Pos =  37;
Signal_Length = 16;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signal Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
f = figure('visible', 'on');
set(f,'Units','Inches');
% f.Position = [0.8646 2.0625 18.1250 5.6042];
scatter(ts.Time,ts.Data(1,:), 'MarkerEdgeColor',[3, 4, 94]/255,...
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
title(ts.Name, 'FontSize', 20, 'Interpreter','latex');
set(gcf, 'InvertHardCopy', 'off');

[bw,flo,fhi,power] = powerbw(ts.Data(1,:))
figure;
powerbw(ts.Data(1,:))

 v= var(ts.Data(1,:))
 
 k = kurtosis(ts.Data(1,:))
 
  figure;pyulear(ts.Data(1,:),3)
  
%%
Msg_id = 180;
Signal_Pos =  41;
Signal_Length = 16;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signal Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
f = figure('visible', 'on');
set(f,'Units','Inches');
% f.Position = [0.8646 2.0625 18.1250 5.6042];
scatter(ts.Time,ts.Data(1,:), 'MarkerEdgeColor',[3, 4, 94]/255,...
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
title(ts.Name, 'FontSize', 20, 'Interpreter','latex');
set(gcf, 'InvertHardCopy', 'off');

[bw,flo,fhi,power] = powerbw(ts.Data(1,:))
figure;
powerbw(ts.Data(1,:));

 v= var(ts.Data(1,:))
 
 k = kurtosis(ts.Data(1,:))
 
 figure;pyulear(ts.Data(1,:),3)
  
%%
Msg_id = 180;
Signal_Pos =  45;
Signal_Length = 16;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signal Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
f = figure('visible', 'on');
set(f,'Units','Inches');
% f.Position = [0.8646 2.0625 18.1250 5.6042];
scatter(ts.Time,ts.Data(1,:), 'MarkerEdgeColor',[3, 4, 94]/255,...
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
title(ts.Name, 'FontSize', 20, 'Interpreter','latex');
set(gcf, 'InvertHardCopy', 'off');

[bw,flo,fhi,power] = powerbw(ts.Data(1,:))
figure;
powerbw(ts.Data(1,:));

v= var(ts.Data(1,:))

k = kurtosis(ts.Data(1,:))

 figure;pyulear(ts.Data(1,:),3)
 
%%
Msg_id = 1056;
Signal_Pos =  52;
Signal_Length = 12;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
 

f = figure('visible', 'on');
set(f,'Units','Inches');
% f.Position = [0.8646 2.0625 18.1250 5.6042];
scatter(ts.Time,ts.Data(1,:), 'MarkerEdgeColor',[3, 4, 94]/255,...
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
title(ts.Name, 'FontSize', 20, 'Interpreter','latex');
set(gcf, 'InvertHardCopy', 'off');

[bw,flo,fhi,power] = powerbw(ts.Data(1,:))
figure;
powerbw(ts.Data(1,:));

v= var(ts.Data(1,:))

k = kurtosis(ts.Data(1,:))

 figure;pyulear(ts.Data(1,:),3)
 
 
%%
Msg_id = 1056;
Signal_Pos =  52;
Signal_Length =11;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
 

f = figure('visible', 'on');
set(f,'Units','Inches');
% f.Position = [0.8646 2.0625 18.1250 5.6042];
scatter(ts.Time,ts.Data(1,:), 'MarkerEdgeColor',[3, 4, 94]/255,...
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
title(ts.Name, 'FontSize', 20, 'Interpreter','latex');
set(gcf, 'InvertHardCopy', 'off');

[bw,flo,fhi,power] = powerbw(ts.Data(1,:))
figure;
powerbw(ts.Data(1,:));

v= var(ts.Data(1,:))

k = kurtosis(ts.Data(1,:))

 figure;pyulear(ts.Data(1,:),3)