/// @description iui_rect_rot_origin(x, y, w, h, colour, rot, ox, oy)
/// @param x
/// @param  y
/// @param  w
/// @param  h
/// @param  colour
/// @param  rot
/// @param  ox
/// @param  oy
/**
    Draws (centered) rectangle optimized while abusing the Gamemaker's sprite-batch.
    
    ======================================================================
    
    x y w h - The position and size of rect
    colour  - It's colour, Y'see?
    rot     - rotation
    ox, oy  - origin
**/

var ox = lengthdir_x(argument6, argument5) - lengthdir_y(argument7, argument5);
var oy = lengthdir_y(argument6, argument5) + lengthdir_x(argument7, argument5);

draw_sprite_general(spr_uiwhitepixel, 0, 2, 2, 1, 1, argument0-ox, argument1-oy, argument2, argument3, argument5, argument4, argument4, argument4, argument4, 1);
