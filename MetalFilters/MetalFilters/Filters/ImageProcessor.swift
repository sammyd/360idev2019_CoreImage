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

import Combine
import CoreImage
import UIKit

final class ImageProcessor: ObservableObject {
  private let context = CIContext()
  private let inputImage = CIImage(cgImage: #imageLiteral(resourceName: "sampleImage").cgImage!)
  private var subscriptions = [AnyCancellable]()
  
  @Published var input: UIImage = UIImage()
  @Published var output: UIImage = UIImage()
  @Published var kernelSize: Double = 14.0
  @Published var sigmaSpatial: Double = 4.0
  @Published var sigmaRange: Double = 0.2

  private let bilateralFilter = BilateralFilter()
  private let colorSpaceForwardFilter = RgbToYcbcrFilter()
  private let colorSpaceBackwardFilter = YCbCrToRgbFilter()
  
  init() {
    input = renderAsUIImage(inputImage)
    createSubscriptions()
    filterImage()
  }
  
  private func renderAsUIImage(_ image: CIImage) -> UIImage {
    let cgImage = context.createCGImage(image, from: image.extent)!
    return UIImage(cgImage: cgImage)
  }
  
  private func createSubscriptions() {
    [$kernelSize, $sigmaSpatial, $sigmaRange].forEach { (property) in
      let sub = property
        .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
        .removeDuplicates()
        .sink { _ in self.filterImage() }
      subscriptions.append(sub)
    }
  }

  
  private func filterImage() {
    colorSpaceForwardFilter.inputImage = inputImage
    
    bilateralFilter.inputImage = colorSpaceForwardFilter.outputImage
    bilateralFilter.kernelRadius = Float(kernelSize)
    bilateralFilter.sigmaSpatial = Float(sigmaSpatial)
    bilateralFilter.sigmaRange = Float(sigmaRange)
    
    colorSpaceBackwardFilter.inputImage = bilateralFilter.outputImage
    output = renderAsUIImage(colorSpaceBackwardFilter.outputImage!)
  }
}
