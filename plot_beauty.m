function plot_beauty(ts_array)

rgb = [ ...
    94    79   162;
    158     1    66
    50   136   189;
    213    62    79;
   102   194   165;
   244   109    67;
   171   221   164;
    253   174    97;
   230   245   152;
   255   255   191;
   254   224   139;
     ] / 255;


marker_color = [ ...
    44    79   182;
    128     1    86 
    30   136   209;
    163    62    99;
   82   194   185;
   204   109    87;
   223   174    117;
   141   221   184;
   200   245   172;
   234   224   159;
   225   255   211;
    ] / 255;


f = figure('visible', 'on');
set(f,'Units','Inches');
%f.Position = [0.0208 3.2188 19.9583 6.8646];
hold on;

color_index = 1;
legend_array = strings(length(ts_array),1);
minax = min(ts_array(1).Time);
maxax = max(ts_array(1).Time);
for ts = ts_array
    scatter(ts.Time,ts.Data,3,'MarkerFaceColor',rgb(color_index,:), 'MarkerEdgeColor',marker_color(color_index,:),...
    'MarkerFaceColor',rgb(color_index,:));
    legend_array(color_index) = ts.Name;
    color_index = color_index + 1;
    
    %minax = min(minax, min(ts.Time));
    %maxax = max(maxax, max(ts.Time));
    
    
end

%xlim([minax, maxax]);

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


legend(legend_array);

end