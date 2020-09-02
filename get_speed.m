function [speed_ts, flag] = get_speed(T)
   % Rahul Bhadani
   % Get the speed in km/h from CAN csv table.
    signal_pos = 41;
    signal_len = 16;
    fprintf('\nGenerating Speed Signal\n');
    Msg_id = 180;
    flag = 0;
    TM = T(T.MessageID == Msg_id, :);
    TM = TM(TM.Bus ==2,:);
    MLen = unique(TM.MessageLength);
    
    time = TM.Time;
    TMsize = size(TM);
    detectedmessages = zeros(1, TMsize(1));
    binarystr = strings(1, TMsize(1));
    
    if length(MLen) == 1
        fprintf("Message Length: %d\n", MLen);
        if (signal_pos > MLen*8) 
            fprintf("Specified Signal Position %d exceeded the message length boundary\n", signal_pos);
            flag = -1;
            return;
        end
        if (signal_len > MLen*8)
            fprintf("Specified Signal length %d exceeded the toal message length\n", signal_len);
            flag = -1;
            return;
        end
        if (signal_pos + signal_len > MLen*8)
            fprintf("Specified Signal length %d exceeded the message length boundary\n", signal_len);
            flag = -1;
            return;
        end
        
         for i = 1:TMsize(1)
            binarystr(i)  = hex2bin(TM.Message{i});
        end
        
    else
        fprintf("Variable Message Lengths: %d\n", MLen);
        for i = 1:TMsize(1)
            MLen = TM.MessageLength(i);
            if (signal_pos > MLen*8) 
                fprintf("Specified Signal Position %d exceeded the message length boundary\n", signal_pos);
                flag = -1;
                return;
            end
            if (signal_len > MLen*8)
                fprintf("Specified Signal length %d exceeded the toal message length\n", signal_len);
                flag = -1;
                return;
            end
            if (signal_pos + signal_len > MLen*8)
                fprintf("Specified Signal length %d exceeded the message length boundary\n", signal_len);
                flag = -1;
                return;
            end
            binarystr(i)  = hex2bin(TM.Message{i});
        end
        
    end
    

    for i = 1:TMsize(1)
        bin_val = char(binarystr(i));
        slice = bin_val(signal_pos:signal_pos+signal_len-1);
        detectedmessages(i) = bin2dec(slice);
    end
    
    
     speed_ts = timeseries(detectedmessages, time);
     
     
end