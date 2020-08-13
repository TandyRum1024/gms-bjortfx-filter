#define iui_get_all
///iui_str_get_all( STR )
/**
    Gets LABEL (the displayable part) and ID (of element) from string
    
    ==========================
    
    STR - the string to get LABEL and ID from
    
    returns :
        returnArray - Array holding LABEL and ID
        returnArray[0] - ID (REAL)
        returnArray[1] - LABEL (STRING)
**/

var returnArray;
var _TMPID     = iui_trim_id(argument0);
var _MAPID     = iui_idMap[? _TMPID];

if (_MAPID != undefined) // the ID doesn't exist -- Make a new one and put into the map
    returnArray[0] = _MAPID;
else // ID already exists... Take that.
{
    returnArray[0]      = iui_idx;
    iui_idMap[? _TMPID] = iui_idx++;
}

returnArray[1] = iui_trim_label(argument0);

return returnArray;

#define iui_get_id
///iui_get_id( STR )
/**
    Gets ID (of element) from string
    
    ==========================
    
    STR - the string to get ID from
    
    returns :
        returnVar - ID (Real)
**/

var returnVar;
var _TMPID     = iui_trim_id(argument0);
var _MAPID     = iui_idMap[? _TMPID];

if (_MAPID != undefined) // the ID doesn't exist -- Make a new one and put into the map
    returnVar = _MAPID;
else // ID already exists... Take that.
{
    returnVar      = iui_idx;
    iui_idMap[? _TMPID] = iui_idx++;
}

return returnVar;

#define iui_get_label
///iui_get_label( STR )
/**
    Gets LABEL from STR.
    You should be using iui_trim_label() but..
    Whatever.
    
    ==========================
    
    STR - the string to get LABEL from
    
    returns :
        LABEL (String)
**/

var CUTPOS = string_pos('##', argument0); // Accounts for both ### & ##
if (CUTPOS != 0)
    return string_copy(argument0, 1, CUTPOS-1);
else
    return argument0;