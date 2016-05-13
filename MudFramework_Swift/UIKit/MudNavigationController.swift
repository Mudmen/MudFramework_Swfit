//
//  MudNavigationController.swift
//  Travel
//
//  Created by TimTiger on 1/27/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit

class MudNavigationController: UINavigationController,UIGestureRecognizerDelegate {
    var autorotate:Bool?

    override func viewDidLoad() {
        let navibar: MudNavigationBar = MudNavigationBar()
        self.setValue(navibar, forKey: "navigationBar")
        super.viewDidLoad()
        autorotate = true
        
        if self.respondsToSelector("interactivePopGestureRecognizer") != false {
            self.interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        let ret = self.viewControllers.count > 1 && !(self.valueForKey("_isTransitioning")!.boolValue)
        return ret
    }
}