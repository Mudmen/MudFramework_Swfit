//
//  UIImage+Category.swift
//  Travel
//
//  Created by TimTiger on 1/27/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//
import UIKit

extension UIImage {
    class func imageWithColor(icolor: UIColor,andSize size: CGSize)->UIImage {
        let rect:CGRect = CGRectMake(0.0,0.0,size.width,size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSetFillColorWithColor(context,icolor.CGColor)
        CGContextFillRect(context,rect)
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image;
    }
    
//    class func imageWithNamed(name: String)->UIImage? {
//        var image: UIImage? = UIImage(named: name)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
//        return image
//    }
//    
//    class func imageWithNamed(name: String, renderingMode: UIImageRenderingMode)->UIImage? {
//        var image: UIImage? = UIImage(named: name)?.imageWithRenderingMode(renderingMode)
//        return image
//    }
    
}