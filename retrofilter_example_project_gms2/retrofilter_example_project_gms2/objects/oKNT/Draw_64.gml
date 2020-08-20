/// @description  Draw screen surface with CRT effects
var _time = current_time * 0.001;

/// Fetch the texture handles
var _texnoise = sprite_get_texture(texBluenoise, 0);
var _texshadowmask = sprite_get_texture(texShadowMask, 0);
var _texrainbowlut = sprite_get_texture(texRainbowLUT, 0);
// (also fetch the texel size of texture)
var _texnoisetexelw = texture_get_texel_width(_texnoise);
var _texnoisetexelh = texture_get_texel_height(_texnoise);
var _texshadowmasktexelw = texture_get_texel_width(_texshadowmask);
var _texshadowmasktexelh = texture_get_texel_height(_texshadowmask);

/// Set texture interpolation
texture_set_interpolation(true);


/// Pass #1 : Screen filter (shadowmask, scanline etc..)
// Feed the results into the temp. surface #1
var _surfw = surface_get_width(surfaceScreen);
var _surfh = surface_get_height(surfaceScreen);
surface_set_target(surfacePPTemp1);

// Set the shader
shader_set(shd_retroscreen_screenfilter);

// Prepare the uniforms
var _u_time                 = shader_get_uniform(shd_retroscreen_screenfilter, "uTime");
var _u_shadowmaskintensity  = shader_get_uniform(shd_retroscreen_screenfilter, "uShadowmaskIntensity");
var _u_scanlineintensity    = shader_get_uniform(shd_retroscreen_screenfilter, "uScanlineIntensity");
var _u_bleendintensity      = shader_get_uniform(shd_retroscreen_screenfilter, "uBleedIntensity");
var _u_bleendsize           = shader_get_uniform(shd_retroscreen_screenfilter, "uBleedSize");
var _u_tintintensity        = shader_get_uniform(shd_retroscreen_screenfilter, "uTintIntensity");
var _u_vignetteintensity    = shader_get_uniform(shd_retroscreen_screenfilter, "uVignetteIntensity");
var _u_grainintensity       = shader_get_uniform(shd_retroscreen_screenfilter, "uFilmgrainIntensity");
var _u_brightness           = shader_get_uniform(shd_retroscreen_screenfilter, "uBrightness");
var _u_contrast             = shader_get_uniform(shd_retroscreen_screenfilter, "uContrast");
var _u_screentexelsize      = shader_get_uniform(shd_retroscreen_screenfilter, "uScreenTexelSize");
var _u_noisetexelsize       = shader_get_uniform(shd_retroscreen_screenfilter, "uNoiseTexelSize");
var _u_shadowmasktexelsize  = shader_get_uniform(shd_retroscreen_screenfilter, "uShadowmaskTexelSize");
var _samp_noise      = shader_get_sampler_index(shd_retroscreen_screenfilter, "uTexNoise");
var _samp_shadowmask = shader_get_sampler_index(shd_retroscreen_screenfilter, "uTexShadowmask");
shader_set_uniform_f(_u_time, _time); // time
shader_set_uniform_f(_u_shadowmaskintensity, crtShadowmask); // intensity of shadow mask effect
shader_set_uniform_f(_u_scanlineintensity, crtScanline); // intensity of scanline
shader_set_uniform_f(_u_bleendintensity, crtBleed); // intensity of colour bleed
shader_set_uniform_f(_u_bleendsize, crtBleedSize); // size of colour bleed
shader_set_uniform_f(_u_tintintensity, crtTint); // intensity of dynamic colour tint
shader_set_uniform_f(_u_vignetteintensity, crtVignette); // intensity of vignette
shader_set_uniform_f(_u_grainintensity, crtFilmgrain); // intensity of film grain
shader_set_uniform_f(_u_brightness, crtBrightness); // brightness boost adjustment
shader_set_uniform_f(_u_contrast, crtContrast); // contrast adjustment
shader_set_uniform_f(_u_screentexelsize, 1 / _surfw, 1 / _surfh); // texel size on surface that's being drawn
shader_set_uniform_f(_u_noisetexelsize, _texnoisetexelw, _texnoisetexelh); // texel size of noise texture
shader_set_uniform_f(_u_shadowmasktexelsize, _texshadowmasktexelw, _texshadowmasktexelh); // texel size of shadow mask texture
texture_set_stage(_samp_noise, _texnoise); // noise texture
texture_set_stage(_samp_shadowmask, _texshadowmask); // shadow mask texture

// Draw surface
draw_surface(surfaceScreen, 0, 0);

// Reset shader
shader_reset();
surface_reset_target();


/// Pass #2 : CRT Screen distortion + Border reflection
// Feed the results into the temp. surface #2
var _surfw = surface_get_width(surfacePPTemp1);
var _surfh = surface_get_height(surfacePPTemp1);
surface_set_target(surfacePPTemp2);

// Set the shader
shader_set(shd_retroscreen_distortion);
// Prepare the uniforms
var _u_time                 = shader_get_uniform(shd_retroscreen_distortion, "uTime");
var _u_distortionintensity  = shader_get_uniform(shd_retroscreen_distortion, "uScreenDistortIntensity");
var _u_reflectionintensity  = shader_get_uniform(shd_retroscreen_distortion, "uBorderReflectionIntensity");
var _u_specularcol          = shader_get_uniform(shd_retroscreen_distortion, "uSpecularLight");
var _u_specularpos          = shader_get_uniform(shd_retroscreen_distortion, "uSpecularLightOffset");
var _u_screentexelsize      = shader_get_uniform(shd_retroscreen_distortion, "uScreenTexelSize");
var _u_noisetexelsize       = shader_get_uniform(shd_retroscreen_distortion, "uNoiseTexelSize");
var _samp_noise             = shader_get_sampler_index(shd_retroscreen_distortion, "uTexNoise");
shader_set_uniform_f(_u_time, _time); // time
shader_set_uniform_f(_u_distortionintensity, crtDistortion); // screen distortion intensity
shader_set_uniform_f(_u_reflectionintensity, crtReflection); // border reflection intensity

// var _specr = (crtSpecularCol & $0000FF), _specg = (crtSpecularCol & $00FF00) >> 8, _specb = (crtSpecularCol & $FF0000) >> 16;
// shader_set_uniform_f(_u_specularcol, _specr / 255, _specg / 255, _specb / 255, crtSpecularAmp);
shader_set_uniform_f(_u_specularcol, crtSpecularR, crtSpecularG, crtSpecularB, crtSpecularAmp); // specular light colour properties (in vec4 format, rgb colour [in 0..1 range] with intensity)
shader_set_uniform_f(_u_specularpos, crtSpecularOffX, crtSpecularOffY); // specular light's offset from center
shader_set_uniform_f(_u_screentexelsize, 1 / _surfw, 1 / _surfh); // texel size on surface that's being drawn
shader_set_uniform_f(_u_noisetexelsize, _texnoisetexelw, _texnoisetexelh); // texel size of noise texture
texture_set_stage(_samp_noise, _texnoise); // noise texture

// Draw surface
draw_surface(surfacePPTemp1, 0, 0);

// Reset shader
shader_reset();
surface_reset_target();


/// Pass #3 : (final postprocessing effects) zoom blur with chromatic abberation
var _surfw = surface_get_width(surfacePPTemp2);
var _surfh = surface_get_height(surfacePPTemp2);
var _winw = window_get_width();
var _winh = window_get_height();

surface_set_target(surfacePPTemp3);
draw_clear(c_black);

// Set the shader
shader_set(shd_retroscreen_postprocessing);
// Prepare the uniforms
var _u_time             = shader_get_uniform(shd_retroscreen_postprocessing, "uTime");
var _u_glowfactor       = shader_get_uniform(shd_retroscreen_postprocessing, "uGlowFactor");
var _u_glowtint         = shader_get_uniform(shd_retroscreen_postprocessing, "uGlowTintIntensity");
var _u_blursize         = shader_get_uniform(shd_retroscreen_postprocessing, "uBlurSize");
var _u_blurzoom         = shader_get_uniform(shd_retroscreen_postprocessing, "uBlurZoomIntensity");
var _u_screentexelsize  = shader_get_uniform(shd_retroscreen_postprocessing, "uScreenTexelSize");
var _u_noisetexelsize   = shader_get_uniform(shd_retroscreen_postprocessing, "uNoiseTexelSize");
var _samp_noise         = shader_get_sampler_index(shd_retroscreen_postprocessing, "uTexNoise");
var _samp_rainbowlut    = shader_get_sampler_index(shd_retroscreen_postprocessing, "uTexRainbow");
shader_set_uniform_f(_u_time, _time); // time
shader_set_uniform_f(_u_glowfactor, crtGlowFactor); // factor/multiplier of glow (hard-capped at certain amount)
shader_set_uniform_f(_u_glowtint, crtGlowTint); // colour tint amount of blur (like chromatic aberration)
shader_set_uniform_f(_u_blursize, crtBlurSize); // half size of blur
shader_set_uniform_f(_u_blurzoom, crtBlurZoom); // zoom amount of blur
shader_set_uniform_f(_u_screentexelsize, 1 / _surfw, 1 / _surfh); // texel size on surface that's being drawn
shader_set_uniform_f(_u_noisetexelsize, _texnoisetexelw, _texnoisetexelh); // texel size of noise texture
texture_set_stage(_samp_noise, _texnoise); // noise texture
texture_set_stage(_samp_rainbowlut, _texrainbowlut); // RGB tint lookup texture

// Draw surface
draw_surface_stretched(surfacePPTemp2, 0, 0, surface_get_width(surfacePPTemp3), surface_get_height(surfacePPTemp3));

// Reset shader
shader_reset();
surface_reset_target();

// Draw the resulting surface
draw_surface_stretched(surfacePPTemp3, 0, 0, _winw, _winh);

/// Reset texture interpolation
texture_set_interpolation(false);


/// Update & draw immediate mode UI
iui_begin();
/// ====================================================
///     UI vars
/// ====================================================
var _UI_OFF_X = 0, _UI_OFF_Y = 0;
var _UI_CENTER_X = winWid * 0.5, _UI_CENTER_Y = winHei * 0.5;
var _UI_MARGIN = 16 * UIScale;
var _UI_MARGIN2 = _UI_MARGIN * 2;
var _UI_MARGIN_COLUMN = 200 * UIScale;
var _UI_TAB_Y = _UI_OFF_Y + 6 * UIScale;
var _UI_TAB_HEI = 32;
var _UI_MENU_HEI = 128 * UIScale;
var _UI_CONTENT_X = _UI_OFF_X + _UI_MARGIN * 2;
var _UI_CONTENT_Y = _UI_TAB_Y + _UI_TAB_HEI;
var _UI_CURRENT_Y = _UI_CONTENT_Y;
var _UI_ALPHA = 1.0;

/// ====================================================
///     Tabs
/// ====================================================
UI_TAB_IDX = iui_tab(_UI_OFF_X, _UI_TAB_Y, 64, _UI_TAB_HEI, UI_TAB_ELEMENTS, UI_TAB_IDX, 2);

/// ====================================================
///     Tab-specific UI
/// ====================================================
switch (UI_TAB_IDX)
{
    case eTABS.MAIN:
        // var _titlestr = "BJÖRTFX#MMXX ZIK##IDK shdfjhsdfjshda";
        var _titlescale = UIScale * 2;
        var _titleheight = sprite_get_height(sprLogo) * _titlescale; // string_height(_titlestr) * _titlescale;
        var _strscale = UIScale;
        
        _UI_MENU_HEI = 128 * UIScale + _UI_MARGIN * 2; // _titleheight + _UI_MARGIN * 2;
        
        // Backdrop
        iui_rect(_UI_OFF_X, _UI_CURRENT_Y, winWid, _UI_MENU_HEI, UI_BASE_COL);
        _UI_CURRENT_Y += _UI_MARGIN;
    
        // Logo / Info
        // iui_align_push(fa_center, fa_top);
        // iui_label_transform(_UI_CENTER_X, _UI_CURRENT_Y, _titlestr, _titlescale, _titlescale, 0, c_white, 1.0);
        // iui_align_pop();
        var _logoosc = cos(current_time * 0.001 * pi);
        var _logoy = _UI_CURRENT_Y + _logoosc * 8 * UIScale;
        draw_sprite_ext(sprLogo, 0, _UI_CENTER_X, _logoy, _titlescale, _titlescale, 0, c_white, 1.0);
        
        // Preset pictures
        var _picname = "PRESET IMG. : " + string(demoBGIdx + 1);
        iui_align_push(fa_left, fa_top);
        iui_label_transform(_UI_CONTENT_X, _UI_CURRENT_Y, _picname, _strscale, _strscale, 0, UI_ACCENT_COL, 1.0);
        iui_align_pop();
        _UI_CURRENT_Y += _UI_MARGIN2;
        
        // Button
        var _buttonw = 32 * UIScale;
        var _buttonw2 = _buttonw * 2 + _UI_MARGIN;
        var _buttonh = 32 * UIScale;
        var _prev = iui_button(_UI_CONTENT_X, _UI_CURRENT_Y, _buttonw, _buttonh, "<##PREV_BG");
        var _next = iui_button(_UI_CONTENT_X + _buttonw + _UI_MARGIN, _UI_CURRENT_Y, _buttonw, _buttonh, ">##NEXT_BG");
        var _load = iui_button(_UI_CONTENT_X, _UI_CURRENT_Y + _buttonh + _UI_MARGIN, _buttonw2, _buttonh, "LOAD...##SET_BG");
        var _save = iui_button(winWid - _buttonw2 * 2 - _UI_MARGIN, _UI_CURRENT_Y, _buttonw2 * 2, _buttonh, "EXPORT IMG...##SET_BG");
        
        if (_prev || _next)
        {
            var _bgoffset = _next - _prev;
            var _bglistsz = array_length_1d(demoBGList);
            demoBGIdx = (demoBGIdx + _bgoffset + _bglistsz) % _bglistsz;
            demoState = eDEMO_STATE.DEFAULT;
        }
        
        if (_load)
        {
            // var _dir = get_open_filename_ext("image files|*.png;*.gif|*.jpg|*.jpeg", "", working_directory, "Select an image to load...");
            var _dir = get_open_filename_ext(".PNG image file|*.png", "", working_directory, "Select an image to load...");
            if (_dir != "" && file_exists(_dir))
            {
                demoCustomBGDir = _dir;
                
                if (background_exists(demoCustomBG))
                    background_delete(demoCustomBG);
                demoCustomBG = background_add(_dir, false, false);
                
                if (background_exists(demoCustomBG))
                {
                    UIMsg = "SUCCESSFULLY LOADED THE IMAGE!";
                    UIMsgCtr = room_speed * 3.0;
                    demoState = eDEMO_STATE.CUSTOM;
                }
                else
                {
                    UIMsg = "UNABLE TO LOAD THE IMAGE!#(only .png formats are supported as of now)";
                    UIMsgCtr = room_speed * 3.0;
                    demoState = eDEMO_STATE.DEFAULT;
                }
            }
        }
        else if (_save)
        {
            var _dir = get_save_filename_ext(".PNG image file|*.png", "", working_directory, "Save image to where?");
            if (_dir != "")
            {
                surface_save(surfacePPTemp3, _dir);
                UIMsg = "IMAGE EXPORTED!";
                UIMsgCtr = room_speed * 3.0;
            }
        }
        _UI_CURRENT_Y += _UI_MARGIN2;
        
        _UI_CURRENT_Y += _titleheight;
        break;
        
    case eTABS.CONFIG_SCREEN:
        var _itemx1 = _UI_CONTENT_X;
        var _itemx2 = _itemx1 + _UI_MARGIN_COLUMN;
        var _itemx3 = _itemx2 + _UI_MARGIN_COLUMN;
        
        var _sliderx1 = _itemx1 + 64 * UIScale;
        var _sliderx2 = _itemx2 + 64 * UIScale;
        var _sliderx3 = _itemx3 + 64 * UIScale;
        
        var _sliderw = 128 * UIScale;
        var _sliderhalfh = iuiSliderHHei * 0.5;
        var _titlescale = UIScale;
        var _strscale = UIScale * 0.5;
    
        // Update UI alpha
        if (!point_in_rectangle(iui_inputX, iui_inputY, _UI_OFF_X, _UI_CURRENT_Y, _UI_OFF_X + _sliderx3 + _UI_MARGIN_COLUMN, _UI_CURRENT_Y + _UI_MENU_HEI))
            _UI_ALPHA = 0.25;
    
        // Backdrop
        iui_rect_alpha(_UI_OFF_X, _UI_CURRENT_Y, _sliderx3 + _UI_MARGIN_COLUMN, _UI_MENU_HEI, UI_BASE_COL, _UI_ALPHA);
        // _UI_CURRENT_Y += _UI_MARGIN;
        
        /// 1st column
        /// CRT emulation params
        iui_align_push(fa_left, fa_top);
        iui_label_transform(_itemx1, _UI_CURRENT_Y, "CRT SCREEN", _titlescale, _titlescale, 0, c_white, _UI_ALPHA);
        _UI_CURRENT_Y += _UI_MARGIN2;
        iui_align_pop();
        
        // distortion intensity
        iui_align_push(fa_right, fa_middle);
        iui_label_transform(_sliderx1, _UI_CURRENT_Y + _sliderhalfh, "DISTORTION ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtDistortion = iui_slider_h(_sliderx1, _UI_CURRENT_Y, crtDistortion, _sliderw, -1, 2, "DISTORTION");
        _UI_CURRENT_Y += _UI_MARGIN;
        
        // reflection intensity
        iui_label_transform(_sliderx1, _UI_CURRENT_Y + _sliderhalfh, "REFLECTION ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtReflection = iui_slider_h(_sliderx1, _UI_CURRENT_Y, crtReflection, _sliderw, 0, 1, "REFLECTION");
        _UI_CURRENT_Y += _UI_MARGIN;
        
        // shadow mask intensity
        iui_label_transform(_sliderx1, _UI_CURRENT_Y + _sliderhalfh, "SHADOWMASK ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtShadowmask = iui_slider_h(_sliderx1, _UI_CURRENT_Y, crtShadowmask, _sliderw, 0, 1, "SHADOWMASK");
        _UI_CURRENT_Y += _UI_MARGIN;
        // iui_align_pop();
        
        /// 2nd column
        _UI_CURRENT_Y = _UI_CONTENT_Y + _UI_MARGIN2;
        
        // scanline
        // iui_align_push(fa_right, fa_middle);
        iui_label_transform(_sliderx2, _UI_CURRENT_Y + _sliderhalfh, "SCANLINE ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtScanline = iui_slider_h(_sliderx2, _UI_CURRENT_Y, crtScanline, _sliderw, 0, 1, "SCANLINE");
        _UI_CURRENT_Y += _UI_MARGIN;
        
        // colour bleed
        iui_label_transform(_sliderx2, _UI_CURRENT_Y + _sliderhalfh, "BLEED AMP. ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtBleed = iui_slider_h(_sliderx2, _UI_CURRENT_Y, crtBleed, _sliderw, 0, 1, "BLEED_AMP");
        _UI_CURRENT_Y += _UI_MARGIN;
        
        // colour bleed size
        iui_label_transform(_sliderx2, _UI_CURRENT_Y + _sliderhalfh, "BLEED SZ. ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtBleedSize = iui_slider_h(_sliderx2, _UI_CURRENT_Y, crtBleedSize, _sliderw, -128, 128, "BLEED_SZ");
        _UI_CURRENT_Y += _UI_MARGIN;
        // iui_align_pop();
        
        // dynamic colour tint
        iui_label_transform(_sliderx2, _UI_CURRENT_Y + _sliderhalfh, "COL. TINT ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtTint = iui_slider_h(_sliderx2, _UI_CURRENT_Y, crtTint, _sliderw, 0, 1, "TINT_AMP");
        _UI_CURRENT_Y += _UI_MARGIN;
        
        /// 3nd column
        _UI_CURRENT_Y = _UI_CONTENT_Y + _UI_MARGIN2;
        
        // vignette
        iui_label_transform(_sliderx3, _UI_CURRENT_Y + _sliderhalfh, "VIGNETTE ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtVignette = iui_slider_h(_sliderx3, _UI_CURRENT_Y, crtVignette, _sliderw, 0, 1, "VIGNETTE");
        _UI_CURRENT_Y += _UI_MARGIN;
        
        // film grain
        iui_label_transform(_sliderx3, _UI_CURRENT_Y + _sliderhalfh, "Film grain ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtFilmgrain = iui_slider_h(_sliderx3, _UI_CURRENT_Y, crtFilmgrain, _sliderw, 0, 1, "FILMGRAIN");
        _UI_CURRENT_Y += _UI_MARGIN;
        iui_align_pop();
        break;
        
    case eTABS.CONFIG_SCREEN2:
        var _itemx1 = _UI_CONTENT_X;
        var _itemx2 = _itemx1 + _UI_MARGIN_COLUMN;
        var _itemx3 = _itemx2 + _UI_MARGIN_COLUMN;
        
        var _sliderx1 = _itemx1 + 64 * UIScale;
        var _sliderx2 = _itemx2 + 64 * UIScale;
        var _sliderx3 = _itemx3 + 64 * UIScale;
        
        var _sliderw = 128 * UIScale;
        var _sliderhalfh = iuiSliderHHei * 0.5;
        var _titlescale = UIScale;
        var _strscale = UIScale * 0.5;
        
        // Update UI alpha
        if (!point_in_rectangle(iui_inputX, iui_inputY, _UI_OFF_X, _UI_CURRENT_Y, _UI_OFF_X + _sliderx3 + _UI_MARGIN_COLUMN, _UI_CURRENT_Y + _UI_MENU_HEI))
            _UI_ALPHA = 0.25;
        
        // Backdrop
        iui_rect_alpha(_UI_OFF_X, _UI_CURRENT_Y, _sliderx3 + _UI_MARGIN_COLUMN, _UI_MENU_HEI, UI_BASE_COL, _UI_ALPHA);
        // _UI_CURRENT_Y += _UI_MARGIN;
        
        /// CRT emulation params
        iui_align_push(fa_left, fa_top);
        iui_label_transform(_itemx1, _UI_CURRENT_Y, "COLOUR", _titlescale, _titlescale, 0, c_white, _UI_ALPHA);
        _UI_CURRENT_Y += _UI_MARGIN2;
        iui_align_pop();
        
        // brightness
        iui_align_push(fa_right, fa_middle);
        iui_label_transform(_sliderx1, _UI_CURRENT_Y + _sliderhalfh, "BRIGHTNESS ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtBrightness = iui_slider_h(_sliderx1, _UI_CURRENT_Y, crtBrightness, _sliderw, -1, 2, "BRIGHTNESS");
        _UI_CURRENT_Y += _UI_MARGIN;
        
        // contrast
        iui_label_transform(_sliderx1, _UI_CURRENT_Y + _sliderhalfh, "CONTRAST ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtContrast = iui_slider_h(_sliderx1, _UI_CURRENT_Y, crtContrast, _sliderw, 0, 2, "CONTRAST");
        _UI_CURRENT_Y += _UI_MARGIN;
        iui_align_pop();
        
        /// Specular light
        _UI_CURRENT_Y = _UI_CONTENT_Y;
        iui_align_push(fa_left, fa_top);
        iui_label_transform(_itemx2, _UI_CURRENT_Y, "SCREEN SPECULAR", _titlescale, _titlescale, 0, c_white, _UI_ALPHA);
        _UI_CURRENT_Y += _UI_MARGIN2;
        iui_align_pop();
        
        // red
        iui_align_push(fa_right, fa_middle);
        iui_label_transform(_sliderx2, _UI_CURRENT_Y + _sliderhalfh, "R ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtSpecularR = iui_slider_h(_sliderx2, _UI_CURRENT_Y, crtSpecularR, _sliderw, 0, 1, "RED");
        _UI_CURRENT_Y += _UI_MARGIN;
        
        // green
        iui_label_transform(_sliderx2, _UI_CURRENT_Y + _sliderhalfh, "G ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtSpecularG = iui_slider_h(_sliderx2, _UI_CURRENT_Y, crtSpecularG, _sliderw, 0, 1, "GRN");
        _UI_CURRENT_Y += _UI_MARGIN;
        
        // blue
        iui_label_transform(_sliderx2, _UI_CURRENT_Y + _sliderhalfh, "B ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtSpecularB = iui_slider_h(_sliderx2, _UI_CURRENT_Y, crtSpecularB, _sliderw, 0, 1, "BLU");
        _UI_CURRENT_Y += _UI_MARGIN;
        
        // amplitude
        iui_label_transform(_sliderx2, _UI_CURRENT_Y + _sliderhalfh, "AMP. ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtSpecularAmp = iui_slider_h(_sliderx2, _UI_CURRENT_Y, crtSpecularAmp, _sliderw, 0, 1, "SPECULAR_AMP");
        _UI_CURRENT_Y += _UI_MARGIN;
        // iui_align_pop();
        
        /// Specular light : position
        _UI_CURRENT_Y = _UI_CONTENT_Y + _UI_MARGIN2;
        
        // red
        // iui_align_push(fa_right, fa_middle);
        iui_label_transform(_sliderx3, _UI_CURRENT_Y + _sliderhalfh, "X OFF. ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtSpecularOffX = iui_slider_h(_sliderx3, _UI_CURRENT_Y, crtSpecularOffX, _sliderw, -1, 1, "SPECULAR_X");
        _UI_CURRENT_Y += _UI_MARGIN;
        
        // green
        iui_label_transform(_sliderx3, _UI_CURRENT_Y + _sliderhalfh, "Y OFF. ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtSpecularOffY = iui_slider_h(_sliderx3, _UI_CURRENT_Y, crtSpecularOffY, _sliderw, -1, 1, "SPECULAR_Y");
        _UI_CURRENT_Y += _UI_MARGIN;
        iui_align_pop();
        break;
        
    case eTABS.CONFIG_POSTFX:
        var _itemx1 = _UI_CONTENT_X;
        var _itemx2 = _itemx1 + _UI_MARGIN_COLUMN;
        var _itemx3 = _itemx2 + _UI_MARGIN_COLUMN;
        
        var _sliderx1 = _itemx1 + 64 * UIScale;
        var _sliderx2 = _itemx2 + 64 * UIScale;
        var _sliderx3 = _itemx3 + 64 * UIScale;
        
        var _sliderw = 128 * UIScale;
        var _sliderhalfh = iuiSliderHHei * 0.5;
        var _titlescale = UIScale;
        var _strscale = UIScale * 0.5;
        
        // Update UI alpha
        if (!point_in_rectangle(iui_inputX, iui_inputY, _UI_OFF_X, _UI_CURRENT_Y, _UI_OFF_X + _itemx2, _UI_CURRENT_Y + _UI_MENU_HEI))
            _UI_ALPHA = 0.25;
        
        // Backdrop
        iui_rect_alpha(_UI_OFF_X, _UI_CURRENT_Y, _itemx2, _UI_MENU_HEI, UI_BASE_COL, _UI_ALPHA);
        
        /// Final FX configs
        iui_align_push(fa_left, fa_top);
        iui_label_transform(_itemx1, _UI_CURRENT_Y, "FINAL FX.", _titlescale, _titlescale, 0, c_white, _UI_ALPHA);
        _UI_CURRENT_Y += _UI_MARGIN2;
        iui_align_pop();
        
        // glow factor
        iui_align_push(fa_right, fa_middle);
        iui_label_transform(_sliderx1, _UI_CURRENT_Y + _sliderhalfh, "GLOW FACTOR ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtGlowFactor = iui_slider_h(_sliderx1, _UI_CURRENT_Y, crtGlowFactor, _sliderw, 0, 1, "GLOW_AMP");
        _UI_CURRENT_Y += _UI_MARGIN;
        
        // glow's colour tint amount
        iui_label_transform(_sliderx1, _UI_CURRENT_Y + _sliderhalfh, "GLOW TINT ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtGlowTint = iui_slider_h(_sliderx1, _UI_CURRENT_Y, crtGlowTint, _sliderw, 0, 1, "GLOW_TINT");
        _UI_CURRENT_Y += _UI_MARGIN;
        
        // blur size
        iui_label_transform(_sliderx1, _UI_CURRENT_Y + _sliderhalfh, "BLUR SIZE ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtBlurSize = iui_slider_h(_sliderx1, _UI_CURRENT_Y, crtBlurSize, _sliderw, 0, 32, "BLUR_SZ");
        _UI_CURRENT_Y += _UI_MARGIN;
        
        // blur zoom amount
        iui_label_transform(_sliderx1, _UI_CURRENT_Y + _sliderhalfh, "BLUR ZOOM ", _strscale, _strscale, 0, UI_ACCENT_COL, _UI_ALPHA);
        _UI_CURRENT_Y += 8 * UIScale;
        crtBlurZoom = iui_slider_h(_sliderx1, _UI_CURRENT_Y, crtBlurZoom, _sliderw, 0, 1, "BLUR_ZOOM");
        _UI_CURRENT_Y += _UI_MARGIN;
        iui_align_pop();
        break;
}

/// UI Message
if (UIMsgCtr > 0)
{
    var _msgscale = 3 * UIScale;
    iui_align_center();
    iui_label_shadow(_UI_CENTER_X, winHei * 0.8, UIMsg, iuPiss, _msgscale, _msgscale, c_black);
    iui_align_pop();
}

iui_end();


