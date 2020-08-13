#define iui_trim_label
///iui_trim_label( STR )
/**
    Cuts and returns the label part of the input string
    
    
    
    =================================
    
    STR - input string
    returns label part of string
**/

var CUTPOS = string_pos('##', argument0); // Accounts for both ### & ##
if (CUTPOS != 0)
    return string_copy(argument0, 1, CUTPOS-1);
else
    return argument0;

#define iui_trim_id
///iui_trim_id( STR )
/**
    Cuts and returns the label part of the input string
    
    
    
    =================================
    
    STR - input string
    returns ID part of string
**/

var CUTPOS = string_pos('###', argument0);
if (CUTPOS != 0)
    return string_delete(argument0, 1, CUTPOS+2);
else
    return argument0;