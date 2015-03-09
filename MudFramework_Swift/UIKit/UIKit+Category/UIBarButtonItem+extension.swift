//
//  UIBarButtonItem+extension.swift
//  Travel
//
//  Created by TimTiger on 1/29/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    //get item with image
    class func itemWithImage(image: UIImage?, target: AnyObject,action: Selector) ->UIBarButtonItem {
        var button: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        button.frame = CGRectMake(0, 0, 24, 44);
        button.setImage(image ,forState:UIControlState.Normal)
        button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        button.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin;
        var item: UIBarButtonItem = UIBarButtonItem(customView: button)
        return item;
    }
    
    //get item with string
    class func itemWithTitle(title: NSString, target: AnyObject ,action: Selector)->UIBarButtonItem {
        var button:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        button.backgroundColor = UIColor.clearColor()
        button.setTitleColor(UIColor.whiteColor(), forState:UIControlState.Normal)
        var redf: CGFloat = 0.0
        var greenf: CGFloat = 0.0
        var bluef: CGFloat = 0.0
        var alphaf: CGFloat = 0.0
        button.titleLabel?.textColor.getRed(&redf, green: &greenf, blue: &bluef, alpha: &alphaf)
        redf += 0.1;
        greenf += 0.1;
        bluef += 0.1;
        button.setTitleColor(UIColor(red: redf,green: greenf,blue: bluef,alpha: alphaf), forState:UIControlState.Highlighted)
        button.frame = CGRectMake(0, 0,60, 44);
        button.setTitle(title,forState:UIControlState.Normal)
        button.setTitle(title,forState:UIControlState.Highlighted)
        button.addTarget(target, action: action,forControlEvents: UIControlEvents.TouchUpInside)
        var item: UIBarButtonItem = UIBarButtonItem(customView: button)
        item.style = UIBarButtonItemStyle.Plain
        return item;
    }
    
    //get item with custom view
    class func itemWithCustomView(view: UIView)->UIBarButtonItem {
        var item: UIBarButtonItem = UIBarButtonItem(customView: view)
        return item;
    }

    //set item title color
    func setTitleColor(color: UIColor, forState state: UIControlState) {
        var button: UIButton = self.customView as UIButton
        button.setTitleColor(color, forState:UIControlState.Normal)
        if state == UIControlState.Normal {
            var redf: CGFloat = 0.0
            var greenf: CGFloat = 0.0
            var bluef: CGFloat = 0.0
            var alphaf: CGFloat = 0.0
            button.titleLabel?.textColor.getRed(&redf, green: &greenf, blue: &bluef, alpha: &alphaf)
            redf += 0.2;
            greenf += 0.2;
            bluef += 0.2;
            button.setTitleColor(UIColor(red: redf,green: greenf,blue: bluef,alpha: alphaf), forState:UIControlState.Highlighted)
        }
    }

}
