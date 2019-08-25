import PlaygroundSupport
import UIKit
import CoreImage

let url = Bundle.main.url(forResource: "IMG_5276", withExtension: "HEIC")!
let image = CIImage(contentsOf: url, options: [CIImageOption.applyOrientationProperty: true])!.transformed(by: CGAffineTransform(scaleX: 0.125, y: 0.125))

let depthMap = CIImage(contentsOf: url, options: [
  CIImageOption.applyOrientationProperty: true,
  CIImageOption.auxiliaryDepth: true
])!

let vibranceFilter = CIFilter(name: "CIVibrance", parameters: ["inputAmount": 0.9, "inputImage": image])!
let gloomFilter = CIFilter(name: "CIGloom", parameters: ["inputRadius": 10, "inputIntensity": 0.7, "inputImage": vibranceFilter.outputImage!])!

let uiImage = UIImage(ciImage: gloomFilter.outputImage!)
let iv = UIImageView(image: uiImage)
PlaygroundPage.current.liveView = iv
PlaygroundPage.current.needsIndefiniteExecution = true


//: [Next](@next)
