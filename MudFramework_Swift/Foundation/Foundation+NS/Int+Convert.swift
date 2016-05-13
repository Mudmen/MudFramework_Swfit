//
//  Int+Convert.swift
//  Travel
//
//  Created by TimTiger on 16/3/31.
//  Copyright © 2016年 Mudmen. All rights reserved.
//

import Foundation

extension Int {
    func distanceString()->String {
        if self <= 0 {
            return ""
        }
        
        if self >= 1000000 {
            return ">1000km"
        } else if self >= 1000 {
            return String(format: "%0.1fkm",Float(self)/Float(1000))
        } else {
            return String(format: "%dm",self)
        }
    }
}