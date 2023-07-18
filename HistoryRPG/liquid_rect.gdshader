shader_type canvas_item;
render_mode unshaded;

uniform float HealthAmount : hint_range(0,1) = 1;
uniform vec4 HealthColor : source_color = vec4(0.64,0.08,0.08,1.0);
uniform float WaveSpeed : hint_range(0.01,10.0) = 5.0;
uniform float WavePeriod : hint_range(0.1,10) = 3.0;
uniform float WaveAmplitude : hint_range(0,0.35) = 0.25;

void fragment()
{
    // construct sinewave value that varies horizontally based on speed and period
    float sin_wave = sin( ( TIME + ( UV.x / WavePeriod ) ) * WaveSpeed );
    // normalise to 0..1
    float scaled_sin_wave = (sin_wave * 0.5) + 0.5;
    // value to smoothly lower the amplitude near the full and empty health levels
    float wave_amp_scale = min( smoothstep(1.0, 1.0-WaveAmplitude, HealthAmount),  smoothstep(0.0, WaveAmplitude*2.0, HealthAmount) );
    // compute the wave testing value
    float wave_test_val = HealthAmount - scaled_sin_wave * WaveAmplitude * wave_amp_scale ;
    // test it against the fragment y value
    float wave = (1.0-UV.y) < wave_test_val ? 1.0 : 0.0;
    // output
    COLOR.rgb = HealthColor.rgb;
    COLOR.a = wave * HealthColor.a;
}