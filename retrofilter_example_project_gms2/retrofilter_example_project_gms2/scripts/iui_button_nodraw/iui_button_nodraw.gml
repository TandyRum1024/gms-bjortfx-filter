/// @description iui_button_nodraw(x, y, w, h, string)
/// @param x
/// @param  y
/// @param  w
/// @param  h
/// @param  string
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
