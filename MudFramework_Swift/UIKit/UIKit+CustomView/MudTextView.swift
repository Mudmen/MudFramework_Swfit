//
//  MudTextView.swift
//  Travel
//
//  Created by TimTiger on 15/4/7.
//  Copyright (c) 2015年 Mudmen. All rights reserved.
//

import UIKit

class MudTextView: UITextView {
    var placeholder: String  = "" {
        didSet {
            self.setNeedsLayout()
        }
    }
    var placeholderFont: UIFont = UIFont.systemFontOfSize(16)
    var placeholderColor: UIColor = UIColor.lightGrayColor() {
        didSet {
            self.setNeedsLayout()
        }
    }
    var placeholderTopGap: CGFloat = 8 {
        didSet {
            self.setNeedsLayout()
        }
    }
    var placeholderLeftGap: CGFloat = 5 {
        didSet {
            self.setNeedsLayout()
        }
    }
    private var placeholderLabel: UILabel?
    
    override var text : String! {
        didSet {
            self.placeholderLabel?.hidden = String.isNotEmptyString(self.text)
        }
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
        if placeholderLabel == nil {
            placeholderLabel = UILabel(frame: CGRectMake(placeholderLeftGap, placeholderTopGap, frame.size.width, 20))
            placeholderLabel?.font = placeholderFont
            placeholderLabel?.numberOfLines = 0
            self.placeholderLabel!.textColor = self.placeholderColor
            placeholderLabel?.backgroundColor = UIColor.clearColor()
            self.addSubview(placeholderLabel!)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MudTextView.handNotification(_:)), name: UITextViewTextDidChangeNotification, object: nil)
        }
        placeholderLabel?.text = placeholder
        placeholderLabel!.frame = CGRectMake(placeholderLeftGap, placeholderTopGap, frame.size.width-3, 30)
        placeholderLabel?.hidden = String.isNotEmptyString(self.text)
    }
    
    func handNotification(notification: NSNotification) {
        if self.isFirstResponder() {
            if self.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
                placeholderLabel?.hidden = true
            } else {
                placeholderLabel?.hidden = false
            }
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidChangeNotification, object: nil)
    }
}
