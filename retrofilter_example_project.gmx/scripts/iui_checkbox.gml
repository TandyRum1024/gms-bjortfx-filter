///iui_checkbox(x, y, w, h, checked, id)
/**
    Button for clicky things
    
    Usage : var = iui_checkerbox(pos_x, pos_y, width, height, var, "checker");
    
    returns whether if its pressed.
    ===============================
    
    x, y, w, h - position, and size of the button
    checked - is the checkerbox checked?
    id - checkerbox's id
**/

/// Setup
// box edges
var boxL = argument0, boxT = argument1, boxW = argument2, boxH = argument3;
var checkerVar = argument4;
var boxR = (boxL + boxW), boxB = (boxT + boxH);

/// Get label and ID.
var stringArray = iui_get_all(argument5);
var ID     = stringArray[0];
var LABEL  = stringArray[1];

/// Button logic
// var isClicky = false;

// is hover
if (point_in_rectangle(iui_inputX, iui_inputY, boxL, boxT, boxR, boxB))
{
    iui_hotItem = ID;
    
    // ... and is clicked
    if (iui_activeItem == -1 && iui_inputDown)
        iui_activeItem = ID;
}

// is 'Pressed" (AKA The user pressed and released the button)
if (iui_hotItem == ID && iui_activeItem == ID && !iui_inputDown)
    checkerVar = !checkerVar;


/// checker draw
var isActive = (iui_activeItem == ID);
var isHot    = (iui_hotItem == ID);

// Backdrop
iui_rect(boxL - 2, boxT - 2, boxW + 4, boxH + 4, iuiColCheckboxBorder);
iui_rect(boxL, boxT, boxW, boxH, iuiColCheckboxBG);

if (checkerVar)
{
    draw_sprite_stretched_ext(spr_uicheck, 0, boxL, boxT, boxW, boxH, iuiColCheckboxFG, 1);
}
return checkerVar;
