//: [Previous](@previous)
import UIKit
import PlaygroundSupport
import CoreImage

// Import the image, as before
let url = Bundle.main.url(forResource: "IMG_5276", withExtension: "HEIC")!
var options = [CIImageOption.applyOrientationProperty: true]
let image = CIImage(contentsOf: url, options: options)!

// Import the matte
options[CIImageOption.auxiliaryPortraitEffectsMatte] = true
let matte = CIImage(contentsOf: url, options: options)!

let resized = image.transformed(by: CGAffineTransform(scaleX: 0.125, y: 0.125))
let matteResized = matte.transformed(by: CGAffineTransform(scaleX: 0.25, y: 0.25))


//let inverseFilter = CIFilter(name: "CIColorInvert", parameters: [
//  "inputImage": matteResized
//])!
//
//// Apply the blur
//let maskedBlurFilter = CIFilter(name: "CIMaskedVariableBlur", parameters: [
//  "inputImage": resized,
//  "inputRadius": 20,
//  "inputMask": inverseFilter.outputImage!
//])!

let background = resized
  .applyingFilter("CIVibrance", parameters: ["inputAmount": -0.8])
  .applyingFilter("CIDiscBlur", parameters: ["inputRadius": 8])
  .cropped(to: resized.extent)
  .applyingFilter("CIVignette", parameters: ["inputIntensity": 0.7, "inputRadius": 20])

let foreground = resized
  .applyingFilter("CIVibrance", parameters: ["inputAmount": 0.7])

let compositeFilter = CIFilter(name: "CIBlendWithMask", parameters: [
    "inputImage": foreground,
    "inputBackgroundImage": background,
    "inputMaskImage": matteResized
  ])!


// Temporary for display purposes
let output = compositeFilter.outputImage!



let iv = UIImageView(image: UIImage(ciImage: output))
PlaygroundPage.current.liveView = iv
PlaygroundPage.current.needsIndefiniteExecution = true

//: [Next](@next)
