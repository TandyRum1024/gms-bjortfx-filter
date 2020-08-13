/// @description iui_trim_id( STR )
/// @param  STR 
/**
    Cuts and returns the label part of the input string
    
    
    
    =================================
    
    STR - input string
    returns ID part of string
**/

var CUTPOS = string_pos("###", argument0);
if (CUTPOS != 0)
    return string_delete(argument0, 1, CUTPOS+2);
else
    return argument0;
