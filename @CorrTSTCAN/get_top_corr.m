function TopCorr = get_top_corr(obj)

    correlation_files = dir(obj.CorrelationFolder + "/*.csv");
    
    if (isempty(correlation_files))
        error("No Correlation file was found");
    end
    
    C1 = readtable(correlation_files(1).folder + "/" + correlation_files(1).name, 'PreserveVariableNames',true);
    
    M = table('size', [0, length(C1.Properties.VariableNames) ], 'VariableNames', C1.Properties.VariableNames, 'VariableTypes', ["uint8", "uint8"', "uint8", "uint8", "double"]);
    
    for i = 1:length(correlation_files)
        C = readtable(correlation_files(i).folder + "/" + correlation_files(i).name, 'PreserveVariableNames',true);
        M = [M; C];
    end
    M = rmmissing(M);
    M = sortrows(M, 5, 'descend');
    
    TopCorr = M(1:20, :);
    
end