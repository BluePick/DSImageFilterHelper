//
//  DSImageFilterHelper.swift
//  CosmicCamera
//
//  Created by Darshit on 18/07/18.
//  Copyright © 2018 Darshit. All rights reserved.
//


import UIKit
import Foundation

enum Filter: String {
    
    case normal, chrome, fade, instant, mono, noir, process, tonal, transfer, tone, linear

    static let allValues = [normal, chrome, fade, instant, mono, noir, process, tonal, transfer, tone, linear]

     var value: String {
        switch self {
        case .normal:   return "No Filter"
        case .chrome:   return "CIPhotoEffectChrome"
        case .fade:     return "CIPhotoEffectFade"
        case .instant:  return "CIPhotoEffectInstant"
        case .mono:     return "CIPhotoEffectMono"
        case .noir:     return "CIPhotoEffectNoir"
        case .process:  return "CIPhotoEffectProcess"
        case .tonal:    return "CIPhotoEffectTonal"
        case .transfer: return "CIPhotoEffectTransfer"
        case .tone:     return "CILinearToSRGBToneCurve"
        case .linear:   return "CISRGBToneCurveToLinear"
        }
    }

     var name: String {
        switch self {
        case .normal:   return "Normal"
        case .chrome:   return "Chrome"
        case .fade:     return "Fade"
        case .instant:  return "Instant"
        case .mono:     return "Mono"
        case .noir:     return "Noir"
        case .process:  return "Process"
        case .tonal:    return "Tonal"
        case .transfer: return "Transfer"
        case .tone:     return "Tone"
        case .linear:   return "Linear"
        }
    }
}

struct ImageFilter {
    let filter: Filter
    let image: UIImage
}

class DSImageFilterHelper {

    static let shared = DSImageFilterHelper()
    fileprivate let context = CIContext(options: nil)

    func createFilteredImages(filters: [Filter], image: UIImage, complete completeCallback:@escaping([ImageFilter]) -> Void) {

        var objImageFilter = [ImageFilter]()

        for applyFilter in filters {
            // 1 - create source image
            let sourceImage = CIImage(image: image)
            // 2 - create filter using name
            guard let filter = CIFilter(name: applyFilter.value) else {
                if applyFilter.value == "No Filter" {
                    let structFilter = ImageFilter(filter: applyFilter, image: image)
                    objImageFilter.append(structFilter)
                }
                continue
            }
            filter.setDefaults()
            // 3 - set source image
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            if let imageCI = filter.outputImage {
                // 4 - output filtered image as cgImage with dimension.
                let outputCGImage = context.createCGImage((imageCI), from: (imageCI.extent))
                // 5 - convert filtered CGImage to UIImage
                let filteredImage = UIImage(cgImage: outputCGImage!)
                let structFilter = ImageFilter(filter: applyFilter, image: filteredImage)
                objImageFilter.append(structFilter)
            }
        }

        completeCallback(objImageFilter)
    }

    func resizeImage(image: UIImage, resizedSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(resizedSize)
        image.draw(in: CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }

}
