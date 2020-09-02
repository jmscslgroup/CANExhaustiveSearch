% (C) Rahul Bhadani

clear all;
set(0,'DefaultFigureWindowStyle','docked');
 
 
% folder = "/home/ivory/CyverseData/JmscslgroupData/PandaData/2020_08_20";
% file_name = "2020-08-20-13-46-34_2T3Y1RFV8KC014025_CAN_Messages.csv";

% folder = "/home/ivory/CyverseData/JmscslgroupData/PandaData/2020_06_01";
% file_name = "2020-06-01-13-01-36_2T3Y1RFV8KC014025_CAN_Messages.csv";

% folder = "/home/ivory/CyverseData/JmscslgroupData/PandaData/2020_07_26";
% file_name = "2020-07-26-16-35-44_2T3Y1RFV8KC014025_CAN_Messages.csv";

% folder = "/home/ivory/CyverseData/JmscslgroupData/PandaData/2020_08_01";
% file_name = "2020-08-01-14-18-24_2T3Y1RFV8KC014025_CAN_Messages.csv";

folder = "/home/ivory/CyverseData/JmscslgroupData/PandaData/2020_07_08";
file_name = "2020-07-08-15-15-54_2T3MWRFVXLW056972_CAN_Messages.csv";

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

pos = 1:48;

powerseries = zeros(1, length(pos));
for i =1 :length(pos)
    p = pos(i);
    Msg_id = 180;
    Signal_Pos =  p;
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
    [bw,flo,fhi,power] = powerbw(ts.Data(1,:));
    
    powerseries(i) = power;

end
 f = figure('visible', 'on');
set(f,'Units','Inches');
% f.Position = [0.8646 2.0625 18.1250 5.6042];
scatter(pos,powerseries, 'MarkerEdgeColor',[3, 4, 94]/255,...
    'MarkerFaceColor',[102, 137, 161]/255, 'MarkerFaceAlpha', 0.85);
grid on;
grid minor;
ax = gca;
ax.GridColor = [130, 130, 130]/255;
set(gca,'Color', [235, 235, 235]/255);
set(gca,'FontSize',16);
set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');
xlabel('Pos','Interpreter','latex');
ylabel({'Power'},...
'Interpreter','latex');
set(gca,'yscale','log')
title('RAV4','Interpreter','latex');
