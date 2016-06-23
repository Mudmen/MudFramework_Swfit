//
//  UIColor+Category.swift
//  Travel
//
//  Created by TimTiger on 1/27/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit
import Foundation

public extension UIColor {
    
    /**
     用16进制值 获取颜色
     
     - parameter hex: 16进制色值，比如0xffffff
     
     - returns: UIColor
     */
    public class func colorWithHex(hex: Int)->UIColor {
        return UIColor.colorWithHex(hex, alpha: 1)
    }
    
    /**
     用16进制值 获取颜色
     
     - parameter hex: 16进制色值，比如0xffffff
     - parameter alpha: 透明度 [0-1]
     
     - returns: UIColor
     */
    public class func colorWithHex(hex: Int,alpha: CGFloat)->UIColor {
        return UIColor(red:((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((hex & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(hex & 0xFF)) / 255.0, alpha: alpha)
    }
    
    /**
    get a UIColor instance
    
    - parameter red:   red [0-255]
    - parameter green: green [0-255]
    - parameter blue:  blue [0-255]
    - parameter alpha: 0-1

    - returns: UIColor instance
    */
    public class func colorWithRedValue(redValue: CGFloat,greenValue: CGFloat,blueValue: CGFloat,alpha: CGFloat)->UIColor {
         return UIColor(red: redValue / 255.0, green: greenValue / 255.0, blue: blueValue / 255.0, alpha: alpha)
    }
}