//
//  MudBadgeButton.swift
//  Travel
//
//  Created by TimTiger on 15/8/11.
//  Copyright (c) 2015年 Mudmen. All rights reserved.
//

import UIKit

class MudBadgeButton: UIButton {

    private var unreadLabel: UILabel?
    var unreadCount: Int = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if unreadLabel == nil {
            self.clipsToBounds = false
            unreadLabel = UILabel(frame: CGRectMake(self.bounds.size.width-15, -5, 20, 20))
            unreadLabel?.backgroundColor = UIColor(red: 78.0/255.0, green: 185.0/255.0, blue: 231.0/255.0, alpha: 1)
            unreadLabel?.textColor = UIColor.whiteColor()
            
            unreadLabel?.textAlignment = NSTextAlignment.Center
            unreadLabel?.font = UIFont.systemFontOfSize(11)
            unreadLabel?.layer.cornerRadius = 10
            unreadLabel?.clipsToBounds = true
            self.addSubview(unreadLabel!)
        }
        
        if unreadCount <= 0 {
            unreadLabel?.hidden = true
        } else{
            unreadLabel?.hidden = false
            if unreadCount < 10 {
                unreadLabel?.font = UIFont.systemFontOfSize(13)
                unreadLabel?.text = String(unreadCount)
            } else if unreadCount < 100 {
                unreadLabel?.font = UIFont.systemFontOfSize(12)
                unreadLabel?.text = String(unreadCount)
            } else if unreadCount >= 100 {
                unreadLabel?.font = UIFont.systemFontOfSize(10)
                unreadLabel?.text = "+99"
            }
        }
    }
}
