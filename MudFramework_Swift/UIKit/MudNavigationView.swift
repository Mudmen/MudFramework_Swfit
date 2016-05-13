//
//  MudNavigationView.swift
//  Travel
//
//  Created by TimTiger on 15/12/19.
//  Copyright © 2015年 Mudmen. All rights reserved.
//

import UIKit

public class MudAlphaNavigationBar: MudNavigationBar {
    
    private var barBackgroundView: UIView!
    
    class public func alphaBar()->MudAlphaNavigationBar {
        let alphaBar = MudAlphaNavigationBar(frame: CGRectMake(0, 20, MUD_SCREEN_WIDTH, 44))
        return alphaBar
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.clearColor()
        self.setBackgroundImage(UIImage.imageWithColor(UIColor.clearColor(), andSize: CGSizeMake(MUD_SCREEN_WIDTH, 0.5)), forBarMetrics: UIBarMetrics.Default)
        self.shadowImage = UIImage.imageWithColor(UIColor.clearColor(), andSize: CGSizeMake(MUD_SCREEN_WIDTH, 0.5))
        self.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(),NSFontAttributeName:UIFont.boldSystemFontOfSize(18)]
        self.barBackgroundView = UIView(frame: CGRectMake(0,0,MUD_SCREEN_WIDTH,44))
        self.barBackgroundView.backgroundColor = UIColor.whiteColor()
        self.insertSubview(self.barBackgroundView, atIndex: 0)
    }
    
    public func refreshAlpha(alpha: CGFloat) {
        self.barBackgroundView.alpha = alpha;
    }
    
}

public class MudNavigationView: UIView {
    var navigationBar: MudAlphaNavigationBar!
    var statusView: UIView!
    
    class public func navigationView()->MudNavigationView {
        let groupView = MudNavigationView()
        groupView.frame = CGRectMake(0,0,MUD_SCREEN_WIDTH,64)
        return groupView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.clearColor()
        self.statusView = UIView(frame: CGRectMake(0,0,MUD_SCREEN_WIDTH,20))
        self.statusView.backgroundColor = UIColor.whiteColor()
        self.addSubview(self.statusView)
        
        self.navigationBar = MudAlphaNavigationBar.alphaBar()
        self.addSubview(navigationBar)
    }
    
    //MARK: -
    public func refreshAlpha(alpha: CGFloat) {
        self.statusView.alpha = alpha
        self.navigationBar.refreshAlpha(alpha)
    }
}