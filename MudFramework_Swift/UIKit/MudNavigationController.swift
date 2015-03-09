//
//  MudNavigationController.swift
//  Travel
//
//  Created by TimTiger on 1/27/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit

class MudNavigationController: UINavigationController {
    var autorotate:Bool?
    
    override func viewDidLoad() {
        // set custom navi bar
        var navibar: MudNavigationBar = MudNavigationBar()
        self.setValue(navibar, forKey: "navigationBar")
        super.viewDidLoad()
        autorotate = true
    }
    
}