Shader "Custom/3_2"
{
    Properties
    {
        _MyTexture("Select Texture", 2D) = "white" {}
        _MyAlpha("Alpha",Range(0,1)) = 1
    }
    SubShader
    {
        Tags {"Queue" = "Transparent" "RenderType" = "Opaque" }

        CGPROGRAM
        #pragma surface surf Lambert alpha

        sampler2D _MyTexture;
        float _MyAlpha;
        
        struct Input
        {
             float2 uv_MyTexture;
        };

        void surf(Input IN, inout SurfaceOutput o) 
        {
            o.Albedo = tex2D(_MyTexture,IN.uv_MyTexture).rgb * _MyAlpha;
            o.Alpha = _MyAlpha;
        }
        ENDCG
    }
        FallBack "Diffuse"
}
