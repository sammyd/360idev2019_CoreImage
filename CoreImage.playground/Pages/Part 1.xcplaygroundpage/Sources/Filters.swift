import Foundation
import CoreImage

public func gloom(_ image: CIImage) -> CIImage {
  return image.applyingFilter("CIGloom",
                              parameters: [
                                "inputRadius": 10,
                                "inputIntensity": 0.7
                              ])
}

public func vignette(_ image: CIImage) -> CIImage {
  return image.applyingFilter("CIVignette",
                              parameters: [
                                "inputRadius": 2,
                                "inputIntensity": 0.9
                              ])
}

public func vibrance(_ image: CIImage) -> CIImage {
  return image.applyingFilter("CIVibrance",
                              parameters: [
                                "inputAmount" : 0.9
                              ])
}

public func filterChain(_ image: CIImage) -> CIImage {
  return vignette(gloom(vibrance(image)).cropped(to: image.extent))
}

public func timeCode(_ closure: () -> ()) -> TimeInterval {
  let startDate = Date()
  closure()
  return Date().timeIntervalSince(startDate)
}
