///iui_update_io()
/**
    Update input / output
**/

/// time
iuiAnimTime++;

/// Mouse input
iui_inputX = window_mouse_get_x();
iui_inputY = window_mouse_get_y();
iui_inputDown = mouse_check_button(mb_left);

/// Key input
iui_keyMod  = 0;
iui_keyMod |= keyboard_check(vk_shift) << eKEYMOD.SHIFT;
iui_keyMod |= keyboard_check(vk_control) << eKEYMOD.CTRL;
iui_keyMod |= keyboard_check(vk_alt) << eKEYMOD.ALT;

if (keyboard_check_pressed(vk_anykey))
{
    iui_keyPress = keyboard_lastkey;
    
    if (!(iui_keyMod & (1 << eKEYMOD.ALT)))
    {
        iui_keyChar  = keyboard_lastchar;
        keyboard_lastchar = "";
    }
    
    // SHIFT
    /*
    if (iui_keyMod & (1<<eKEYMOD.SHIFT))
        iui_keyPress = asciiShift(iui_keyPress);
    else if (keyboard_lastkey > 32 && keyboard_lastkey < 127)
        iui_keyPress = asciiUnShift(iui_keyPress);
    */
    
    uiBigMsg    = string(iui_keyChar+" ("+string(ord(iui_keyChar))+")");
    uiBigMsgCtr = 50;
}

// enable alt-code
if (keyboard_check_released(vk_alt))
{
    iui_keyChar  = keyboard_lastchar;
    keyboard_lastchar = "";
    
    uiBigMsg    = string(iui_keyChar+" ("+string(ord(iui_keyChar))+")");
    uiBigMsgCtr = 50;
}

// cancel keyfocus
if (keyboard_check_pressed(vk_escape) && iui_kbFocusItem != -1)
{
    iui_kbFocusItem = -1;
}
