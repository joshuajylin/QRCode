//
//  UIImageViewExtension.swift
//  QRCode
//
//  Created by Alexander Schuch on 27/01/15.
//  Copyright (c) 2015 Alexander Schuch. All rights reserved.
//

#if os(OSX)
import Cocoa

public extension NSImageView {
    
    /// Creates a new image view with the given QRCode
    ///
    /// - parameter qrCode:      The QRCode to display in the image view
    public convenience init(qrCode: QRCode) {
        self.init(image: qrCode.image)
    }
    
}
#else
import UIKit

public extension UIImageView {
    
    /// Creates a new image view with the given QRCode
    ///
    /// - parameter qrCode:      The QRCode to display in the image view
    public convenience init(qrCode: QRCode) {
        self.init(image: qrCode.image)
    }
    
}
#endif
