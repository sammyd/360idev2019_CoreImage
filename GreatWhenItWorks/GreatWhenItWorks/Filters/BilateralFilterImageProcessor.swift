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

import Cocoa

class BilateralFilerImageProcessor {
  private let filter = BilateralFilter()
  
  var kernelRadius: Int = 5{
    didSet {
      // TODO
    }
  }
  
  var sigmaSpatial: Float = 15 {
    didSet {
      // TODO
    }
  }
  
  var sigmaRange: Float = 0.01 {
    didSet {
      // TODO
    }
  }
  
  func process(image: NSImage) -> NSImage? {
    guard let ciimage = CIImage(nsImage: image) else { return .none }
    
    let scaleFactor = 600 / max(ciimage.extent.width, ciimage.extent.height);
    let downsized = ciimage.transformed(by: CGAffineTransform.init(scaleX: scaleFactor, y: scaleFactor))
    
    // TODO
    
    let outputImage = ciimage

    return NSImage(ciImage: outputImage)
  }
}

fileprivate class BilateralFilter: CIFilter {
  // TODO
}
