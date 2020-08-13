//
// Simple passthrough fragment shader
//
#define MOTIONBLUR
#define PI 3.14

#define GRID_UV_ZOOM 10.0
#define GRID_NOISE_ZOOM 2.0
#define GRID_NUM vec2(8.0)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float uTime;
uniform vec2 uScreenResolution;
uniform sampler2D uBayer; // iChannel0

// Noise & rand function from
// https://gist.github.com/patriciogonzalezvivo/670c22f3966e662d2f83
float rand(vec2 n)
{ 
	return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

float noise(vec2 p)
{
	vec2 ip = floor(p);
	vec2 u = fract(p);
	u = u*u*(3.0-2.0*u);
	
	float res = mix(
		mix(rand(ip),rand(ip+vec2(1.0,0.0)),u.x),
		mix(rand(ip+vec2(0.0,1.0)),rand(ip+vec2(1.0,1.0)),u.x),u.y);
	return res*res;
}
////

// HSV to RGB conversion function from
// https://stackoverflow.com/questions/15095909/from-rgb-to-hsv-in-opengl-glsl
vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}
////

float getGridContent (vec2 p)
{
    const float noiseTreshold = 0.4;
    float val = noise(p * GRID_NOISE_ZOOM);
    val = clamp(ceil(val - noiseTreshold), 0.0, 1.0);
    
   	return val;
}

float sampleDither (vec2 uv)
{
    vec2 screenuv = uv * uScreenResolution;
    return texture2D(uBayer, fract(screenuv / vec2(8.0))).r;
}

float dither (vec2 uv, float v1, float v2, float treshold)
{
    float dither = sampleDither(uv);
    if (dither < treshold)
    	return v1;
   	return v2;
}

vec3 sampleGrid (vec2 uv)
{
    vec3 col = vec3(1.0);
    
	// get grid UV
    vec2 gridUV = floor(uv * GRID_NUM) / GRID_NUM;
    vec2 gridLocalUV = fract(uv * GRID_NUM);
    
    // get grid contents
    float grid = getGridContent(gridUV);
    col = vec3(grid);
    return col;
}

vec3 sampleScreen (vec2 uv, float t)
{
    vec3 col = vec3(0.0);
    
    // aspect ratio/factor
    vec2 uvAspectFactor = vec2(uScreenResolution / uScreenResolution.x);
    
    float time = t * 2.0;
    float timeInt = floor(time);
    float timeFrac = fract(time);
    
    const float iterations = 7.0;
    const float iterationsInv = 1.0 / iterations;
    const vec2 iterationUVOff = vec2(420.0, 512.0);
    const float iterationZoomStep = (1.0 / iterations) * 2.0;
    const float iterationHalf = iterations * 0.5;
    
    const float animWeight = 1.0;
    float iterationAnimT = pow(1.0 - pow(1.0 - timeFrac, animWeight), animWeight);
    float iterationZoom = iterationAnimT;
    float iterationZoomOff = iterationZoom * iterationZoomStep;
    float iterationZoomShadeOff = iterationZoom * iterationsInv;
    
    for (float i=0.0; i<=iterations; i+=1.0)
    {
        float layerTime = time;
        float layerInterp = i * iterationsInv;
        float layerInterpZoom = clamp((1.0 - layerInterp) - iterationZoomShadeOff, 0.0, 1.0);
        
        float layerNumCentered = i - iterationHalf;
        float layerZoom = (layerNumCentered * iterationZoomStep + iterationZoomOff);
        float layerAngle = layerTime * 0.1 + cos(layerTime) * PI * 0.1 * (1.0 + (layerInterpZoom - 0.5));
        
        float layerIndexOff = (i - timeInt);
        
        vec2 layerGridOff = iterationUVOff * layerIndexOff;
        vec3 layerTint = hsv2rgb(vec3(layerIndexOff * 0.1, 0.25, 0.5));
        
        // transform grid
        vec2 layerUV = uv;
        layerUV -= 0.5;
        layerUV *= uvAspectFactor;
        layerUV *= mat2(cos(layerAngle), -sin(layerAngle),
                       	sin(layerAngle), cos(layerAngle));
        layerUV *= 1.0 / uvAspectFactor;
            
        layerUV *= (1.0 + iterationZoomStep - layerZoom);
        layerUV += 0.5;
        layerUV *= uvAspectFactor * GRID_UV_ZOOM;
        layerUV += vec2(layerTime + cos(layerTime * PI * 0.15 + PI) * 4.0, layerTime + sin(layerTime * 0.5 * PI));
        layerUV += layerGridOff;
        
        // visualize grid
        float layerAlpha = mix(1.0, 1.0 - iterationZoom, max(layerInterp + iterationZoomShadeOff - 1.0, 0.0) / iterationsInv);
        float layerShadeInterp = layerInterpZoom;
        float layerShade = 1.0 - layerShadeInterp;
        float layerMask = sampleGrid(layerUV).r;
        layerTint *= layerShade;
        
        col = mix(col, layerTint, layerMask * layerAlpha);
    }
    
    return col;
}

void main ()
{
    vec2 uv = v_vTexcoord;
    vec3 col = vec3(0.0);
    col = sampleScreen(uv, uTime);
    
    // output to screen
    gl_FragColor = vec4(col,1.0);
}