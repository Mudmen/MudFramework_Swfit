//
//  MudCornerLabel.swift
//  Travel
//
//  Created by TimTiger on 11/2/15.
//  Copyright © 2015 Mudmen. All rights reserved.
//

import UIKit
import QuartzCore

class MudCornerLabel: UILabel {

    override func  layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.size.height/2
    }

}
