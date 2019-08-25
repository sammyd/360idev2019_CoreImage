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

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var imageProcessor: ImageProcessor
  
  var inputImage: Image {
    return Image(uiImage: imageProcessor.input)
  }
  
  var outputImage: Image {
    return Image(uiImage: imageProcessor.output)
  }
  
  var body: some View {
    ScrollView {
      VStack {
        VStack {
          inputImage
            .resizable()
            .aspectRatio(contentMode: .fit)
          Text("Input")
            .background(Color(.white))
            .offset(y: -40)
            .font(.title)
            .padding(.bottom, -40)
        }
        VStack {
          outputImage
            .resizable()
            .aspectRatio(contentMode: .fit)
          Text("Output")
            .background(Color(.white))
            .offset(y: -40)
            .font(.title)
            .padding(.bottom, -40)
        }
        VStack {
          HStack {
            Text("Kernel Size")
            Slider(value: $imageProcessor.kernelSize, in: 1.0...20.0, step: 1)
          }
          HStack {
            Text("𝜎 Spatial")
            Slider(value: $imageProcessor.sigmaSpatial, in: 0.0...30.0, step: 0.1)
          }
          HStack {
            Text("𝜎 Range")
            Slider(value: $imageProcessor.sigmaRange, in: 0.0...0.5, step: 0.01)
          }
        }
          .padding()
      }
    }
      
  }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
  
