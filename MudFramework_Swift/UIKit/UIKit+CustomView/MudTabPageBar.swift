//
//  MudTabPageBar.swift
//  Travel
//
//  Created by TimTiger on 1/29/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit

protocol MudTabPageBarDelegate: NSObjectProtocol  {
    func didSelectItem(item: MudTabPageBarItem, atIndex index: NSInteger)
}

class MudTabPageBar: UIView{

    var delegate: MudTabPageBarDelegate?
   
    var indexViewHidden: Bool = false
    var indexViewColor: UIColor = UIColor.grayColor()
    var items: NSArray? {
        willSet {
            self.removeViewsFramArray(self.items)
            self.items = nil
        }
        didSet {
            self.addViewsFromArray(self.items)
            if self.items != nil && self.items!.count > 0 {
                for item in self.items! {
                    (item as MudTabPageBarItem).addTarget(self, action:"onItemAction:", forControlEvents: UIControlEvents.TouchUpInside)
                }
                self.setSelectItem(self.items!.firstObject as MudTabPageBarItem)
            }
        }
    }
    var selectIndex: NSInteger = 0 {
        didSet {
            //update all item status
            for var i = 0; i < self.items!.count; ++i {
                var tmpItem: MudTabPageBarItem = self.items!.objectAtIndex(i) as MudTabPageBarItem
                if self.selectIndex == i {
                    tmpItem.selected = true
                } else {
                    tmpItem.selected = false
                }
            }
        }
    }
  
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        self.items = nil
        self.delegate = nil
        super.init(frame: frame)
    }
    
    // MARK: - layout
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.items != nil && self.items?.count > 0 {
            let width = self.bounds.size.width/CGFloat(self.items!.count)
            for var i = 0; i < self.items!.count; ++i {
                var item: MudTabPageBarItem = self.items!.objectAtIndex(i) as MudTabPageBarItem
                item.frame = CGRectMake(CGFloat(i)*width,0, width,self.bounds.size.height);
            }
        }
    }
    
    //MARK: - Private func 
    // remove
    private func removeViewsFramArray(views: NSArray?) {
        if views == nil {
            return
        }
        for view in views! {
            (view as UIView).removeFromSuperview()
        }
    }
    
    private func addViewsFromArray(views: NSArray?) {
        if views == nil {
            return
        }
        for view in views! {
            self.addSubview((view as MudTabPageBarItem))
        }
    }
    
    private func setSelectItem(item: MudTabPageBarItem!) {
        for var i = 0; i < self.items!.count; i++ {
            var tmpitem: MudTabPageBarItem = self.items!.objectAtIndex(i) as MudTabPageBarItem;
            if item == tmpitem {
                self.selectIndex = i;
                tmpitem.selected = true
            } else {
                tmpitem.selected = false
            }
        }
    }
    
    //MARK: - Actions 
    func onItemAction(sender: MudTabPageBarItem) {
        self.setSelectItem(sender)
        if (self.delegate != nil && self.delegate!.respondsToSelector("didSelectItem:atIndex:")) {
            self.delegate!.didSelectItem(sender, atIndex: self.selectIndex)
        }
    }
    
    // MARK: - Error remind
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


