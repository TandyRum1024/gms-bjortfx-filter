/// @description iui_str_get_all( STR )
/// @param  STR 
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

