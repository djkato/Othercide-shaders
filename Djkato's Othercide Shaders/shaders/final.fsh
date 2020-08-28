#version 120

varying vec4 texcoord;
uniform sampler2D gcolor;



void Vgnette(inout vec3 color) {

    float dist = distance(texcoord.st, vec2(0.5)) * 2.0;
    dist /= 1.4f;
    dist = pow(dist, 0.8f);
    color.rgb *= (1.0f - dist);
}

vec3 ConvertToHDR(in vec3 color){
    vec3 HDRImage;
    vec3 overExposed = color * 1.2f;
    vec3 underExposed = color / 1.5f;
    HDRImage = mix(underExposed, overExposed, color);

    return HDRImage;
}

vec3 DoMagic(in vec3 color){
    float averageColor = (color[0] + color[1] + color[2] )/3;
    float saturatedRed;
    if(color[0] -0.165f > color[1] && color[0] -0.165f > color[2])
    {
        saturatedRed = color[0] * 1.5f;
    }
    else{
        saturatedRed = averageColor;
    }
    vec3 bnwImage = vec3(saturatedRed, averageColor, averageColor);
    return bnwImage;
}


void main() {

    vec3 color = texture2D(gcolor, texcoord.st).rgb;


        color = DoMagic(color);
        color = ConvertToHDR(color);
        Vgnette(color);



    gl_FragColor = vec4(color.rgb, 1.0f);

}