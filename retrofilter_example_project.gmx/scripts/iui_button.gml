#define iui_button
///iui_button(x, y, w, h, string)
/**
    Button for clicky things
    
    Usage : iui_button(pos_x, pos_y, width, height, "Button test!");
    
    returns whether if its pressed.
    ===============================
    
    x, y, w, h - position, and size of the button
    string - the string (id and label) for button
**/

/// Setup
// box edges
var boxL = argument0, boxT = argument1;
var boxR = (boxL + argument2), boxB = (boxT + argument3);

/// Get label and ID.
var stringArray = iui_get_all(argument4);
var ID     = stringArray[0];
var LABEL  = stringArray[1];

/// Button logic
var isClicky = false;

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
    isClicky = true;


/// Button draw
var isActive = (iui_activeItem == ID);
var isHot    = (iui_hotItem == ID);

if (iuiButtonShadow)
    iui_rect(argument0 + 8, argument1 + 8, argument2, argument3, iuiColButtonShadow);

// Hovering
if (isHot)
{
    // and clicked
    if (isActive)
    {
        iui_rect(argument0, argument1, argument2, argument3, iuiColButtonActiveBackdrop); // backdrop
        iui_rect(argument0, argument1, argument2, 9, iuiColButtonActiveBackdropTop); // top line / box for style?
    }
    else // nope
    {
        iui_rect(argument0, argument1, argument2, argument3, iuiColButtonHotBackdrop);
        iui_rect(argument0, argument1, argument2, 9, iuiColButtonHotBackdropTop);
    }
}
else // Nope
{
    // Still pressing but dragged out of the button
    if (isActive)
    {
        iui_rect(argument0, argument1, argument2, argument3, iuiColButtonActiveBackdrop);
        iui_rect(argument0, argument1, argument2, 9, iuiColButtonActiveBackdropTop2);
    }
    else // default
    {
        iui_rect(argument0, argument1, argument2, argument3, iuiColButtonBackdrop);
        iui_rect(argument0, argument1, argument2, 5, iuiColButtonBackdropTop);
    }
}

// label
iui_align_center();
draw_text_colour(argument0 + (argument2 >> 1), argument1 + (argument3 >> 1), LABEL, iuiColButtonLabel, iuiColButtonLabel, iuiColButtonLabel, iuiColButtonLabel, 1);
iui_align_pop();

return isClicky;

#define iui_button_nodraw
///iui_button_nodraw(x, y, w, h, string)
/**
    Same as button, But without drawing. (= invisible button)
    
    ===============================
    
    x, y, w, h - position, and size of the button
    string - the string (id) for button
**/

/// Setup
var boxL = argument0, boxT = argument1;
var boxR = (boxL + argument2), boxB = (boxT + argument3);

/// Get label and ID.
var ID = iui_get_id( argument4 );


/// Button logic
var isClicky = false;
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
    isClicky = true;

return isClicky;