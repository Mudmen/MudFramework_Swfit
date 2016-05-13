//
//  UIImage+Named.swift
//  Travel
//
//  Created by TimTiger on 10/28/15.
//  Copyright © 2015 Mudmen. All rights reserved.
//

import UIKit
import Foundation

extension UIImage {
    class func imageWithNamed(named: String)->UIImage? {
        var image = UIImage(named: named)
        if image != nil {
            return image!
        }
        image = UIImage.imageNamedFromMudBundle(named)
        if image != nil {
            return image!
        }
        return nil
    }
    
    class func imageNamedFromMudBundle(named: String)->UIImage? {
        let bundlePath = NSBundle.mainBundle().pathForResource("MudResource", ofType: "bundle")
        if bundlePath == nil {
            return nil
        }
        let bundle = NSBundle(path: bundlePath!)
        let imagePath = bundle?.pathForResource(named, ofType: "png")
        if imagePath == nil {
            return nil
        }
        return UIImage(contentsOfFile: imagePath!)
    }
}
