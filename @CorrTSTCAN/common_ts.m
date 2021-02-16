function [T1New, T2New] = common_ts(T1, T2, T1col, T2col)

 
    T1New = T1((T1.(T1col) >= T2.(T2col)(1)) & (T1.(T1col) <= T2.(T2col)(end)),:);
    
    T2New = T2((T2.(T2col) >= T1.(T1col)(1)) & (T2.(T2col) <= T1.(T1col)(end)),:);
    
    

end