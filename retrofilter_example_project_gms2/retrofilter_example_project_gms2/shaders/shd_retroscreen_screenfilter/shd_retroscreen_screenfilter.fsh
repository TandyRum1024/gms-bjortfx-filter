//
/*
    Post processing : CRT screen filter that handles shadowmask, screen tint, colour bleeding etc..
    ZIK@MMXX
*/
// uncomment this to debug / display the screen tint effect
// #define acid
#define PI 3.14159265359

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// set up the uniforms
uniform float uTime; // time (used for offseting the noise texture & dynamic screen tint)
uniform float uShadowmaskIntensity; // intensity of shadow mask effect (in 0..1 range)
uniform float uScanlineIntensity; // intensity of scanline
uniform float uTintIntensity; // intensity of colour tint
uniform float uFilmgrainIntensity; // intensity of film grain
uniform float uVignetteIntensity; // intensity of vignette
uniform float uBrightness;      // brightness boost
uniform float uContrast;        // contrast
uniform float uBleedIntensity; // colour bleed intensity
uniform float uBleedSize; // colour bleed size

uniform sampler2D uTexNoise;    // noise texture
uniform sampler2D uTexShadowmask; // shadow mask for CRT effect
// uniform sampler2D uTexRainbow;  // RGB tint lookup texture for hacky chromatic aberration effect

uniform vec2 uScreenTexelSize;  // size of single texel on surface that's being drawn
uniform vec2 uNoiseTexelSize;   // size of single texel on noise texture
uniform vec2 uShadowmaskTexelSize; // size of single texel on shadow mask texture

// Samples noise texture from given uv and returns float with range of [0..1]
float noise (vec2 uv)
{
    return texture2D(uTexNoise, fract(uv / uScreenTexelSize * uNoiseTexelSize + vec2(uTime * 32.0))).r;
}

// Samples shadow mask texture from given uv
vec3 sampleShadowmask (vec2 uv)
{
    const float shadowmaskuvscale = 6.0;
    return mix(vec3(1.0), texture2D(uTexShadowmask, fract(uv / uScreenTexelSize * uShadowmaskTexelSize * shadowmaskuvscale)).rgb, uShadowmaskIntensity);
}

// Samples rainbow tint
vec3 sampleRainbowtint (vec2 uv, float invscale)
{
    // domain warp the uv
    const float warpintensity = 0.1;
    uv.x += sin(uv.y * 2.0 * PI + uTime) * warpintensity;
    uv.y += cos(uv.x * 3.0 * PI + 0.5 * PI + uTime) * warpintensity;
    
    // scale the uv
    uv *= invscale;
    
    // generate the plasma effect
    // idea from https://www.shadertoy.com/view/Md23DV
    vec4 waves = vec4(
        sin(uv.x + uTime),
        sin(uv.y + uTime),
        sin(uv.x + uv.y + uTime),
        sin(length(0.5 - uv) + uTime)
        );
    float plasma = (waves.x + waves.y + waves.z + waves.w);
    return vec3(sin(plasma), sin(plasma + PI), sin(plasma + PI * 0.5)) * 0.5 + 0.5;
}

// Applies power curve to given colour for adjusting the contrast and brightness
// https://forum.unity.com/threads/shader-function-to-adjust-texture-contrast.457635/
vec3 applyColourAdjustment (vec3 col, float contrast, float brightness)
{
    col = clamp(col + brightness, 0.0, 1.0);
    return pow(abs(col * 2.0 - 1.0), vec3(1.0 / max(contrast, 0.0001))) * sign(col - 0.5) + 0.5;
}

void main()
{
    vec2 uv = v_vTexcoord;
    vec3 final = v_vColour.rgb * texture2D( gm_BaseTexture, uv ).rgb;
    
    /// Current pixel's dithering value, fetched from dithering noise texture
    float dithernoise = noise(uv);
    
    /// Apply colour bleeding effect
    vec3 bleedtreshold = vec3(0.4, 0.5, 0.3); // minimum threshold value of colourbleed for each colour channel
    vec3 bleedtint     = vec3(1.0, 0.8, 0.9); // colourbleed's tint
    vec2 bleeduvoffset = vec2(uScreenTexelSize.x * -uBleedSize * (dithernoise - 0.3), 0.0); // uv offset used for sampling screen texture
    // (get neighbor's rgb colour)
    vec3 neighbor = texture2D(gm_BaseTexture, uv + bleeduvoffset).rgb;
    // (calculate colourbleed's final intensity from rgb colour and add to final colour)
    float finalluma = (final.r + final.g + final.b) / 3.0;
    vec3 neighbormixfactor = smoothstep(bleedtreshold, vec3(0.9), neighbor) * (smoothstep(1.0, 0.0, finalluma) * 0.8 + 0.2);
    final += neighbor * neighbormixfactor * uBleedIntensity * bleedtint;
    
    // (clamp colours to 0..1 range)
    final = clamp(final, 0.0, 1.0);
    
    /// Apply screen tint
    // (static tint, based on the UV coordinates)
    final.r *= mix(0.85, 1.1, uv.y);
    final.b *= mix(0.95, 1.2, abs(uv.x - 0.5) * 2.0);
    
    // (apply 'dynamic' tint, based on the plasma effect)
    // float dynamictintintensity = 0.1;
    vec3 rainbowtint = mix(vec3(1.0), sampleRainbowtint(uv, 10.0), uTintIntensity);
    final *= rainbowtint;
    
    /// Apply scanline and shadowmask effect
    float scanlinenum   = (1.0 / uScreenTexelSize.y) / 4.0;
    float scanline      = mix(1.0 - uScanlineIntensity, 1.0, abs(0.5 - fract(uv.y * scanlinenum)) * 2.0);
    vec3 shadowmask     = sampleShadowmask(uv);
    final *= shadowmask * scanline;
    
    /// Apply constrast & brightness
    final = applyColourAdjustment(final, uContrast, uBrightness);
    
    /// Apply vignette + film grain
    finalluma = (final.r + final.g + final.b) / 3.0; // screen's luma (brightness)
    
    vec2 grainIntensity = vec2(0.05, uFilmgrainIntensity); // min/max grain intensity
    const float vignetteSize = 0.02; // size of vignette
    float centerDist = smoothstep(0.5, 0.7, length(vec2(0.5) - uv));
    float centerDistVignette = max(
        smoothstep(0.7 - vignetteSize, 0.7, length(vec2(0.5) - uv)),
        smoothstep(0.5 - vignetteSize, 0.5, max(abs(0.5 - uv.x), abs(0.5 - uv.y)))
        );
    
    // (calculate vignette from distance from center of the screen)
    final.rgb *= mix(1.0, 0.0, centerDistVignette * uVignetteIntensity);
    
    // (calculate film grain from distance from center of the screen & noises)
    float filmgrain  = mix(grainIntensity.x, grainIntensity.y, centerDist) * smoothstep(1.0, 0.0, finalluma);
    final.rgb += vec3(dithernoise, noise(uv.yx), noise(vec2(1.0 - uv.x, uv.y))) * filmgrain;
    
    // Debug : dynamic screen tint effect display
    #ifdef acid
    final.rgb = rainbowtint;
    #endif
    
    gl_FragColor = vec4(final, 1.0); // v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
