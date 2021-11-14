Shader "Custom/MyBest"
{
	Properties
	{
		_Color("Color",Color)=(1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_BumpMap("Bumpmap", 2D) = "bump" {}
		_Cube("Cubemap", CUBE) = "" {}
		_RimColor ("Rim Color",Color) = (0.26,0.19,0.16,0.0)
	    _RimPower("Rim Power",Range(0.5,8.0)) = 3.0
		_ColorTint ("Tint", Color) = (1.0,0.6,0.6,1.0)
        _Ramp("Ramp",2D) = "white" {}
		/*_ShadeColor("ShadeColor",Color) = (0.0,0.0,0.0)*/

	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 200
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		/*#pragma surface surf Lambert finalcolor:mycolor vertex:myvert
        #pragma multi_compile_fog*/
	    #pragma surface surf ToonRamp
		 #pragma target 3.0
		sampler2D _Ramp;
		sampler2D _MainTex;
		sampler2D _BumpMap;
		uniform half4 unity_FogStart;
		uniform half4 unity_FogEnd;
		samplerCUBE _Cube;
		float4 _RimColor;
		float _RimPower;
		fixed4 _Color;
		struct Input
		{
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float3 viewDir;
			float3 worldRefl;
			half fog;
			INTERNAL_DATA
		};
		fixed4 LightingToonRamp(SurfaceOutput s, half3 lightDir, fixed atten)
		{
			half diff = dot(s.Normal, lightDir)*0.5+0.5;
			fixed3 ramp = tex2D(_Ramp, float2(diff, 0.5)).rgb;
			fixed4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * ramp *atten;
			c.a = s.Alpha;
			return c;
		}
		/*void myvert(inout appdata_full v, out Input data)
		{
			UNITY_INITIALIZE_OUTPUT(Input, data);
			float pos = length(UnityObjectToViewPos(v.vertex).xyz);
			float diff = unity_FogEnd.x - unity_FogStart.x;
			float invDiff = 1.0f / diff;
			data.fog = clamp((unity_FogEnd.x - pos) * invDiff, 0.0, 1.0);
		}*/
		fixed4 _ColorTint;
		void mycolor(Input IN, SurfaceOutput o, inout fixed4 color)
		{
			color *= _ColorTint;
          /*  #ifdef UNITY_PASS_FORWARDADD
			UNITY_APPLY_FOG_COLOR(IN.fog,color,float4(0,0,0,0));
            #else
			UNITY_APPLY_FOG_COLOR(IN.fog, color, unity_FogColor);
            #endif*/

		}
		void surf(Input IN, inout SurfaceOutput o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission = (texCUBE(_Cube, WorldReflectionVector(IN, o.Normal)).rgb*0.3) + _RimColor.rgb*pow(rim,_RimPower);
			o.Alpha = c.a ;
		}
		ENDCG
	}
		FallBack "Diffuse"
}
