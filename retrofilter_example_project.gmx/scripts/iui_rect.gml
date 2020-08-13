#define iui_rect
///iui_rect(x, y, w, h, colour)
/**
    Draws rectangle optimized while abusing the Gamemaker's sprite-batch.
    
    ======================================================================
    
    x y w h - The position and size of rect
    colour  - It's colour, Y'see?
**/

draw_sprite_part_ext(spr_uiwhitepixel, 0, 1, 1, 1, 1, argument0, argument1, argument2, argument3, argument4, 1);

#define iui_rect_alpha
///iui_rect_alpha(x, y, w, h, colour, alpha)
/**
    Draws rectangle optimized while abusing the Gamemaker's sprite-batch.
    
    ======================================================================
    
    x y w h - The position and size of rect
    colour  - It's colour, Y'see?
    alpha   - Alpha of rect
**/

draw_sprite_part_ext(spr_uiwhitepixel, 0, 1, 1, 1, 1, argument0, argument1, argument2, argument3, argument4, argument5);

#define iui_rect_pos
///iui_rect_pos(x1, y1, x2, y2, colour, alpha)
/**
    Draws rectangle optimized while abusing the Gamemaker's sprite-batch.
    
    ======================================================================
    
    x1 y1 x2 y2 - The left, top, right, bottom position of rectangle
    colour  - It's colour, Y'see?
    alpha   - Alpha of rect
**/

draw_sprite_part_ext(spr_uiwhitepixel, 0, 1, 1, 1, 1, min(argument0, argument2), min(argument1, argument3), abs(argument2-argument0), abs(argument3-argument1), argument4, argument5);
#define iui_rect_rot
///iui_rect_rot(x, y, w, h, colour, rot)
/**
    Draws rectangle optimized while abusing the Gamemaker's sprite-batch.
    
    ======================================================================
    
    x y w h - The position and size of rect
    colour  - It's colour, Y'see?
    rot     - rotation
**/

draw_sprite_general(spr_uiwhitepixel, 0, 2, 2, 1, 1, argument0, argument1, argument2, argument3, argument5, argument4, argument4, argument4, argument4, 1);

#define iui_rect_rot_center
///iui_rect_rot_center(x, y, w, h, colour, rot)
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

#define iui_rect_rot_origin
///iui_rect_rot_origin(x, y, w, h, colour, rot, ox, oy)
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