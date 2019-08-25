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

import MetalKit
import CoreImage

class MetalRenderView: MTKView {
  override init(frame frameRect: CGRect, device: MTLDevice?) {
    super.init(frame: frameRect, device: device)
    
    if super.device == nil {
      fatalError("No support for Metal. Sorry")
    }
    
    framebufferOnly = false
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private lazy var commandQueue: MTLCommandQueue? = {
    [unowned self] in
    return self.device!.makeCommandQueue()
  }()
  
  private lazy var ciContext: CIContext = {
    [unowned self] in
    return CIContext(mtlDevice: self.device!)
  }()
  
  
  
  var image: CIImage? {
    didSet {
      renderImage()
    }
  }
  
  
  private func renderImage() {
    guard let image = image else { return }
  
    let commandBuffer = commandQueue?.makeCommandBuffer()
    let destination = CIRenderDestination(width: Int(drawableSize.width),
                                          height: Int(drawableSize.height),
                                          pixelFormat: .rgba8Unorm,
                                          commandBuffer: commandBuffer) { () -> MTLTexture in
                                            return self.currentDrawable!.texture
    }
    
    try! ciContext.startTask(toRender: image.transformToOrigin(withSize: drawableSize), to: destination)
    
    commandBuffer?.present(currentDrawable!)
    commandBuffer?.commit()
    draw()
  }
}













