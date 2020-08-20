/// @description iui_vtx_rect_col(x1, y1, x2, y2, colour, alpha)
/// @param x1
/// @param  y1
/// @param  x2
/// @param  y2
/// @param  colour
/// @param  alpha
/**
    [VERTEX BUFFER]
    Draws rectangle
    
    ==============================
    
    x y w h - The position and size of rectangle
    colour  - It's colour, Y'see?
    alpha   - Alpha of rectangle
**/

var _colour = iui_VBCOLOUR;
var _alpha  = iui_VBALPHA;
iui_VBCOLOUR = argument4;
iui_VBALPHA  = argument5;
iui_vtx(argument0, argument1);
iui_vtx(argument2, argument1);
iui_vtx(argument0, argument3);
iui_vtx(argument0, argument3);
iui_vtx(argument2, argument1);
iui_vtx(argument2, argument3);
iui_VBCOLOUR = _colour;
iui_VBALPHA  = _alpha;
