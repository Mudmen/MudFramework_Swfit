//
//  MudVerticalLayoutButton.swift
//  Travel
//
//  Created by TimTiger on 10/23/15.
//  Copyright © 2015 Mudmen. All rights reserved.
//

import UIKit

class MudVerticalLayoutButton: MudSpringButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        if self.imageView == nil || self.titleLabel == nil {
            return
        }
        
        let imageViewHeight = self.imageView!.frame.size.height
        let titleLableHeight = self.titleLabel!.frame.size.height
        let space = (self.bounds.height-imageViewHeight-titleLableHeight)/2
        self.imageView?.center = CGPointMake(self.bounds.size.width/2, space+imageViewHeight/2+1)
        self.titleLabel?.center = CGPointMake(self.bounds.size.width/2, space+imageViewHeight+titleLableHeight/2+2)
        self.titleLabel?.textAlignment = NSTextAlignment.Center
    }
}

class MudVerticalTopBottomButton: MudSpringButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.imageView == nil || self.titleLabel == nil {
            return
        }
        
        let imageViewHeight = self.imageView!.frame.size.height
        let titleLableHeight = self.titleLabel!.frame.size.height
        self.imageView?.center = CGPointMake(self.bounds.size.width/2, imageViewHeight/2)
        var tframe = self.titleLabel!.frame
        tframe.size.width = self.bounds.size.width
        self.titleLabel?.frame = tframe
        self.titleLabel?.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height-titleLableHeight/2)
        self.titleLabel?.textAlignment = NSTextAlignment.Center
    }
}
