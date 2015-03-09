//
//  UIColor+Category.swift
//  Travel
//
//  Created by TimTiger on 1/27/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    
    //create UIImage with color and alpha
    class func colorWithHex(hex: Int)->UIColor {
        return UIColor.colorWithHex(hex, alpha: 1)
    }
    
    class func colorWithHex(hex: Int,alpha: CGFloat)->UIColor {
        return UIColor(red:((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((hex & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(hex & 0xFF)) / 255.0, alpha: alpha)
    }
}