//
//  MudActionSheet.swift
//  Travel
//
//  Created by TimTiger on 15/9/14.
//  Copyright (c) 2015年 Mudmen. All rights reserved.
//

import UIKit

let MUD_ACTIONSHEET_BUTTON_HEIGHT : CGFloat = 49.0
let MUD_ACTIONSHEET_TITLE_HEIGHT: CGFloat = 25.0

@objc protocol MudActionSheetDelegate: NSObjectProtocol {
    optional func actionSheet(actionSheet: MudActionSheet,didSelectedButtonAtIndex buttonIndex: Int)
}


class MudActionSheet: UIView {

    //public
    weak var delegate: MudActionSheetDelegate?
    var userInfo: AnyObject?
    
    //private 
    private var darkView: UIView!
    private var sheetBackgroundView: UIView!
    private var titles: [String]!
    private weak var backWindow : UIWindow! {
        return UIApplication.sharedApplication().keyWindow
    }
    
    /**
    get a MudActionSheet instance
    
    - parameter title:                  sheet title
    - parameter adelegate:              delegate
    - parameter destructiveButtonIndex: red button index
    - parameter buttonTitles:           all button titles
    
    - returns: MudActionSheet instance
    */
    class func initWithTitle(title: String?,adelegate: MudActionSheetDelegate?,destructiveButtonIndex: Int,buttonTitles: [String])->MudActionSheet {
        return MudActionSheet(title: title, adelegate: adelegate, destructiveButtonIndex: destructiveButtonIndex, destructiveColor: UIColor.colorWithHex(0xf2445d),buttonTitles: buttonTitles)
    }
    
    class func initWithTitle(title: String?,adelegate: MudActionSheetDelegate?,destructiveButtonIndex: Int,destructiveColor: UIColor,buttonTitles: [String])->MudActionSheet {
        return MudActionSheet(title: title, adelegate: adelegate, destructiveButtonIndex: destructiveButtonIndex, destructiveColor: destructiveColor,buttonTitles: buttonTitles)
    }
    
    convenience init(title: String?,adelegate: MudActionSheetDelegate?,destructiveButtonIndex: Int,buttonTitles: [String]) {
        self.init(frame: CGRectZero)
        self.delegate = adelegate
        
        //init Dark View
        self.darkView = UIView()
        self.darkView.alpha = 0
        self.darkView.userInteractionEnabled = true
        self.darkView.frame = CGRectMake(0, 0, MUD_SCREEN_WIDTH, MUD_SCREEN_HEIGHT)
        self.darkView.backgroundColor = UIColor.colorWithRedValue(46, greenValue: 49, blueValue: 50, alpha: 1)
        self.addSubview(self.darkView)
        
        //add dissmiss gesture to dark view
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(MudActionSheet.dismissAction(_:)))
        self.darkView.addGestureRecognizer(dismissGesture)
        
        //init all buttons background view
        self.sheetBackgroundView = UIView()
        self.sheetBackgroundView.backgroundColor = UIColor.colorWithHex(0xeaeeef)
        self.addSubview(self.sheetBackgroundView)
        
        if (String.hasCharacter(title)) {
            //init title view
            let titleLabel = UILabel(frame: CGRectMake(0, 0, MUD_SCREEN_WIDTH, MUD_ACTIONSHEET_TITLE_HEIGHT))
            titleLabel.font = UIFont.systemFontOfSize(12)
            titleLabel.textColor = UIColor.colorWithHex(0x88939a)
            titleLabel.textAlignment = NSTextAlignment.Center
            titleLabel.text = title
            titleLabel.backgroundColor = UIColor.colorWithRedValue(255, greenValue: 255, blueValue: 255, alpha: 0.95)
            self.sheetBackgroundView.addSubview(titleLabel)
        }
        
        if buttonTitles.count > 0 {
            self.titles = buttonTitles
            for index in 0..<buttonTitles.count {
                let btn = UIButton(type: UIButtonType.Custom)
                btn.tag = 101 + index
                btn.backgroundColor = UIColor.colorWithRedValue(255, greenValue: 255, blueValue: 255, alpha: 0.95)
                btn.titleLabel?.font = UIFont.systemFontOfSize(16)
                if index == destructiveButtonIndex {
                    //set red color
                    btn.setTitleColor(UIColor.colorWithHex(0xf2445d), forState: UIControlState.Normal)
                } else {
                    //set black color
                    btn.setTitleColor(UIColor.colorWithHex(0x464f54), forState: UIControlState.Normal)
                }
                btn.setTitle(self.titles[index], forState: UIControlState.Normal)
                btn.setBackgroundImage(UIImage(named: "moments_sheetbghl.png"), forState: UIControlState.Highlighted)
                btn.addTarget(self, action: #selector(MudActionSheet.didClickBtn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                let btnY = MUD_ACTIONSHEET_BUTTON_HEIGHT*CGFloat(index)+(String.hasCharacter(title) ? MUD_ACTIONSHEET_TITLE_HEIGHT : 0)
                btn.frame = CGRectMake(0, btnY, MUD_SCREEN_WIDTH, MUD_ACTIONSHEET_BUTTON_HEIGHT)
                self.sheetBackgroundView.addSubview(btn)
                
                let lineView = UIView(frame: CGRectMake(0, btnY, MUD_SCREEN_WIDTH, 0.5))
                lineView.backgroundColor = UIColor.colorWithHex(0xeaeeef)
                self.sheetBackgroundView.addSubview(lineView)
            }
            
            let cancelBtn = UIButton(type: UIButtonType.Custom)
            cancelBtn.tag = 100
            cancelBtn.setTitleColor(UIColor.colorWithHex(0x464f54), forState: UIControlState.Normal)
            cancelBtn.setTitle(MudLocalString.stringForKey("ButtonCancelTitle", tableName: "MudLocalization"), forState: UIControlState.Normal)
            cancelBtn.backgroundColor = UIColor.colorWithRedValue(255, greenValue: 255, blueValue: 255, alpha: 0.95)
            cancelBtn.titleLabel?.font = UIFont.systemFontOfSize(17)
            cancelBtn.setBackgroundImage(UIImage(named: "moments_sheetbghl.png"), forState: UIControlState.Highlighted)
            cancelBtn.addTarget(self, action: "didClickBtn:", forControlEvents: UIControlEvents.TouchUpInside)
            let btnY = MUD_ACTIONSHEET_BUTTON_HEIGHT*CGFloat(buttonTitles.count)+(String.hasCharacter(title) ? MUD_ACTIONSHEET_TITLE_HEIGHT : 0)+5
            cancelBtn.frame = CGRectMake(0, btnY, MUD_SCREEN_WIDTH, MUD_ACTIONSHEET_BUTTON_HEIGHT)
            self.sheetBackgroundView.addSubview(cancelBtn)
            
            let originY: CGFloat = String.hasCharacter(title) ? MUD_ACTIONSHEET_TITLE_HEIGHT : 0
            let bottomH = originY + MUD_ACTIONSHEET_BUTTON_HEIGHT * CGFloat(buttonTitles.count) + MUD_ACTIONSHEET_BUTTON_HEIGHT + 5
            self.sheetBackgroundView.frame = CGRectMake(0, MUD_SCREEN_HEIGHT, MUD_SCREEN_WIDTH, bottomH)
            
            self.frame = UIScreen.mainScreen().bounds
            self.backWindow.addSubview(self)
        }
    }
    
    /**
    get a MudActionSheet instance
    
    - parameter title:                  sheet title
    - parameter adelegate:              delegate
    - parameter destructiveButtonIndex: red button index
    - parameter buttonTitles:           all button titles
    
    - returns: MudActionSheet instance
    */
    convenience init(title: String?,adelegate: MudActionSheetDelegate?,destructiveButtonIndex: Int,destructiveColor: UIColor,buttonTitles: [String]) {
        self.init(frame: CGRectZero)
        self.delegate = adelegate
        
        //init Dark View
        self.darkView = UIView()
        self.darkView.alpha = 0
        self.darkView.userInteractionEnabled = true
        self.darkView.frame = CGRectMake(0, 0, MUD_SCREEN_WIDTH, MUD_SCREEN_HEIGHT)
        self.darkView.backgroundColor = UIColor.colorWithRedValue(46, greenValue: 49, blueValue: 50, alpha: 1)
        self.addSubview(self.darkView)

        //add dissmiss gesture to dark view
        let dismissGesture = UITapGestureRecognizer(target: self, action: "dismissAction:")
        self.darkView.addGestureRecognizer(dismissGesture)
        
        //init all buttons background view
        self.sheetBackgroundView = UIView()
        self.sheetBackgroundView.backgroundColor = UIColor.colorWithHex(0xeaeeef)
        self.addSubview(self.sheetBackgroundView)
        
        if (String.hasCharacter(title)) {
            //init title view
            let titleLabel = UILabel(frame: CGRectMake(0, 0, MUD_SCREEN_WIDTH, MUD_ACTIONSHEET_TITLE_HEIGHT))
            titleLabel.font = UIFont.systemFontOfSize(12)
            titleLabel.textColor = UIColor.colorWithHex(0x88939a)
            titleLabel.textAlignment = NSTextAlignment.Center
            titleLabel.text = title
            titleLabel.backgroundColor = UIColor.colorWithRedValue(255, greenValue: 255, blueValue: 255, alpha: 0.95)
            self.sheetBackgroundView.addSubview(titleLabel)
        }
        
        if buttonTitles.count > 0 {
            self.titles = buttonTitles
            for index in 0..<buttonTitles.count {
                let btn = UIButton(type: UIButtonType.Custom)
                btn.tag = 101 + index
                btn.backgroundColor = UIColor.colorWithRedValue(255, greenValue: 255, blueValue: 255, alpha: 0.95)
                btn.titleLabel?.font = UIFont.systemFontOfSize(16)
                if index == destructiveButtonIndex {
                    //set red color
                    btn.setTitleColor(destructiveColor, forState: UIControlState.Normal)
                } else {
                    //set black color
                    btn.setTitleColor(UIColor.colorWithHex(0x464f54), forState: UIControlState.Normal)
                }
                btn.setTitle(self.titles[index], forState: UIControlState.Normal)
                btn.setBackgroundImage(UIImage(named: "moments_sheetbghl.png"), forState: UIControlState.Highlighted)
                btn.addTarget(self, action: "didClickBtn:", forControlEvents: UIControlEvents.TouchUpInside)
                let btnY = MUD_ACTIONSHEET_BUTTON_HEIGHT*CGFloat(index)+(String.hasCharacter(title) ? MUD_ACTIONSHEET_TITLE_HEIGHT : 0)
                btn.frame = CGRectMake(0, btnY, MUD_SCREEN_WIDTH, MUD_ACTIONSHEET_BUTTON_HEIGHT)
                self.sheetBackgroundView.addSubview(btn)
                
                let lineView = UIView(frame: CGRectMake(0, btnY, MUD_SCREEN_WIDTH, 0.5))
                lineView.backgroundColor = UIColor.colorWithHex(0xeaeeef)
                self.sheetBackgroundView.addSubview(lineView)
            }
            
            let cancelBtn = UIButton(type: UIButtonType.Custom)
            cancelBtn.tag = 100
            cancelBtn.setTitleColor(UIColor.colorWithHex(0x464f54), forState: UIControlState.Normal)
            cancelBtn.setTitle(MudLocalString.stringForKey("ButtonCancelTitle", tableName: "MudLocalization"), forState: UIControlState.Normal)
            cancelBtn.backgroundColor = UIColor.colorWithRedValue(255, greenValue: 255, blueValue: 255, alpha: 0.95)
            cancelBtn.titleLabel?.font = UIFont.systemFontOfSize(17)
            cancelBtn.setBackgroundImage(UIImage(named: "moments_sheetbghl.png"), forState: UIControlState.Highlighted)
            cancelBtn.addTarget(self, action: "didClickBtn:", forControlEvents: UIControlEvents.TouchUpInside)
            let btnY = MUD_ACTIONSHEET_BUTTON_HEIGHT*CGFloat(buttonTitles.count)+(String.hasCharacter(title) ? MUD_ACTIONSHEET_TITLE_HEIGHT : 0)+5
            cancelBtn.frame = CGRectMake(0, btnY, MUD_SCREEN_WIDTH, MUD_ACTIONSHEET_BUTTON_HEIGHT)
            self.sheetBackgroundView.addSubview(cancelBtn)
            
            let originY: CGFloat = String.hasCharacter(title) ? MUD_ACTIONSHEET_TITLE_HEIGHT : 0
            let bottomH = originY + MUD_ACTIONSHEET_BUTTON_HEIGHT * CGFloat(buttonTitles.count) + MUD_ACTIONSHEET_BUTTON_HEIGHT + 5
            self.sheetBackgroundView.frame = CGRectMake(0, MUD_SCREEN_HEIGHT, MUD_SCREEN_WIDTH, bottomH)
            
            self.frame = UIScreen.mainScreen().bounds
            self.backWindow.addSubview(self)
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   //MARK:  - Actions
    internal func dismissAction(sender: UITapGestureRecognizer?) {
        
        UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 3, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.darkView.alpha = 0
            self.darkView.userInteractionEnabled = false
            
            var tframe = self.sheetBackgroundView.frame
            tframe.origin.y += tframe.size.height
            self.sheetBackgroundView.frame = tframe
            
        }) { (finished) -> Void in
            self.removeFromSuperview()
        }
    }
    
    internal func didClickBtn(sender: UIButton) {
        self.dismissAction(nil)
        if self.delegate != nil && self.delegate?.respondsToSelector("actionSheet:didSelectedButtonAtIndex:") == true {
            self.delegate!.actionSheet!(self, didSelectedButtonAtIndex: sender.tag-100)
        }
    }
    
    func show() {
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 3, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.darkView.alpha = 0.4
            self.darkView.userInteractionEnabled = true
            
            var tframe = self.sheetBackgroundView.frame
            tframe.origin.y -= tframe.size.height
            self.sheetBackgroundView.frame = tframe
        }) { (finished) -> Void in
            
        }
    }
}
