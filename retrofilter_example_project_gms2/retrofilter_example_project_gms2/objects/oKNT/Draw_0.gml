/// @description  Draw contents into the surface
switch (demoState)
{
    case eDEMO_STATE.DEFAULT:
        demoBGCurrent = demoBGList[@ demoBGIdx];
        
        if (background_exists(demoBGCurrent))
        {
            var _bgwid = background_get_width(demoBGCurrent);
            var _bghei = background_get_height(demoBGCurrent);
            var _bgscale = min(surfaceScreenWid / _bgwid, surfaceScreenHei / _bghei);
            _bgwid *= _bgscale;
            _bghei *= _bgscale;
            var _bgx = (surfaceScreenWid - _bgwid) * 0.5;
            var _bgy = (surfaceScreenHei - _bghei) * 0.5;
            draw_background_ext(demoBGCurrent, _bgx, _bgy, _bgscale, _bgscale, 0, c_white, 1.0);
        }
        break;
        
    case eDEMO_STATE.CUSTOM:
        var _bg = demoCustomBG;
        var _bgwid = background_get_width(_bg);
        var _bghei = background_get_height(_bg);
        var _bgscale = min(surfaceScreenWid / _bgwid, surfaceScreenHei / _bghei);
        _bgwid *= _bgscale;
        _bghei *= _bgscale;
        var _bgx = (surfaceScreenWid - _bgwid) * 0.5;
        var _bgy = (surfaceScreenHei - _bghei) * 0.5;
        draw_background_ext(_bg, _bgx, _bgy, _bgscale, _bgscale, 0, c_white, 1.0);
        break;
}

