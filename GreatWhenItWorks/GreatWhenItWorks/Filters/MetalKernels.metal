/*
 * Copyright (c) 2019 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#include <metal_stdlib>
using namespace metal;

#define K_R 0.2126
#define K_G 0.7152
#define K_B 0.0722

#include <CoreImage/CoreImage.h>

extern "C" {
  namespace coreimage {
    // KERNEL
    float4 passthroughFilterKernel(sample_t s) {
      return s;
    }
    
    float intensity(float4 pixel) {
      return K_R * pixel.r + K_G * pixel.g + K_B * pixel.b;
    }
    
    float blueDifference(float4 pixel) {
      return (pixel.b - intensity(pixel)) / (2 * (1 - K_B));
    }
    
    float redDifference(float4 pixel) {
      return (pixel.r - intensity(pixel)) / (2 * (1 - K_R));
    }


    // KERNEL
    float4 rgbToYcbcrFilterKernel(sample_t s) {
      float y = intensity(s);
      float cb = blueDifference(s);
      float cr = redDifference(s);
      return float4(y, cb, cr, s.a);
    }
  }
}
