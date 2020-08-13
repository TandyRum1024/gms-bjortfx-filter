/// @description  Set surface target
surface_set_target(surfaceScreen);
draw_clear(c_black);

switch (demoState)
{
    case eDEMO_STATE.DEFAULT:
        demoBGCurrent = demoBGList[@ demoBGIdx];
        
        if (!background_exists(demoBGCurrent))
        {
            // Draw background
            var _tex_bayer = sprite_get_texture(texBluenoise, 0);
            
            shader_set(shd_misc_bg);
            
            // Set uniform
            var _u_time = shader_get_uniform(shd_misc_bg, "uTime");
            var _u_resolution = shader_get_uniform(shd_misc_bg, "uScreenResolution");
            var _samp_bayer = shader_get_sampler_index(shd_misc_bg, "uBayer");
            shader_set_uniform_f(_u_time, current_time * 0.001);
            shader_set_uniform_f(_u_resolution, surfaceScreenWid, surfaceScreenHei);
            texture_set_stage(_samp_bayer, _tex_bayer);
            
            // Draw primitive : fullscreen quad for shader based background
            draw_primitive_begin_texture(pr_trianglestrip, -1);
            draw_vertex_texture(0, 0, 0, 0);
            draw_vertex_texture(surfaceScreenWid, 0, 1, 0);
            draw_vertex_texture(0, surfaceScreenHei, 0, 1);
            draw_vertex_texture(surfaceScreenWid, surfaceScreenHei, 1, 1);
            draw_primitive_end();
            shader_reset();
            
            // Draw logo
            var _logot = current_time * 0.001 * pi;
            var _logoscale = 2.0 * UIScale;
            var _logooscampx = surfaceScreenWid * 0.5;
            var _logooscampy = surfaceScreenHei * 0.5;
            var _logox = (surfaceScreenWid + cos(_logot) * _logooscampx) * 0.5;
            var _logoy = (surfaceScreenHei - sin(_logot) * _logooscampy - sprite_get_height(sprLogo) * _logoscale) * 0.5;
            draw_sprite_ext(sprLogo, 0, _logox + 16, _logoy + 16, _logoscale, _logoscale, sin(_logot) * 4, c_black, 0.5);
            draw_sprite_ext(sprLogo, 0, _logox, _logoy, _logoscale, _logoscale, sin(_logot) * 4, c_white, 1.0);
        }
        break;
}

