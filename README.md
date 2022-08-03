# CANExhaustiveSearch


## Instructions
We will use `CorrSignal` class to find bit position and bi length  to discover a signal that is strongly correlated with a base signal.

`CorrSignal` requires the following input:
- full path to the csv file corresponding to CAN data table
- base signal as a data table
- name of time and message columns of the base signal
- name of time column of the CAN data table
- folder where to store correlation values containing correlation with varying bit position and bit length

The overall method is implemented in MATLAB using `parfor` distributed computing tool that allows the use of multiple cores available.

See the code-snippet below:

```{matlab}
clear;close all;
addpath("/home/refulgent/VersionControl/Jmscslgroup/CANExhaustiveSearch");
myCluster = parcluster('local');
myCluster.NumWorkers = 2;  % 'Modified' property now TRUE
saveProfile(myCluster);    % 'local' profile now updated,
parpool(myCluster, myCluster.NumWorkers);

%parpool(28);
folder = "Data";
can = "2020-10-01-11-01-37_2T3Y1RFV8KC014025_CAN_Messages.csv";
base = "base_speed_signal.csv"; % base signal file
canfile = sprintf("%s/%s", folder, can);
basefile = sprintf("%s/%s", folder, base);

B = readtable(basefile,'PreserveVariableNames',true);

c = CorrSignal(canfile,...
     B,...
    "Time",...
    "Time",...
    "Message", ...
    "./");

c.ExhaustiveFeatureCorrelation(true, [180]);
```

1. In the above code-snippet, first `addpath` to the folder where `@CorrSignal` class folder is (basically the full path of this git repo wherever checked out in your machine).
2. Next, set the number of workers for parallelization. Don't set it too high if you don't have too many cores in your system.
3. Next set, full path of CAN bus file and base signal file. 
4. Create the object of type `CorrSignal` 
5. Call `ExhaustiveFeatureCorrelation`. The first argument is a boolean which if `true`, creates a plot of every possible signal the method has hunted. The second argument is a list of IDs where to search for. You can leave it empty too, i.e. `ExhaustiveFeatureCorrelation(true, []);` for search all possible message IDs.

## Running on HPC.
