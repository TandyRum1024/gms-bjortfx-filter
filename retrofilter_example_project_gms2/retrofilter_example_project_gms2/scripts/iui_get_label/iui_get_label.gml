/// @description iui_get_label( STR )
/// @param  STR 
/**
    Gets LABEL from STR.
    You should be using iui_trim_label() but..
    Whatever.
    
    ==========================
    
    STR - the string to get LABEL from
    
    returns :
        LABEL (String)
**/

var CUTPOS = string_pos("##", argument0); // Accounts for both ### & ##
if (CUTPOS != 0)
    return string_copy(argument0, 1, CUTPOS-1);
else
    return argument0;
