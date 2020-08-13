//
/*
    Post processing : final postprocessing effects, glow using zoom blur with chromatic abberation
    ZIK@MMXX
*/
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float uTime; // time
uniform float uGlowFactor; // amplitude/factor of glow (hard capped at certain amount)
uniform float uGlowTintIntensity; // tint amount of glow (in 0...1 range)
uniform float uBlurSize; // size of blur
uniform float uBlurZoomIntensity; // zoom amount of blur (in 0...1 range)

uniform sampler2D uTexNoise;    // noise texture
uniform sampler2D uTexRainbow;  // RGB tint texture for chromatic aberration

uniform vec2 uScreenTexelSize;  // size of single texel on surface that's being drawn
uniform vec2 uNoiseTexelSize;   // size of single texel on noise texture

// Distorts UV like a CRT monitor
vec2 getCRTUV (vec2 uv, float distortion)
{
    vec2 centerDelta = vec2(0.5) - uv;
    float centerDist = length(centerDelta);
    float distortfactor = centerDist;
    uv -= 0.5;
    uv *= mix(1.0, 1.0 + distortion, distortfactor);
    uv += 0.5;
    return uv;
}

// Samples noise and returns float with range of [0..1]
float noise (vec2 uv)
{
    return texture2D(uTexNoise, fract(floor(uv / uScreenTexelSize) * uNoiseTexelSize + vec2(uTime * 32.0))).r;
}

vec3 sampleScreen (vec2 uv, float zoom, float distortion)
{
    // float distortion = zoom * 0.25;
    vec2 centerDelta = vec2(0.5) - uv;
    float centerDist = length(centerDelta);
    float distortfactor = centerDist;
    uv -= 0.5;
    uv *= mix(1.0, 1.0 + distortion, distortfactor);
    uv /= zoom;
    uv += 0.5;
    
    return texture2D(gm_BaseTexture, uv).rgb;
}

void main()
{
    vec2 uv = v_vTexcoord;
    vec3 final = texture2D(gm_BaseTexture, uv).rgb;
    float dithernoise = noise(uv);
    
    /// Apply zooming blur with chromatic aberration
    vec3 glowblur = vec3(0.0);
    const float blurIteration       = 8.0;
    const float blurIterationStep   = 1.0 / blurIteration;
    const float blurIterationWeight = 1.0 / (blurIteration + 1.0);
    for (float i=0.0; i<=(1.0 - blurIterationStep); i+=blurIterationStep)
    {
        // dither up
        float i_interp = i + blurIterationStep * dithernoise;
        vec2 uvoff = vec2((i_interp - 0.5) * 2.0 * uBlurSize * uScreenTexelSize.x, 0.0);
        float zoomoff = ((i_interp - 0.5) * 2.0 * uBlurZoomIntensity);
        
        // calculate 'tint' from rainbow/chromatic aberration lookup texture
        vec3 tint = mix(vec3(1.0), texture2D(uTexRainbow, vec2(i_interp, 0.5)).rgb, uGlowTintIntensity);
        
        vec3 col = tint * sampleScreen(uv + uvoff, 1.0 - zoomoff, zoomoff).rgb;
        glowblur += col * blurIterationWeight;
    }
    
    // Apply w/ bias
    // const float blurGlowFactor = 0.75;
    const vec3 blurGlowMax  = vec3(0.3, 0.425, 0.5);
    final += clamp(glowblur * uGlowFactor, vec3(0.0), blurGlowMax);
    
    gl_FragColor = v_vColour * vec4(final, 1.0);
}
