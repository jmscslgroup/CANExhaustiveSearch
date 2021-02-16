function ExhaustiveFeatureCorrelation(obj, makeplot)
    
    tstime = obj.TSTData.(obj.TSTTimeCol);
    cantime = obj.CANData.(obj.CANTimeCol);

    if (cantime (1) > tstime(end))
        error("Start Time of CAN data is after end time of Techstream Data. Feature correlation will fail.")
    end

    if (tstime (1) > cantime(end))
        error("Start Time of Techstream data is after end time of CAN Data. Feature correlation will fail.")
    end


    featureData = obj.TSTData.(obj.TSTFeature);
    featureTime = obj.TSTData.(obj.TSTTimeCol);
    
    featureTS = timeseries( featureData,  featureTime);
    
    frequency_2 = 1/mean(diff(featureTS.Time));

    MessageIDs = unique(obj.CANData.MessageID);
    MessageIDs =  MessageIDs';

    fprintf("\nEnter parfor loop\n");
    
    data2writefile = obj.CorrelationFolder;
    feature = obj.TSTFeature;
    
    T = obj.CANData;
    parfor id = 1:numel(MessageIDs)
         M_id = MessageIDs(id);
        correlationfile = data2writefile + "/"+sprintf("CorrCoeffSpeed_TechStream_%d.csv",M_id) ;
        if ~isfile(correlationfile)
            fprintf("Correlation file doesn't exist .. creating\n");
            fileID = fopen(correlationfile,'w');
            fprintf(fileID,"MessageID,Bus,SignalPos,SignalLength,CorrCoeffWith" + feature+"\n");
            fclose(fileID);
        else
            fprintf("Correlation file exists .. not creating\n");
        end
    
        TM = T(T.MessageID == M_id, :);
         sig_length = [linspace(1, 16, 16), 32];
         
         folder = sprintf("%s/%d", data2writefile, M_id);
         if ~exist(folder, 'dir')
               mkdir(folder);
         end
         
         for bus = 0:2
            TB = TM(TM.Bus == bus,:);
            if isempty(TB)
                fprintf("\nMessages with ID %d on Bus %d doesn't exist\n", M_id, bus);
                continue;
            end
            for sig_pos = 1:64
                for sig_len = sig_length
                    pngname = sprintf("%s/%d/DetectedSignal_MAT-Bus_%02d-SignalPos_%02d-SignalLen_%02d.png", data2writefile, M_id, bus, sig_pos, sig_len);
                      if makeplot == true
                          if isfile(pngname)
                            fprintf("\npngfile %s already exists, continuing\n", pngname);
                            continue;
                          end
                      end
                      
                    [time, detectedval, flag] = detect_signal(T, M_id, bus, sig_pos, sig_len);
                    if flag == -1
                        continue;
                    end

                    ts_msg =  timeseries(detectedval, time);
                    % Synchronize the newly obtained timeseries with speed timeseries so as to calculate correlation coefficient
                     frequency_1 = 1/mean(diff(ts_msg.Time));
                     frequency = min(frequency_1, frequency_2);
                    [ts_msg_resampled, featureTS_resampled] = synchronize(ts_msg, featureTS, 'Uniform','Interval', 1.0/frequency, 'InterpMethod','zoh');
                     % Calculate correlation Coefficient
                     cf= corrcoef(ts_msg_resampled.Data, featureTS_resampled.Data);
                     cf2_feature = cf(2);

                    if ~isnan(cf2_feature)
                        fileID = fopen(correlationfile,'a');
                        fprintf(fileID,'%d, %d,%d,%d,%f\n', M_id, bus, sig_pos, sig_len, cf2_feature);
                        fclose(fileID);

                        if makeplot == true
                            f = figure('visible', 'off');
                            set(f,'Units','Inches');
                            f.Position = [0.9167 2.1146 18.1667 7.1458];
                            scatter(time, detectedval, 5 ,'MarkerEdgeColor',[0 .5 .5],...
                              'MarkerFaceColor',[0 .7 .7]);

                            title(sprintf("Exhaustive Search for Signal Detection, Message ID %d", M_id), 'FontSize', 10, 'Interpreter','none');
                            grid on;
                            grid minor;
                            ax = gca;
                            ax.GridColor = [130, 130, 130]/255;
                            set(gca,'Color', [235, 235, 235]/255);
                            set(gca,'FontSize',10);
                            set(gca,'XColor', [130, 130, 130]/255,'YColor',  [130, 130, 130]/255,'TickDir','out');
                            xlabel('Time (s)', 'Color', 'k');
                            ylabel('[Unit]','Color', 'k');
                            ylim([min(detectedval)*0.70 - 15.0, max(detectedval)*1.30 + 15.0]);
                            legend({sprintf("Message ID: %d, Bus: %d, Signal Pos: %d, Signal Len: %d", M_id, bus, sig_pos, sig_len)});
                            set(gcf, 'InvertHardCopy', 'off'); 
                            saveas(gcf, pngname);
                            close(f);
                        end
                    end
                end
             end
         end
     end
end