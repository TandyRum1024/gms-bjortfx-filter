#define iui_strTrim
///iui_strTrim(string, width)
/**
    Trims and adds "..." to string if the string is longer than [width].
    
    ex ] strTrim("splöts prlrllllsshhh", 42) would return something like
         "splöts..."
    ==========================
    
    string - :D
    width - the maximum width before trimming
    
    returns : 
        Trimmed text - String.
**/

var em_ = string_width('M');
var str = argument0;
var strLen = string_length(argument0);

if (strLen * em_ > argument1)
    str = string_copy(argument0, 1, max((argument1 div em_) - 3, 0)) + "...";

return str;

#define strTrim_nodots
///iui_strTrim_nodots(string, width)
/**
    Trims if the string is longer than [width].
    
    ex ] strTrim("splöts prlrllllsshhh", 42) would return something like
         "splöts"
    ==========================
    
    string - :D
    width - the maximum width before trimming
    
    returns : 
        Trimmed text - String.
**/

var em_ = string_width('M');
var str = argument0;
var strLen = string_length(argument0);

if (strLen * em_ >= argument1)
    str = string_copy(argument0, 1, max((argument1 div em_) - 3, 0));

return str;