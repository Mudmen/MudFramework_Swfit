//
//  UIView+Category.swift
//  Travel
//
//  Created by TimTiger on 15/4/8.
//  Copyright (c) 2015年 Mudmen. All rights reserved.
//

import UIKit

let DELETE_TAG = 99

extension UIView {
    //remove all subviews
    func removeAllSubviews() {
        for view in self.subviews {
            let tview: UIView =  view 
            if tview.tag >= DELETE_TAG {
                tview.removeFromSuperview()
            }
        }
    }
}