/// @description iui_colLighter_adv( colour, howmuch, rmod, gmod, bmod )
/// @param  colour
/// @param  howmuch
/// @param  rmod
/// @param  gmod
/// @param  bmod 
/**
    Makes the colour lighter
**/

var R = (argument0&$0000FF);
var G = (argument0&$00FF00)>>8;
var B = (argument0&$FF0000)>>16;
return (min(max((B+argument1*argument4),0), $FF) << 16) | (min(max((G+argument1*argument3),0), $FF) << 8) | min(max((R+argument1*argument2),0), $FF);
