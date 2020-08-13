/// @description iui_get_id( STR )
/// @param  STR 
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

