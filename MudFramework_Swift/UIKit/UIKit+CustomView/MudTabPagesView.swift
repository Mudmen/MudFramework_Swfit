//
//  MudTabPagesView.swift
//  Travel
//
//  Created by TimTiger on 1/29/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit
import Foundation

protocol MudTabPagesViewDelegate: NSObjectProtocol {
    
    /*
    * @method did select a page
    */
    func didSelectedIndex(index: NSInteger)
    
    /*!
    * @method Transfer the left boundary sliding gesture
    */
    func slideSwitchView(view: MudTabPagesView, panLeftEdge panParam:UIPanGestureRecognizer)
    
    /*!
    * @method Transfer the right boundary sliding gesture
    */
    func slideSwitchView(view:MudTabPagesView, panRightEdge panParam:UIPanGestureRecognizer)
    
}

class MudTabPagesView: UIView,MudTabPageBarDelegate,UIScrollViewDelegate {
    
    var pageScrollView: UIScrollView!
    var pageBar: MudTabPageBar! {
        willSet {
            //remove items in bar
            self.removeView(self.pageBar)
            self.pageBar = nil
        }
        didSet {
            //add items to bar
            self.pageBar?.delegate = self
            self.addSubview(self.pageBar)
        }
    }
    var pageViews: NSArray? {
        willSet {
            //remove all pages from self
            self.removeViewsFromArray(self.pageViews)
            self.pageViews = nil
        }
        didSet {
            //add  pages to self
            self.addViewsFromArray(self.pageViews!)
            self.pageScrollView.contentSize = CGSizeMake(CGFloat(self.pageViews!.count)*self.bounds.size.width,0);
        }
    }
    weak var delegate: MudTabPagesViewDelegate?
    var isSlideSwitchEnable: Bool = true
    
    //MARK: - Initilization
    override init(frame: CGRect) {
        self.delegate = nil
        self.pageViews = nil
        super.init(frame: frame)
        self.setupView()
    }
    
    func setSelectIndex(index: Int) {
        self.pageBar.setSelectItemWithIndex(index)
    }
    
    //MARK: - Private func
    func setupView() {
        self.pageScrollView = UIScrollView();
        self.pageScrollView.delegate = self;
        self.pageScrollView.pagingEnabled = true;
        self.pageScrollView.panGestureRecognizer.enabled = false;
        self.pageScrollView.showsHorizontalScrollIndicator = false;
        self.pageScrollView.bounces = false;
        self.pageScrollView.panGestureRecognizer.addTarget(self,action:#selector(MudTabPagesView.scrollHandlePan(_:)));
        self.addSubview(self.pageScrollView)
    }
    
    func scrollHandlePan(panParam: UIPanGestureRecognizer) {
        //gesture transfer to delegate when Sliding to the boundary
        //left boundary
        if self.pageScrollView.contentOffset.x <= 0 {
            if (self.delegate != nil) {
                self.delegate!.slideSwitchView(self,panLeftEdge:panParam)
            }
        }
        //right boundary
        else if(self.pageScrollView.contentOffset.x >= self.pageScrollView.contentSize.width - self.pageScrollView.bounds.size.width) {
            if (self.delegate != nil) {
                self.delegate!.slideSwitchView(self,panRightEdge:panParam)
            }
        }
    }
    
    private func removeViewsFromArray(views: NSArray?) {
        if (views != nil && views!.count > 0) {
            for view in views! {
                self.removeView(view as? UIView)
            }
        }
    }
    
    private func addViewsFromArray(views: NSArray) {
        for view in views {
            self.pageScrollView.addSubview(view as! UIView)
        }
    }
    
    private func  removeView(view: UIView?) {
        if (view == nil) {
            return
        }
        view!.removeFromSuperview()
    }
    
    //MARK: - Delegate
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
       
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageFloat = scrollView.contentOffset.x/self.bounds.size.width;
        for index in 0..<self.pageViews!.count {
            if (pageFloat-CGFloat(index) == 0) {
                self.pageBar.selectIndex = index
                if (self.delegate != nil) {
                    self.delegate!.didSelectedIndex(index)
                }
            }
        }
    }

    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        
    }
    
    func didSelectItem(item: MudTabPageBarItem?, atIndex index: NSInteger) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.pageScrollView.contentOffset = CGPointMake(self.bounds.size.width*CGFloat(index), 0)//= cg (CGRectMake(self.bounds.size.width*CGFloat(index), 0, self.bounds.size.width, self.pageScrollView.bounds.size.height),animated:true);
        })
        if (self.delegate != nil) {
            self.delegate!.didSelectedIndex(index)
        }
    }
    
    //MARK: - layout
    override func layoutSubviews() {
        super.layoutSubviews()
        var height: CGFloat = 0.0;
        if self.pageBar != nil {
            //         self.pageBar.frame = CGRectMake(0, 0, self.bounds.size.width,self.pageBar.bounds.size.height);
            height = self.pageBar.bounds.size.height;
        }
        if (self.pageViews != nil && self.pageViews!.count > 0) {
            for index in 0..<self.pageViews!.count {
                let view: UIView = self.pageViews!.objectAtIndex(index) as! UIView
                view.frame = CGRectMake(CGFloat(index)*self.bounds.size.width,0, self.bounds.size.width, self.bounds.size.height-height);
            }
            self.pageScrollView.scrollEnabled = self.isSlideSwitchEnable;
            self.pageScrollView.frame = CGRectMake(0,height, self.bounds.size.width, self.bounds.size.height-height);
            self.pageScrollView.contentSize = CGSizeMake(CGFloat(self.pageViews!.count)*self.bounds.size.width,0);
        }
    }
    
    //MARK: - Error
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
