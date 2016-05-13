//
//  MudSizeFitLabel.swift
//  Travel
//
//  Created by TimTiger on 16/4/1.
//  Copyright © 2016年 Mudmen. All rights reserved.
//

import UIKit

class MudSizeFitLabel: UILabel {
    func setContent(content: String?) {
        self.text = content
        var tframe = self.frame
        self.sizeToFit()
        tframe.size.width = self.frame.size.width
        self.frame = tframe
    }
}