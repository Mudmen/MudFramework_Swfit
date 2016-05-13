//
//  MudStarView.swift
//  Travel
//
//  Created by TimTiger on 4/30/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit

class MudStarView: UIView {
    
    //[0,5]
    var scale: Float = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    private var starNormalView: UIImageView!
    private var starHighlightView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.starNormalView = UIImageView(frame: CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height))
        self.starNormalView.image = UIImage(named:"star_normal.png")
        self.starNormalView.userInteractionEnabled = false
       self.addSubview(self.starNormalView)
        
        self.starHighlightView = UIImageView(frame: CGRectMake(0, 0, 0, self.bounds.size.height))
        self.starHighlightView.image = UIImage(named:"star_highlight.png")
        self.starHighlightView.userInteractionEnabled = false
        self.starHighlightView.contentMode = UIViewContentMode.Left
        self.starHighlightView.clipsToBounds = true
        self.addSubview(self.starHighlightView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.starNormalView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        self.starHighlightView.frame = CGRectMake(0, 0, self.bounds.size.width*CGFloat((self.scale/5.0)), self.bounds.size.height);
    }

}
