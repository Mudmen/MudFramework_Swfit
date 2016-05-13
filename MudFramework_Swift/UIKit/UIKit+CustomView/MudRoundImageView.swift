////
////  MudRoundImageView.swift
////  Travel
////
////  Created by TimTiger on 15/4/4.
////  Copyright (c) 2015年 Mudmen. All rights reserved.
////
//
//import UIKit
//import QuartzCore
//
//class MudRoundImageView: UIImageView {
//    var bgView: UIView?
//    var brigeView: UIImageView?
//
//    var identity: QPSUserIdentity = QPSUserIdentity.Average {
//        didSet {
//            self.setNeedsLayout()
//        }
//    }
//    
//    private var identityView: UIImageView?
//    
//    var hiddenbgView: Bool = false {
//        didSet {
//            if self.bgView != nil {
//                self.bgView?.hidden = hiddenbgView
//            }
//        }
//    }
//    
//    override func removeFromSuperview() {
//        self.identityView?.removeFromSuperview()
//        self.bgView?.removeFromSuperview()
//        super.removeFromSuperview()
//    }
//    
//    override var image: UIImage? {
//        didSet {
//            self.layer.masksToBounds = true;
//            self.layer.cornerRadius = self.bounds.size.width/2
//        }
//    }
//    
//    func addTarget(target: AnyObject?, action: Selector) {
//        let tapGestrure = UITapGestureRecognizer()
//        tapGestrure.addTarget(self, action: action)
//        self.addGestureRecognizer(tapGestrure)
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.contentMode = UIViewContentMode.ScaleAspectFill
//        var width =  self.bounds.size.width*0.25
//        var height =  self.bounds.size.height*0.31
//        if width < 10 {
//            width = 10
//        }
//        if height < 12.5 {
//            height = 12.5
//        }
//        if (bgView == nil && hiddenbgView == false) {
//            bgView = UIView(frame: CGRectMake(self.frame.origin.x-2, self.frame.origin.y-2, self.bounds.size.width+4, self.bounds.size.height+4))
//            bgView!.backgroundColor = UIColor.whiteColor()
//            bgView!.layer.cornerRadius = bgView!.bounds.size.width/2
//            self.superview?.insertSubview(bgView!, belowSubview: self)
//        }
//       
//        self.bgView?.frame = CGRectMake(self.frame.origin.x-2, self.frame.origin.y-2, self.bounds.size.width+4, self.bounds.size.height+4)
//        
//        if (identityView == nil) {
//            if self.bounds.size.height > TravelHeaderWidth {
//                self.identityView = UIImageView(frame: CGRectMake(0,0,25.5,25.5))
//                self.identityView?.center = CGPointMake(CGRectGetMaxX(self.frame)-10,CGRectGetMaxY(self.frame)-10)
//            } else {
//                self.identityView = UIImageView(frame: CGRectMake(0,0,15.5,15.5))
//                self.identityView?.center = CGPointMake(CGRectGetMaxX(self.frame),CGRectGetMaxY(self.frame)-4)
//            }
//            identityView?.contentMode = UIViewContentMode.ScaleAspectFit
//            self.superview?.addSubview(identityView!)
//        }
//        var timage = UIImage(named: "account_master.png")
//        if self.identity == QPSUserIdentity.Master {
//            identityView?.hidden = false
//        } else if self.identity == QPSUserIdentity.StarUser {
//            timage = UIImage(named: "account_staruser.png")
//            identityView?.hidden = false
//        } else {
//            timage = nil
//            identityView?.hidden = true
//        }
//        identityView?.image = timage
//    }
//}
