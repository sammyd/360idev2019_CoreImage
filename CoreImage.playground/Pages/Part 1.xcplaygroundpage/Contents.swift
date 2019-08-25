import PlaygroundSupport
import UIKit
import CoreImage

let url = Bundle.main.url(forResource: "IMG_5276", withExtension: "HEIC")!
let image = CIImage(contentsOf: url, options: [CIImageOption.applyOrientationProperty: true])!.transformed(by: CGAffineTransform(scaleX: 0.125, y: 0.125))

let depthMap = CIImage(contentsOf: url, options: [
  CIImageOption.applyOrientationProperty: true,
  CIImageOption.auxiliaryDepth: true
])!

//let vibranceFilter = CIFilter(name: "CIVibrance", parameters: ["inputAmount": 0.9, "inputImage": image])!
//let gloomFilter = CIFilter(name: "CIGloom", parameters: ["inputRadius": 10, "inputIntensity": 0.7, "inputImage": vibranceFilter.outputImage!])!
//
//let output = gloomFilter.outputImage!.cropped(to: image.extent)
//
//timeCode {
//  let image1 = vibrance(image)
//  UIImageView(image: UIImage(ciImage: image1))
//  let image2 = gloom(image1).cropped(to: image.extent)
//  UIImageView(image: UIImage(ciImage: image2))
//  let image3 = vignette(image2)
//  UIImageView(image: UIImage(ciImage: image3))
//}
//
//timeCode {
//  let out = filterChain(image)
//  UIImageView(image: UIImage(ciImage: out))
//}



let output = filterChain(image)



let uiImage = UIImage(ciImage: output)
let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
iv.contentMode = .scaleAspectFit
iv.image = uiImage






//: [Next](@next)
