/// @description  Update window size
var _winwid = window_get_width();
var _winhei = window_get_height();
if ((_winwid != surfaceScreenWid ||
    _winhei != surfaceScreenHei) &&
    _winwid != 0 &&
    _winhei != 0)
{
    winWid = _winwid;
    winHei = _winhei;
    surfaceScreenWid = _winwid;
    surfaceScreenHei = _winhei;
    
    UIScale = clamp(winWid / winTargetW, 1.0, winHei / winTargetH);
    
    // Resize the application surface
    surface_resize(application_surface, winWid, winHei);
}


/// Update surfaces
if (!surface_exists(surfaceScreen) ||
    surface_get_width(surfaceScreen) != surfaceScreenWid ||
    surface_get_height(surfaceScreen) != surfaceScreenHei)
{
    if (surface_exists(surfaceScreen))
        surface_free(surfaceScreen);
    surfaceScreen = surface_create(surfaceScreenWid, surfaceScreenHei);
}

if (!surface_exists(surfacePPTemp1) ||
    surface_get_width(surfacePPTemp1) != surfaceScreenWid ||
    surface_get_height(surfacePPTemp1) != surfaceScreenHei)
{
    if (surface_exists(surfacePPTemp1))
        surface_free(surfacePPTemp1);
    surfacePPTemp1 = surface_create(surfaceScreenWid, surfaceScreenHei);
}

if (!surface_exists(surfacePPTemp2) ||
    surface_get_width(surfacePPTemp2) != surfaceScreenWid ||
    surface_get_height(surfacePPTemp2) != surfaceScreenHei)
{
    if (surface_exists(surfacePPTemp2))
        surface_free(surfacePPTemp2);
    surfacePPTemp2 = surface_create(surfaceScreenWid, surfaceScreenHei);
}

if (!surface_exists(surfacePPTemp3) ||
    surface_get_width(surfacePPTemp3) != surfaceScreenWid ||
    surface_get_height(surfacePPTemp3) != surfaceScreenHei)
{
    if (surface_exists(surfacePPTemp3))
        surface_free(surfacePPTemp3);
    surfacePPTemp3 = surface_create(surfaceScreenWid, surfaceScreenHei);
}



/// Update UI
iui_update_io();

// iuiSliderHWid = 8 * UIScale;
// iuiSliderHHei = 16 * UIScale;
if (UIMsgCtr > 0)
    UIMsgCtr--;

