//: [Previous](@previous)
import UIKit
import PlaygroundSupport
import CoreImage

// Import the image, as before
let url = Bundle.main.url(forResource: "IMG_5276", withExtension: "HEIC")!
var options = [CIImageOption.applyOrientationProperty: true]
let image = CIImage(contentsOf: url, options: options)!

// Temporary for display purposes
let output = image



let iv = UIImageView(image: UIImage(ciImage: output))
PlaygroundPage.current.liveView = iv
PlaygroundPage.current.needsIndefiniteExecution = true

//: [Next](@next)
