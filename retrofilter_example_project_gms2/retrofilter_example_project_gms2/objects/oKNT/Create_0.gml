/*
    björtFX retro crt effect example
    ZIK@MMXX
*/

var _shaderok = shader_is_compiled(shd_retroscreen_screenfilter);
_shaderok &= shader_is_compiled(shd_retroscreen_distortion);
_shaderok &= shader_is_compiled(shd_retroscreen_postprocessing);
_shaderok &= shader_is_compiled(shd_misc_bg);

if (!_shaderok)
{
    show_message("Whoops, seems like the program has failed to compile the shaders...#This program requires a graphics card that supports Shaders!#(You could also, install / update your DirectX drivers and try again to see if it works.)");
    game_end();
}

/// Window settings
winWid = 800;
winHei = 600;
winTargetW = 800;
winTargetH = 600;

/// Shader parameters
// CRT emulation
crtDistortion = 0.25; // screen distortion intensity
crtReflection = 0.3; // border reflection intensity
crtShadowmask = 0.4; // shadow mask intensity
crtScanline   = 0.6; // scanline intensity
crtBleed      = 0.35; // bleed intensity
crtBleedSize  = 64; // bleed size
crtTint       = 0.1; // dynamic colour tint intensity
crtVignette   = 0.1; // vignette intensity
crtFilmgrain  = 0.1; // film grain intensity
crtBrightness = 0.23; // brightness boost/adjustment
crtContrast   = 1.0; // contrast adjustment

// Specular light
// specular light colour
crtSpecularR = 0.9;
crtSpecularG = 0.75;
crtSpecularB = 1.0;
// crtSpecularCol = c_white;
crtSpecularAmp  = 0.1; // specular light amplitude/alpha
crtSpecularOffX = 0.2; // specular light offset x
crtSpecularOffY = -0.2; // specular light offset y

// Final postprocessing FX
crtGlowFactor   = 0.75; // factor/multiplier of glow (hard-capped at certain amount)
crtGlowTint     = 0.75; // colour tint amount of blur (like chromatic aberration)
crtBlurSize     = 8; // half size of blur
crtBlurZoom     = 0.3; // zoom amount of blur

/// Surfaces
surfaceScreenWid = winWid;
surfaceScreenHei = winHei;
surfaceScreen  = surface_create(surfaceScreenWid, surfaceScreenHei); // screen surface that will get the effects applied
surfacePPTemp1 = surface_create(surfaceScreenWid, surfaceScreenHei); // temp. surface to hold the result of pass 1
surfacePPTemp2 = surface_create(surfaceScreenWid, surfaceScreenHei); // temp. surface to hold the result of pass 2
surfacePPTemp3 = surface_create(surfaceScreenWid, surfaceScreenHei); // temp. surface to hold the result of pass 3

/// State of the demo
enum eDEMO_STATE
{
    DEFAULT = 0,
    CUSTOM,
}
demoState = eDEMO_STATE.DEFAULT;
demoBGList = iui_pack(-1, bgTest1, bgTest2, bgTest3, bgTest4, bgTest5, bgTest6);
demoBGCurrent = -1;
demoBGIdx = 0;

demoCustomBGDir = "";
demoCustomBG = -1;

/// Init the UI
iui_init();
UIScale = 1.0;
UIMsg = "";
UIMsgCtr = 0;

draw_set_font(fntConsolas);

/* */
/*  */
