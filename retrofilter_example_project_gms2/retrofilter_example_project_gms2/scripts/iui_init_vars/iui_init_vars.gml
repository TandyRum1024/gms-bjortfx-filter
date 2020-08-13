/// @description iui_init_vars()
/**
    Variables for elements...

    ===================================================
**/

// ex ] When you use tab...
// you do it like this in DRAW event,
//  ui_tab_main_idx = iui_tab(TAB_X, 30, 140, 50, pack("IMnotGUI", "..."), ui_tab_main_idx, 2);

// and declare the variable Here.
//  ui_tab_main_idx = 0;
enum eTABS
{
    MAIN = 0,
    CONFIG_SCREEN,
    CONFIG_SCREEN2,
    CONFIG_POSTFX
}
UI_TAB_ELEMENTS = iui_pack("MAIN", "ADJUST CRT.", "ADJUST CRT. \\#2", "ADJUST POST PROCESSING.", "VIEW");
UI_TAB_IDX = 0;

/// UI vars


/// Style override
UI_BASE_COL = iui_colLighter(iui_col16($252427), -5);
UI_ACCENT_COL = iui_col16($ff6148);

// Tab
iuiColTabLabel = iui_col16($fff1c1);

iuiColTabHot = iui_col16($313142);
iuiColTabHotAccent = iui_col16($ef6e3e);

iuiColTabCurrent = iui_col16($313142);
iuiColTabCurrentAccent = iui_col16($ff6148);

iuiColTabNum = 2;
iuiColTab       = -1;
iuiColTabAccent = -1;
iuiColTab[0]       = iui_col16($252427);
iuiColTabAccent[0] = iui_col16($b58879);
iuiColTab[1]       = iui_colLighter(iuiColTab[0], -5);
iuiColTabAccent[1] = iui_colLighter(iuiColTabAccent[0], -5);

// Button
iuiColButtonBackdrop = iui_col16($252427);
iuiColButtonBackdropTop = iui_col16($b58879);
iuiColButtonActiveBackdrop     = iui_col16($313142);
iuiColButtonActiveBackdropTop  = iui_col16($ff6148);
iuiColButtonActiveBackdropTop2 = iui_col16($ff6148);
iuiColButtonHotBackdrop    = iui_col16($313142);
iuiColButtonHotBackdropTop = iui_col16($ef6e3e);
iuiColButtonLabel          = iuiColTabLabel;

// Slider
iuiSliderHWid = 8;
iuiSliderHHei = 16;

iuiColSliderLine   = iui_colLighter(iui_col16($252427), -10);
iuiColSlider       = iui_col16($ff6148);
iuiColSliderActive = iui_col16($ef6e3e);
iuiColSliderHot    = iui_col16($ef6e3e);
