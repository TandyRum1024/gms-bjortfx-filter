///iui_init()
/**
    Initalizes the IMNOTUI

    ==============================
**/

/// Init IMGUI related stuff
///=========================================================
// Input related - We use this instead of mouse_x / y or whatever...
// In case of another input method such as gamepad n' stuff
iui_inputX    = 0;          // (= mouse_x)
iui_inputY    = 0;          // (= mouse_y)
iui_inputDown = false;      // (= Mouse click input)
iui_keyPress  = 0;          // hit once
iui_keyChar   = 0;          // key down (without key delay)
iui_keyMod    = 0;

enum eKEYMOD
{
    SHIFT,
    CTRL,
    ALT
}

// element stuff
iui_varmap = ds_map_create(); // variable map for storing information used by elements
iui_kbFocusItem = -1;       // What item is having the keybard input focus
iui_activeItem  = -1;       // What item is active
iui_hotItem     = -1;       // What item is HOT - AKA placed mouse over it

// ID chache? map
iui_idMap = ds_map_create();
iui_idx   = 0;

// Why gamemaker has no draw_get_halign() and draw_get_valign()
iui_alignStack = ds_stack_create();
iui_halign = fa_left;
iui_valign = fa_top;

// LUT stuff
IUI_SINE_LUT_45DEG = 0.70710696969696969; // Sine 45deg (also 69 lol)


/// Styles
///=========================================================
iui_style();


///=========================================================
// whoow weew
iui_init_vars();
iuiAnimTime = 0;

// optional - set font
// draw_set_font(fnt_consolas);
