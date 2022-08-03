classdef CorrSignal
    
    % CORRSIGNAL This is a matlab class called as CORRSIGNAL that tries to find out
    % bit position and bit length of a correlated messages in CAN file based on provided feature
    % through input timeseries signal

    % Author: Rahul Bhadani
    % Maintainer Email: rahulbhadani@email.arizona.edu
    % License: MIT License 
    % Copyright 2019-2020 Rahul Bhadani
    % Initial Date: Aug 2, 2022
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
    
    properties
        CANfile; % Location of CAN data file
        BaseSignal; % Base signal whos correlated signal to search in CANfile
        CANData; % Whole CAN data from CAN file
        CANTimeCol; % What is the column name for Time Stamp in CAN file
        BaseTimeCol;
        BaseSignalCol;
        CorrelationFolder;
    end
    
    methods
        function obj = CorrSignal(CANfile,BaseSignal, CANTimeCol, BaseTimeCol,BaseSignalCol, CorrelationFolder)
            %CORRSIGNAL Construct an instance of this class
            %   Detailed explanation goes here
            obj.CANfile = CANfile;
            obj.BaseSignal = BaseSignal;
            obj.CANTimeCol = CANTimeCol;
            obj.BaseTimeCol = BaseTimeCol;
            obj.BaseSignalCol = BaseSignalCol;
            obj.CorrelationFolder = CorrelationFolder;
            
            obj.CANData = readtable(CANfile,'PreserveVariableNames',true);
            obj.CANData = obj.CANData(1:end-1,:);
            
            fprintf("\nDimension of CAN table: %d\n", size(obj.CANData));
            fprintf("\nDimension of base signal: %d\n", size(obj.BaseSignal));
            
            [~, ~, msg] =  mkdir(obj.CorrelationFolder);
            if( strcmp(msg, 'MATLAB:MKDIR:DirectoryExists') )
                fprintf('\n Correlation folder for %s already exists.\n\n', obj.CorrelationFolder);
            end
            
        end
    end
end

