#define WIND_SPEED 8.0
#define WIND_WAVES_LENGTH 0.25
#define WIND_WAVES_AMPLITUDE 0.03125
#define WIND_IMPULSES_SPEED 1.0
#define WIND_IMPULSE_CUT 4.0 // higher number - shorter impulse
#define RAIN_WIND_AMPLITUDE_BOOST 1.0
#define RAIN_WIND_SPEED_BOOST 2.0

float calculateVegetationAnimation (vec3 position, float isRain) {
    vec3 correctedRawPos = position / 2.5463;//2.55 - size of chunk (prevent leaves detaching)
		highp float t = TIME;
		float wavesScale = WIND_WAVES_AMPLITUDE;
		float wavesMovingSpeed = WIND_SPEED * (1.0 + floor(isRain + 0.5) * RAIN_WIND_SPEED_BOOST);

		// Wind impulses
		float impulseDuration = WIND_IMPULSE_CUT / (1.0 + isRain * 2.0);// Bigger number = shorter impulse
		float f = sin(correctedRawPos.x + WIND_IMPULSES_SPEED * t) * 0.5 + 0.5;
		f = clamp(pow(f, impulseDuration), 0.1 + isRain * 0.3, 1.0);
		wavesScale *= f * (1.0 + isRain * RAIN_WIND_AMPLITUDE_BOOST);

		return (1.0 + sin(t * wavesMovingSpeed + (correctedRawPos.x + correctedRawPos.z + correctedRawPos.y) / WIND_WAVES_LENGTH)) * wavesScale;  
}
