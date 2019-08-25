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

import AVFoundation
import CoreImage

class CICameraCapture: NSObject {
  typealias Callback = (CIImage?) -> ()
  
  let cameraPosition: AVCaptureDevice.Position
  let callback: Callback
  private let session = AVCaptureSession()
  private let sampleBufferQueue = DispatchQueue(label: "com.razeware.RealtimeFiltering.SampleBuffer", qos: .userInitiated)
  
  
  init(cameraPosition: AVCaptureDevice.Position, callback: @escaping Callback) {
    self.cameraPosition = cameraPosition
    self.callback = callback
    
    super.init()
    
    prepareSession()
  }
  
  func start() {
    session.startRunning()
  }
  
  func stop() {
    session.stopRunning()
  }
  
  
  private func prepareSession() {
    session.sessionPreset = .hd1920x1080
    
    let cameraDiscovery = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera, .builtInWideAngleCamera], mediaType: .video, position: cameraPosition)
    guard let camera = cameraDiscovery.devices.first,
      let input = try? AVCaptureDeviceInput(device: camera)
      else { fatalError("Can't get hold of the camera") }
    session.addInput(input)
    
    let output = AVCaptureVideoDataOutput()
    output.setSampleBufferDelegate(self, queue: sampleBufferQueue)
    session.addOutput(output)
  }
}

extension CICameraCapture: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
    
    DispatchQueue.main.async {
      let image = CIImage(cvImageBuffer: imageBuffer)
      self.callback(image.transformed(by: CGAffineTransform(rotationAngle: 3 * .pi / 2)))
    }
  }
}

















