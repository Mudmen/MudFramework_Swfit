//
//  MudFont.swift
//  MudFramework_Swift
//
//  Created by TimTiger on 16/6/21.
//  Copyright © 2016年 Mudmen. All rights reserved.
//

import UIKit

public class MudFont: UIFont {
    public class func title1()->UIFont {
        return UIFont.boldSystemFontOfSize(19)
    }
    
    public class func title2()->UIFont {
        return UIFont.boldSystemFontOfSize(18)
    }
    
    public class func title3()->UIFont {
        return UIFont.boldSystemFontOfSize(16)
    }
    
    public class func headline()->UIFont {
        return UIFont.systemFontOfSize(15)
    }
    
    public class func body()->UIFont {
        return UIFont.systemFontOfSize(14)
    }
    
    public class func subBody()->UIFont {
        return UIFont.systemFontOfSize(13)
    }
    
    public class func little()->UIFont {
        return UIFont.systemFontOfSize(12)
    }
    
    public class func little2()->UIFont {
        return UIFont.systemFontOfSize(11)
    }
    
    public class func little3()->UIFont {
        return UIFont.systemFontOfSize(10)
    }
}
