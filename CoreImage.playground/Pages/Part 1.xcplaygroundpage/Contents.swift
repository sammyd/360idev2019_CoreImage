import PlaygroundSupport
import UIKit
import CoreImage

let url = Bundle.main.url(forResource: "IMG_5276", withExtension: "HEIC")!
let image = CIImage(contentsOf: url, options: [CIImageOption.applyOrientationProperty: true])!

let depthMap = CIImage(contentsOf: url, options: [
  CIImageOption.applyOrientationProperty: true,
  CIImageOption.auxiliaryDepth: true
])!

let vibranceFilter = CIFilter(name: "CIVibrance", parameters: ["inputAmount": 0.9, "inputImage": image])!


let uiImage = UIImage(ciImage: vibranceFilter.outputImage!)
let iv = UIImageView(image: uiImage)
PlaygroundPage.current.liveView = iv
PlaygroundPage.current.needsIndefiniteExecution = true


//: [Next](@next)
