Shader "Example/WorldRefl Normalmap" {
	Properties{
	  _MainTex("Texture", 2D) = "white" {}
	  _BumpMap("Bumpmap", 2D) = "bump" {}
	  _AOMap("AO map", 2D) = "white" {}
	  _RoughnessMap("Roughness map", 2D) = "white" {}
	  _Cube("Cubemap", CUBE) = "" {}
	  _ReflectionIntensity("Reflection Intensity", Range(0,1)) = 0.2
	  _SmoothnessIntensity("Smoothness Intensity", Range(0,2)) = 1.0
	}
		SubShader{
		  Tags { "RenderType" = "Opaque" }
		  CGPROGRAM
		  #pragma surface surf StandardSpecular
		  struct Input {
			  float2 uv_MainTex;
			  float2 uv_BumpMap;
			  float3 worldRefl;
			  INTERNAL_DATA
		  };
		  sampler2D _MainTex;
		  sampler2D _BumpMap;
		  sampler2D _AOMap;
		  sampler2D _RoughnessMap;
		  samplerCUBE _Cube;
		  float _ReflectionIntensity;
		  float _SmoothnessIntensity;
		  void surf(Input IN, inout SurfaceOutputStandardSpecular o) {
			  o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _SmoothnessIntensity;
			  o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			  o.Emission = texCUBE(_Cube, WorldReflectionVector(IN, o.Normal)).rgb * _ReflectionIntensity;
			  o.Occlusion = tex2D(_AOMap, IN.uv_MainTex).r;
			  o.Smoothness = 1.0 - tex2D(_RoughnessMap, IN.uv_MainTex).r;
		  }
		  ENDCG
	}
		Fallback "Diffuse"
}