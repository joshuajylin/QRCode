//
//  CIImageExtension.swift
//  QRCode
//
//  Created by Jaiouch Yaman - Société ID-APPS on 18/12/2015.
//  Copyright © 2015 Alexander Schuch. All rights reserved.
//

#if os(OSX)
import Cocoa
#else
import UIKit
#endif

internal typealias Scale = (dx: CGFloat, dy: CGFloat)

internal extension CIImage {
    
    #if os(OSX)
    internal func nonInterpolatedImage(withScale scale: Scale = Scale(dx: 1, dy: 1)) -> NSImage? {
        let newImage = self.transformed(by: CGAffineTransform(scaleX: scale.dx, y: scale.dy))
        let rep = NSCIImageRep(ciImage: newImage)
        let nsImage = NSImage(size: rep.size)
        nsImage.addRepresentation(rep)
        return nsImage
    }
    #else
    /// Creates an `UIImage` with interpolation disabled and scaled given a scale property
    ///
    /// - parameter withScale:  a given scale using to resize the result image
    ///
    /// - returns: an non-interpolated UIImage
    internal func nonInterpolatedImage(withScale scale: Scale = Scale(dx: 1, dy: 1)) -> UIImage? {
        guard let cgImage = CIContext(options: nil).createCGImage(self, from: self.extent) else { return nil }
        let size = CGSize(width: self.extent.size.width * scale.dx, height: self.extent.size.height * scale.dy)
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.interpolationQuality = .none
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.draw(cgImage, in: context.boundingBoxOfClipPath)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result
    }
    #endif
}
