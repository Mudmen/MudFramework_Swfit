//
//  MudRefreshControl.swift
//  Travel
//
//  Created by TimTiger on 7/11/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit

public enum MudRefreshControlState: UInt {
    case Pulling
    case Normal
    case Loading
}

public protocol MudRefreshControlDelegate: NSObjectProtocol {
    func refreshControlTableHeaderDidTriggerRefresh(control: MudRefreshControl)
    func refreshControlTableHeaderDataSourceIsLoading(control: MudRefreshControl)->Bool
    func refreshControlTableHeaderDataSourceLastUpdated(control: MudRefreshControl)->NSDate?
}

private let FLIP_ANIMATION_DURATION: Double = 0.18

/**
 *  根据EgoRefresh 改写的一个下拉刷新控件
 */
@available(iOS, introduced=6.0)
public class MudRefreshControl: UIView {
    
    public weak var delegate: MudRefreshControlDelegate?
   
    /* 控件当前所处状态 */
    private var state: MudRefreshControlState!  {
        willSet {
            switch (newValue!) {
            case MudRefreshControlState.Pulling:
                self.statusLabel.text = MudLocalString.stringForKey("Release to refresh...", tableName: "MudLocalization")
                CATransaction.begin()
                CATransaction.setAnimationDuration(FLIP_ANIMATION_DURATION)
                CATransaction.commit()
                break
            case MudRefreshControlState.Normal:
                if (self.state == MudRefreshControlState.Pulling) {
                    CATransaction.begin()
                    CATransaction.setAnimationDuration(FLIP_ANIMATION_DURATION)
                    CATransaction.commit()
                }
                self.statusLabel.text = MudLocalString.stringForKey("Pull down to refresh...", tableName: "MudLocalization")
                self.activityView.stopAnimating()
                CATransaction.begin()
                CATransaction.setDisableActions(true)
                CATransaction.commit()
                self.refreshLastUpdatedDate()
                break
            case MudRefreshControlState.Loading:
                self.statusLabel.text = MudLocalString.stringForKey("Loading...", tableName: "MudLocalization")
                self.activityView.startAnimating()
                CATransaction.begin()
                CATransaction.setDisableActions(true)
                CATransaction.commit()
                break
            }
        }
    }
    
    private var lastUpdatedLabel: UILabel!
    private var statusLabel: UILabel!
    private var activityView: UIActivityIndicatorView!
    
    /** 初始化函数 */
    override convenience init(frame: CGRect) {
        self.init(frame: frame,textColor: UIColor.colorWithHex(0x88939a))
    }
    
    public init(frame: CGRect, textColor: UIColor)
    {
        super.init(frame: frame)
        self.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.backgroundColor = UIColor.whiteColor()
        self.initLastUpdatedLabel(textColor)
        self.initStatusLabel(textColor)
        self.initActivityView()
        self.state = MudRefreshControlState.Normal
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Private Func
    private func initLastUpdatedLabel(textColor: UIColor) {
        self.lastUpdatedLabel = UILabel(frame: CGRectMake(0.0, frame.size.height - 30.0, self.frame.size.width, 20.0))
        self.lastUpdatedLabel.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.lastUpdatedLabel.font =  UIFont.systemFontOfSize(12)
        self.lastUpdatedLabel.textColor = textColor
        self.lastUpdatedLabel.backgroundColor = UIColor.clearColor()
        self.lastUpdatedLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(self.lastUpdatedLabel)
    }
    
    private func initStatusLabel(textColor: UIColor) {
        self.statusLabel = UILabel(frame: CGRectMake(0.0, frame.size.height - 48.0, self.frame.size.width, 20.0))
        self.statusLabel.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.statusLabel.font =  UIFont.systemFontOfSize(13)
        self.statusLabel.textColor = textColor
        self.statusLabel.backgroundColor = UIColor.clearColor()
        self.statusLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(self.statusLabel)
    }
    
    private func initActivityView() {
        self.activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        self.activityView.frame = CGRectMake(25.0, frame.size.height - 38.0, 20.0, 20.0)
        self.addSubview(self.activityView)
    }
    
    //MARK: - Public Func
    public func refreshLastUpdatedDate()
    {
        if self.delegate != nil {
            let date = self.delegate?.refreshControlTableHeaderDataSourceLastUpdated(self)
            if date != nil {
                NSDateFormatter.setDefaultFormatterBehavior(NSDateFormatterBehavior.BehaviorDefault)
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
                dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
                self.lastUpdatedLabel.text = String(format: "%@%@",MudLocalString.stringForKey("Last Updated: ", tableName: "MudLocalization"),dateFormatter.stringFromDate(date!))
            }
        } else {
            self.lastUpdatedLabel.text = nil
        }
    }
    
    public func autoRefresh(scrollView: UIScrollView)
    {
        scrollView.contentOffset  = CGPointMake(0,-65)
        self.refreshControlScrollViewDidEndDragging(scrollView)
    }
    
    public func refreshControlScrollViewDidScroll(scrollView: UIScrollView)
    {
        if (self.state == MudRefreshControlState.Loading) {
            var offset = max(scrollView.contentOffset.y * -1,0)
            offset = min(offset,60)
            scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0, 0.0, 0.0)
        } else if (scrollView.dragging == true) {
            var _loading = false
            
            if self.delegate != nil {
                _loading = self.delegate!.refreshControlTableHeaderDataSourceIsLoading(self)
            }
            
            if self.state == MudRefreshControlState.Pulling && scrollView.contentOffset.y > -65 && scrollView.contentOffset.y < 0 && _loading == false {
                self.state = MudRefreshControlState.Normal
            } else if self.state == MudRefreshControlState.Normal && scrollView.contentOffset.y < -65 && _loading == false {
                self.state = MudRefreshControlState.Pulling
            }
            
            if (scrollView.contentInset.top != 0) {
                scrollView.contentInset = UIEdgeInsetsZero
            }
            
        }
    }
    
    public func refreshControlScrollViewDidEndDragging(scrollView: UIScrollView)
    {
        var _loading = false
        
        if self.delegate != nil {
            _loading = self.delegate!.refreshControlTableHeaderDataSourceIsLoading(self)
        }
        
        if (scrollView.contentOffset.y <= -65 && _loading == false) {
            if self.delegate != nil {
                self.delegate!.refreshControlTableHeaderDidTriggerRefresh(self)
            }
            self.state = MudRefreshControlState.Loading
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.2)
            scrollView.contentInset = UIEdgeInsetsMake(60.0, 0.0, 0.0, 0.0)
            UIView.commitAnimations()
        }

    }
    
    public func refreshControlScrollViewDataSourceDidFinishedLoading(scrollView: UIScrollView)
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        scrollView.contentInset = UIEdgeInsetsZero
        UIView.commitAnimations()
        self.state = MudRefreshControlState.Normal
    }
    
}