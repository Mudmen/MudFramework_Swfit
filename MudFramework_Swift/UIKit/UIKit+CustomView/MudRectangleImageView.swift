//
//  MudRectangleImageView.swift
//  Travel
//
//  Created by TimTiger on 10/14/15.
//  Copyright © 2015 Mudmen. All rights reserved.
//

import UIKit

class MudRectangleImageView: UIImageView {
    var corner: CGFloat = 0
    override var image: UIImage? {
        didSet {
            self.layer.masksToBounds = true;
            self.layer.cornerRadius = self.corner
        }
    }
}
