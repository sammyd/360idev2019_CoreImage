#  Useful Bits

This file contains some bits to copy-paste rather than type out.

### FilterKernels.metal Constants

```
#define K_R 0.2126
#define K_G 0.7152
#define K_B 0.0722
```

### FilterKernels.metal Utility Functions

```
float4 ycbcrToRgb(float4 pixel) {
  float y  = pixel.r;
  float cb = pixel.g;
  float cr = pixel.b;
  float blue  = 2 * cb * (1 - K_B) + y;
  float red   = 2 * cr * (1 - K_R) + y;
  float green = (y - K_R * red - K_B * blue) / K_G;
  return float4(red, green, blue, pixel.a);
}
```

