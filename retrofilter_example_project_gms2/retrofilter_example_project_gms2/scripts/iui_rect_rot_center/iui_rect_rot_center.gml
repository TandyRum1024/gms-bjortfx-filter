/// @description iui_rect_rot_center(x, y, w, h, colour, rot)
/// @param x
/// @param  y
/// @param  w
/// @param  h
/// @param  colour
/// @param  rot
/**
    Draws (centered) rectangle optimized while abusing the Gamemaker's sprite-batch.
    
    ======================================================================
    
    x y w h - The position and size of rect
    colour  - It's colour, Y'see?
    rot     - rotation
**/

var halfWid = (argument2 / 2);
var halfHei = (argument3 / 2);

var ox = lengthdir_x(halfWid, argument5) - lengthdir_y(halfHei, argument5);
var oy = lengthdir_y(halfWid, argument5) + lengthdir_x(halfHei, argument5);

draw_sprite_general(spr_uiwhitepixel, 0, 2, 2, 1, 1, argument0-ox, argument1-oy, argument2, argument3, argument5, argument4, argument4, argument4, argument4, 1);

