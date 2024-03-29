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

import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

class ViewController: UIViewController {
  var metalView: MetalRenderView!
  var cameraCapture: CICameraCapture?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    metalView = MetalRenderView(frame: view.bounds, device: MTLCreateSystemDefaultDevice())
    view.addSubview(metalView)
    
    cameraCapture = CICameraCapture(cameraPosition: .back) { (image) in
      guard let image = image else { return }
      
      let filter = CIFilter.thermal()
      filter.inputImage = image
      
      let blur = CIFilter.gaussianBlur()
      blur.radius = 25
      blur.inputImage = filter.outputImage
      
      self.metalView.image = blur.outputImage?.cropped(to: image.extent)
    }
    
    cameraCapture?.start()
  }
}

