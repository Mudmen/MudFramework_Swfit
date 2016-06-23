//
//  MudColor.swift
//  MudFramework_Swift
//
//  Created by TimTiger on 16/6/21.
//  Copyright © 2016年 Mudmen. All rights reserved.
//

import UIKit

public class MudColor: UIColor {
    public override class func blackColor() -> UIColor {
        return UIColor.colorWithHex(0x464f54)
    }
    
    public override class func grayColor() -> UIColor {
        return UIColor.colorWithHex(0x88939a)
    }
    
    public override class func lightGrayColor() -> UIColor {
        return UIColor.colorWithHex(0x9e9e9e)
    }
    
    public override class func yellowColor() -> UIColor {
        return UIColor.colorWithHex(0xfcb43f)
    }
}
