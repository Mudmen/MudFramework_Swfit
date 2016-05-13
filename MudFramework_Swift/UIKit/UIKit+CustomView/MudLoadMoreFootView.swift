//
//  MudLoadMoreFootView.swift
//  Travel
//
//  Created by TimTiger on 15/4/16.
//  Copyright (c) 2015年 Mudmen. All rights reserved.
//

import UIKit


enum FootViewStatus : Int {
    case CanLoadMore //能加载更多
    case LoadingMore //加载中
    case NoMore //没有更多了F
};

protocol MudLoadMoreFootViewDelegate: NSObjectProtocol {
    func didTouchedWithStatus(status: FootViewStatus)
}

class MudLoadMoreFootView: UIButton {
    weak var delegate: MudLoadMoreFootViewDelegate?
    var status: FootViewStatus? = FootViewStatus.CanLoadMore {
        didSet {
            self.setTitle(remindStrArray[status!.rawValue], forState: UIControlState.Normal)
            self.titleLabel!.sizeToFit()
            self.titleLabel?.center = CGPointMake(self.bounds.size.width/2,self.bounds.size.height/2)
            if self.status == FootViewStatus.LoadingMore {
                self.activityView!.center = CGPointMake(self.titleLabel!.frame.origin.x-20, self.bounds.size.height/2)
                self.activityView!.startAnimating()
                self.activityView!.hidden = false;
            } else {
                self.activityView!.hidden = true;
                self.activityView!.stopAnimating()
            }
        }
    }
    var remindStrArray: [String]! = [MudLocalString.stringForKey("CanLoadMore", tableName: "MudLocalization"),MudLocalString.stringForKey("LoadingMore",tableName: "MudLocalization"),MudLocalString.stringForKey("NoMore",tableName: "MudLocalization")]
    var activityView: UIActivityIndicatorView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        self.titleLabel?.font = UIFont.systemFontOfSize(12)
        activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        self.addSubview(activityView!)
        if self.allTargets().count == 0 {
            self.addTarget(self, action: "onButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        let tableView = object as! UITableView
        if (tableView.contentOffset.y > tableView.contentSize.height-tableView.bounds.size.height+40) && tableView.dragging == true {
            self.loadMore()
        }
    }
    
    //MARK: - Private API
    private func loadMore() {
        if self.status == FootViewStatus.CanLoadMore {
            if (self.delegate != nil && self.delegate?.respondsToSelector("didTouchedWithStatus:") != nil) {
                self.delegate!.didTouchedWithStatus(self.status!)
            }
            self.status = FootViewStatus.LoadingMore;
        }
    }
    
    func onButtonAction(sender: UIButton) {
       self.loadMore()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
