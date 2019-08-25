import PlaygroundSupport
import UIKit
import CoreImage

let url = Bundle.main.url(forResource: "IMG_5276", withExtension: "HEIC")!
let image = CIImage(contentsOf: url, options: [CIImageOption.applyOrientationProperty: true])!


let uiImage = UIImage(ciImage: image)
let iv = UIImageView(image: uiImage)
PlaygroundPage.current.liveView = iv
PlaygroundPage.current.needsIndefiniteExecution = true


//: [Next](@next)
