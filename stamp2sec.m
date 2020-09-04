% (C) Rahul Bhadani
function seconds   =  stamp2sec(stamp)

nums = split(stamp, ':');
minute = str2double(nums(1));
seconds = str2double(nums(2));
seconds = 60.0*minute + seconds;

end