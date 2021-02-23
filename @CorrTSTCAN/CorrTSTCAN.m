classdef CorrTSTCAN < matlab.mixin.Copyable
    % CorrTSTCAN This is a matlab class called as CorrTSTCAN that tries to find out
    % bit position and bit length of a correlated messages in CAN file based on provided feature
    % or column of a Techstream file.

    % Author: Rahul Bhadani
    % Maintainer Email: rahulbhadani@email.arizona.edu
    % License: MIT License 
    % Copyright 2019-2020 Rahul Bhadani
    % Initial Date: Feb 15, 2021
    % Permission is hereby granted, free of charge, to any person obtaining 
    % a copy of this software and associated documentation files 
    % (the "Software"), to deal in the Software without restriction, including
    % without limitation the rights to use, copy, modify, merge, publish,
    % distribute, sublicense, and/or sell copies of the Software, and to 
    % permit persons to whom the Software is furnished to do so, subject 
    % to the following conditions:

    % The above copyright notice and this permission notice shall be 
    % included in all copies or substantial portions of the Software.

    % THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF 
    % ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
    % TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
    % PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT 
    % SHALL THE AUTHORS, COPYRIGHT HOLDERS OR ARIZONA BOARD OF REGENTS
    % BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN 
    % AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
    % OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
    % OR OTHER DEALINGS IN THE SOFTWARE.


    %% Properties
    properties
        
        % TST = Techstream
        CANfile; % Location of CAN data file
        TSTfile; % Location of techstream file
        TSTFeature; % feature of TST we are interested in
        TSTFeature2; % feature2 of TST we are interested in
        
        TSTData; % Whole data read from TST file
        CANData; % Whole CAN data from CAN file
        CANSpeed; % Speed retrieved from CAN Data
        CANSpeedFlag; % Flag for validity of CAN speed data
        TSTTimeCol;% What is the column name for Time Stamp in TST file
        CANTimeCol; % What is the column name for Time Stamp in CAN file
        CorrelationFolder;
        
        
    end
    
    %% Methods
    methods
        %% Constructors
        function obj = CorrTSTCAN(CANfile, TSTfile, TSTFeature, TSTFeature2, Offset, TSTTimeCol, CANTimeCol)
            obj.CANfile = CANfile;
            obj.TSTfile = TSTfile;
            obj.TSTFeature = TSTFeature;
            obj.TSTFeature2 = TSTFeature2;
            
            if nargin == 5
                obj.TSTTimeCol = "Sample Time";
                obj.CANTimeCol = "Time";
            elseif nargin == 6
                obj.TSTTimeCol = TSTTimeCol;
                obj.CANTimeCol = "Time";
            elseif nargin == 7
                obj.TSTTimeCol = TSTTimeCol;
                obj.CANTimeCol = CANTimeCol;
            end
                            
            obj.TSTData = readtable(TSTfile,'PreserveVariableNames',true);
            
            obj.TSTData = obj.TSTData(1:end-1,:);
            
            obj.CANData = readtable(CANfile,'PreserveVariableNames',true);
            obj.CANData = obj.CANData(1:end-1,:);
                        
            tstime = obj.TSTData.(obj.TSTTimeCol);
            cantime = obj.CANData.(obj.CANTimeCol);

            if (cantime (1) > tstime(end))
                fprintf("%f HRS\n", (cantime (1)- tstime(end))/3600.0);
                
                %error("Start Time of CAN data is after end time of Techstream Data. Feature correlation will fail.")
            end

            if (tstime (1) > cantime(end))
                fprintf("%f HRS\n", (tstime (1)- cantime(end))/3600.0);
                %error("Start Time of Techstream data is after end time of CAN Data. Feature correlation will fail.")
            end
            

             
             %[obj.CANData, obj.TSTData] = obj.common_ts(obj.CANData, obj.TSTData,  obj.CANTimeCol, obj.TSTTimeCol);
             
             fprintf("\nDimension of CAN Table: %d\n", size(obj.CANData));
             fprintf("\nDimension of TST Table: %d\n", size(obj.TSTData));

             [obj.CANSpeed, obj.CANSpeedFlag] = obj.getCANSpeed();
             [filepath,name,ext] = fileparts(CANfile);
            
             obj.CorrelationFolder = filepath + "/" + name + "_" + strrep(TSTFeature, ' ', '') + "_Correlation";
             [~, ~, msgID] =  mkdir(obj.CorrelationFolder);
            if( strcmp(msgID, 'MATLAB:MKDIR:DirectoryExists') )
                fprintf('\n Correlation folder for %s already exists.\n\n', obj.CorrelationFolder);
            end

        end % end of constructors
    
    end % end of methods
    
    
end
        
    
