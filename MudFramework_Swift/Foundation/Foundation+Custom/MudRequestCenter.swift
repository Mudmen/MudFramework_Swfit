//
//  MudRequestCenter.swift
//  Travel
//
//  Created by TimTiger on 1/29/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit

class MudRequestCenter: MudRequestBase {
    //share instance
    class var defaultCenter: MudRequestCenter {
        struct Static {
            static var instance: MudRequestCenter?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = MudRequestCenter()
        }
        
        return Static.instance!
    }
}
