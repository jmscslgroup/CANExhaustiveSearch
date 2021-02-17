function [binstr] = hex2bin(obj, hexstr)
    binstr ="";
    hexchar = char(hexstr);
    for j = 1:strlength(hexchar)
        h = dec2bin(hex2dec(hexchar(j)), 4);
        binstr = binstr + h;
    end
end
