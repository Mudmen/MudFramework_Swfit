//
//  MudTabPageBarItem.swift
//  Travel
//
//  Created by TimTiger on 1/29/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit

class MudTabPageBarItem: UIButton {

    var indexViewHidden: Bool = false
    var indexViewHeight: CGFloat = 2.0
    var indexViewColor: UIColor = UIColor.grayColor()
    var indexView: UIView
    override var selected: Bool {
        set {
            super.selected = newValue
            self.setNeedsLayout()
        }
        get {
            return super.selected
        }
    }
    
    override init(frame: CGRect) {
        self.indexView = UIView()
        super.init(frame: frame)

    }
    
    override init() {
        self.indexView = UIView()
        super.init()
        self.addSubview(indexView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.clearColor()
        self.indexView.frame = CGRectMake(0, self.bounds.size.height-self.indexViewHeight, self.bounds.size.width,self.indexViewHeight);
        self.indexView.backgroundColor = self.indexViewColor;
        if self.indexViewHidden {
            self.indexView.hidden = true;
        } else {
            self.indexView.hidden = !self.selected;
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
