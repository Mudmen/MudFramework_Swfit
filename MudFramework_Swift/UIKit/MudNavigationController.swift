//
//  MudNavigationController.swift
//  Travel
//
//  Created by TimTiger on 1/27/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit

public class MudNavigationController: UINavigationController,UIGestureRecognizerDelegate {
    
    override public func viewDidLoad() {
        let navibar: MudNavigationBar = MudNavigationBar()
        self.setValue(navibar, forKey: "navigationBar")
        super.viewDidLoad()
        
        if self.respondsToSelector(Selector("interactivePopGestureRecognizer")) != false {
            self.interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    public func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        let ret = self.viewControllers.count > 1 && !(self.valueForKey("_isTransitioning")!.boolValue)
        return ret
    }
}