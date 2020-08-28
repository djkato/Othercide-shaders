#version 120

varying vec4 texcoord;
uniform sampler2D gcolor;

const int RGBA16 = 1;
const int gcolorFormat = RGBA16;

void main() {

    vec3 finalComposite = texture2D(gcolor, texcoord.st).rgb;
    gl_FragData[0] = vec4(finalComposite, 1.0);
}