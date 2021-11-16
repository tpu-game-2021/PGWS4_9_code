Shader "Example/Diffuse Simple"
{
	SubShader
	{
		Tags { "RenderType" = "Opaque" }

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert

		struct Input
		{
			float4 color:Color;
		};

	void surf(Input IN, inout SurfaceOutput o)
	{
		o.Albedo = 1;
		}
		ENDCG
	}
		FallBack "Diffuse"
}