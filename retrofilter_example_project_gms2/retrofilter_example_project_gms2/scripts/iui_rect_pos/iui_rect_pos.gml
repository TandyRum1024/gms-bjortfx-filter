/// @description iui_rect_pos(x1, y1, x2, y2, colour, alpha)
/// @param x1
/// @param  y1
/// @param  x2
/// @param  y2
/// @param  colour
/// @param  alpha
/**
    Draws rectangle optimized while abusing the Gamemaker's sprite-batch.
    
    ======================================================================
    
    x1 y1 x2 y2 - The left, top, right, bottom position of rectangle
    colour  - It's colour, Y'see?
    alpha   - Alpha of rect
**/

draw_sprite_part_ext(spr_uiwhitepixel, 0, 1, 1, 1, 1, min(argument0, argument2), min(argument1, argument3), abs(argument2-argument0), abs(argument3-argument1), argument4, argument5);
