/*
    Stylize your UI here.
*/

// colours
iuHellaDark = iui_col16($191817);
iuDark      = iui_col16($313435);
iuDark2     = iui_col16($3F494F);
iuNormal    = iui_col16($637674);
iuCream     = iui_col16($EFE8C4);
iuCreamDark = iui_col16($E0D3A7);
iuMint      = iui_col16($25CDA3);
iuSky       = iui_col16($68B9C8);
iuRed       = iui_col16($ED3255);
iuPiss      = iui_col16($EABF11);
iuBrown     = iui_col16($5A4D48);

// Button
iuiButtonShadow    = false;
iuiColButtonShadow = iuHellaDark;
iuiColButtonBackdrop    = iuDark2;
iuiColButtonBackdropTop = iuMint;
iuiColButtonActiveBackdrop     = iuHellaDark;
iuiColButtonActiveBackdropTop  = iuMint;
iuiColButtonActiveBackdropTop2 = iuPiss; // when active but mouse is out of the button
iuiColButtonHotBackdrop    = iuNormal;
iuiColButtonHotBackdropTop = iuMint;
iuiColButtonLabel          = iuCreamDark;

// Tab
iuiColTabLabel     = iuCream;
iuiColTabHot       = iuNormal;
iuiColTabHotAccent = iuPiss;
iuiColTabCurrent       = iuHellaDark;
iuiColTabCurrentAccent = iuMint;
// stripe coloured tab
iuiColTabNum    = 2; // number of tab colours
iuiColTab       = 0;
iuiColTabAccent = 0;
iuiColTab[0]       = iuDark;
iuiColTabAccent[0] = iuNormal;
iuiColTab[1]       = iui_colLighter(iuDark, -5);
iuiColTabAccent[1] = iui_colLighter(iuNormal, -5);

// Text box
iuiTextBoxRainbow   = true; // rainbow colour when active
iuiColTextBoxFill   = iui_colLighter(iuHellaDark, 5);
iuiColTextBoxText   = iuCream;
iuiColTextBoxBorder = iuSky;
iuiColTextBoxActiveFill   = iuHellaDark;
iuiColTextBoxActiveBorder = iuHellaDark;
iuiColTextBoxActiveText   = iuCream;
iuiColTextBoxHotFill   = iui_colLighter(iuHellaDark, 7);
iuiColTextBoxHotBorder = iuMint;
iuiColTextBoxHotText   = iuCream;

// Slider
// display min, max and value on active?
iuiSliderDisplayValue = true;
// horizontal
iuiSliderHWid = 20;
iuiSliderHHei = 42;
// vertical
iuiSliderVWid = 42;
iuiSliderVHei = 20;
// How thick the guideline(?) is
iuiSliderThick = 8;

iuiColSliderLine   = iuHellaDark;
iuiColSlider       = iuNormal;
iuiColSliderActive = iuDark2;
iuiColSliderHot    = iui_colLighter(iuNormal, 10);

// Checkbox
iuiColCheckboxBorder = iuCream;
iuiColCheckboxBG = iuHellaDark;
iuiColCheckboxFG = iuMint; // the checker colour
