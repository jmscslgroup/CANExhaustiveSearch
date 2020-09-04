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

T = table(data{1}, data{2}, data{3}, data{4}, data{5});
T.Properties.VariableNames = ["Time", "Bus", "MessageID", "Message", "MessageLength"];

%%
%%
Msg_id = 1553;
Signal_Pos =  9;
Signal_Length =2;
Bus = 2;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 1595;
Signal_Pos =  51;
Signal_Length =7;
Bus = 2;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 552;
Signal_Pos =  1;
Signal_Length =12;
Bus = 2;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');
plot(ts, 'r.');

%%
Msg_id = 186;
Signal_Pos =  1;
Signal_Length =16;
Bus = 2;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');
%%
Msg_id = 180;
Signal_Pos =  41;
Signal_Length =16;
Bus = 2;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');


%%
Msg_id = 865;
Signal_Pos = 41;
Signal_Length = 16;
Bus = 0;

 [time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts_865 =timeseries(detectedmessages, time);
 ts_865.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
plot(ts_865, 'r.');

%%
Msg_id = 865;
Signal_Pos = 50;
Signal_Length = 7;
Bus = 0;
 [time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts_865 =timeseries(detectedmessages, time);
 ts_865.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
plot(ts_865, 'r.');

%%
Msg_id = 976;
Signal_Pos = 1;
Signal_Length = 7;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts_976 =timeseries(detectedmessages, time);
 ts_976.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
plot(ts_976, 'r.');

%%
Msg_id = 976;
Signal_Pos = 2;
Signal_Length = 6;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts_976 =timeseries(detectedmessages, time);
 ts_976.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
plot(ts_976, 'r.');

%%
Msg_id = 976;
Signal_Pos = 1;
Signal_Length =7;
Bus = 1;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts_976 =timeseries(detectedmessages, time);
 ts_976.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
plot(ts_976, 'r.');

%%
Msg_id = 1552;
Signal_Pos = 10;
Signal_Length = 15;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 1552;
Signal_Pos = 18;
Signal_Length = 7;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 1552;
Signal_Pos = 18;
Signal_Length = 7;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 353;
Signal_Pos = 1;
Signal_Length = 32;
Bus = 1;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 353;
Signal_Pos =  10;
Signal_Length = 14;
Bus = 1;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 1800;
Signal_Pos =  34;
Signal_Length = 16;
Bus = 2;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 1800;
Signal_Pos =  34;
Signal_Length = 16;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 464;
Signal_Pos =  32;
Signal_Length = 32;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 464;
Signal_Pos =  38;
Signal_Length = 16;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');


%%
Msg_id = 464;
Signal_Pos =  38;
Signal_Length = 3;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 1042;
Signal_Pos =  6;
Signal_Length = 1;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 1042;
Signal_Pos =  6;
Signal_Length = 2;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 1161;
Signal_Pos =  22;
Signal_Length = 3;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 877;
Signal_Pos =  20;
Signal_Length = 1;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 1775;
Signal_Pos =  18;
Signal_Length = 1;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 1557;
Signal_Pos =  9;
Signal_Length = 1;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 1020;
Signal_Pos =  20;
Signal_Length = 2;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 1020;
Signal_Pos =  18;
Signal_Length = 16;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 1020;
Signal_Pos =  48;
Signal_Length = 14;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 1020;
Signal_Pos =  19;
Signal_Length = 14;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 1056;
Signal_Pos =  52;
Signal_Length = 12;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 1086;
Signal_Pos =  44;
Signal_Length = 8;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 1132;
Signal_Pos =  12;
Signal_Length = 1;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');


%%
Msg_id = 871;
Signal_Pos =  7;
Signal_Length = 3;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 871;
Signal_Pos =  7;
Signal_Length = 3;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 452;
Signal_Pos =  4;
Signal_Length = 3;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 830;
Signal_Pos =  24;
Signal_Length = 1;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 830;
Signal_Pos =  24;
Signal_Length = 5;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 870;
Signal_Pos =  17;
Signal_Length =12;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 870;
Signal_Pos =  17;
Signal_Length =12;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 877;
Signal_Pos = 8;
Signal_Length =14;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');


%%
Msg_id = 896;
Signal_Pos = 50;
Signal_Length =7;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 401;
Signal_Pos =  42;
Signal_Length =2;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 933;
Signal_Pos =  48;
Signal_Length =16;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 944;
Signal_Pos =  9;
Signal_Length =7;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 705;
Signal_Pos =  12;
Signal_Length =2;
Bus = 0;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 705;
Signal_Pos =  42;
Signal_Length =15;
Bus = 2;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');


%%
Msg_id = 1042;
Signal_Pos =  5;
Signal_Length =1;
Bus = 2;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 955;
Signal_Pos =  18;
Signal_Length =7;
Bus = 2;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

%%
Msg_id = 898;
Signal_Pos =  33;
Signal_Length =8;
Bus = 2;
[time, detectedmessages, flag] = detect_signal(T, Msg_id, Bus, Signal_Pos, Signal_Length);
ts =timeseries(detectedmessages, time);
ts.Name = sprintf("Message ID: %d, Signal Pos: %d, Signa Length: %d, Bus: %d", Msg_id, Signal_Pos, ...
     Signal_Length, Bus);
figure;
grid on;     grid minor;     ax = gca;     ax.GridColor = [130, 130, 130]/255;     set(gca,'Color', [235, 235, 235]/255);     set(gca,'FontSize',16);     set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');plot(ts, 'r.');

