//
//  UIBarButtonItem+extension.swift
//  Travel
//
//  Created by TimTiger on 1/29/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    class func itemWithImage(image: UIImage?, target: AnyObject,action: Selector) ->UIBarButtonItem {
        let button: UIButton = UIButton(type: UIButtonType.Custom)
        button.frame = CGRectMake(0, 0, 24, 44);
        button.setImage(image ,forState:UIControlState.Normal)
        button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        button.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin;
        let item: UIBarButtonItem = UIBarButtonItem(customView: button)
        return item;
    }
    
    class func itemWithTitle(title: String, target: AnyObject ,action: Selector,titleColor: UIColor? = nil,textAlignment: UIControlContentHorizontalAlignment = UIControlContentHorizontalAlignment.Left)->UIBarButtonItem {
        let button:UIButton = UIButton(type: UIButtonType.Custom)
        button.backgroundColor = UIColor.clearColor()
        button.titleLabel?.font = UIFont.systemFontOfSize(17)
        if titleColor != nil {
            button.setTitleColor(titleColor!, forState:UIControlState.Normal)
        } else {
            button.setTitleColor(UIColor.colorWithHex(0x464f54), forState:UIControlState.Normal)
        }
        var redf: CGFloat = 0.0
        var greenf: CGFloat = 0.0
        var bluef: CGFloat = 0.0
        var alphaf: CGFloat = 0.0
        button.titleLabel?.textColor.getRed(&redf, green: &greenf, blue: &bluef, alpha: &alphaf)
        redf += 0.1;
        greenf += 0.1;
        bluef += 0.1;
        button.setTitleColor(UIColor(red: redf,green: greenf,blue: bluef,alpha: alphaf), forState:UIControlState.Highlighted)
        let height: CGFloat = CGFloat(title.length()*20) > 120 ? 120 : CGFloat(title.length()*20)
        button.frame = CGRectMake(0, 0,height, 44);
        button.contentHorizontalAlignment = textAlignment
        button.setTitle(title,forState:UIControlState.Normal)
        button.setTitle(title,forState:UIControlState.Highlighted)
        button.addTarget(target, action: action,forControlEvents: UIControlEvents.TouchUpInside)
        let item: UIBarButtonItem = UIBarButtonItem(customView: button)
        item.style = UIBarButtonItemStyle.Plain
        return item;
    }
    
    class func itemWithCustomView(view: UIView)->UIBarButtonItem {
        let item: UIBarButtonItem = UIBarButtonItem(customView: view)
        return item;
    }
    
    class func hiddenItem()->UIBarButtonItem {
        let button: UIButton = UIButton(type: UIButtonType.Custom)
        button.frame = CGRectMake(0, 0, 24, 44);
        button.setImage(UIImage.imageWithColor(UIColor.clearColor(), andSize: CGSizeMake(24, 44)) ,forState:UIControlState.Normal)
        button.setImage(UIImage.imageWithColor(UIColor.clearColor(), andSize: CGSizeMake(24, 44)) ,forState:UIControlState.Selected)
        button.setImage(UIImage.imageWithColor(UIColor.clearColor(), andSize: CGSizeMake(24, 44)) ,forState:UIControlState.Highlighted)
        button.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin
        let item: UIBarButtonItem = UIBarButtonItem(customView: button)
        return item;
    }

    func setTitleColor(color: UIColor, forState state: UIControlState) {
        let button: UIButton = self.customView as! UIButton
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
