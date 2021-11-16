Shader "Custom/MyBestTex"
{
	Properties
	{
	   _ColorRed("Red",Range(0,1)) = 0
	   _ColorGreen("Green",Range(0,1)) = 0
	   _ColorBlue("Blue",Range(0,1)) = 0
	   //_ColorAlpha("Alpha",Range(0,1)) = 0
	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" }

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		//#pragma surface surf Standard alpha:fade
		#pragma target 3.0



		struct Input
		{
			float4 color:Color;
		};

	    float _ColorRed;
		float _ColorGreen;
		float _ColorBlue;
		//float _ColorAlpha;

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			o.Albedo = float3(_ColorRed, _ColorGreen, _ColorBlue);
			//o.Alpha = _ColorAlpha;
		}
		ENDCG
	}
		FallBack "Diffuse"
}
