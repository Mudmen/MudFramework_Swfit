//
//  TravelTableView.swift
//  Travel
//
//  Created by TimTiger on 15/11/25.
//  Copyright © 2015年 Mudmen. All rights reserved.
//

import UIKit

enum MudTableViewStatus : Int {
    case CanLoadMore //还能有更多数据
    case Empty    //没有数据
    case NoMore //没有更多数据了
};

protocol MudTableViewDelegate: UITableViewDelegate,UITableViewDataSource {
    func tableViewDidTriggerRefresh(tableView: MudTableView)
    func tableViewDidTriggerLoadMore(tableView: MudTableView)
}

class MudTableView: UITableView,MudRefreshControlDelegate,MudLoadMoreFootViewDelegate {
    
    var page: Int = 1
    var pageSize: Int = 20
    var showRefresh: Bool = true {
        didSet {
            if showRefresh == false && self.refreshHeaderView.superview != nil {
                self.refreshHeaderView.removeFromSuperview()
            } else if showRefresh == true && self.refreshHeaderView.superview == nil {
                self.addSubview(self.refreshHeaderView)
            }
        }
    }
    var showLoadMore: Bool = true {
        didSet {
            
        }
    }
    weak var allDelegate: MudTableViewDelegate? {
        didSet {
            self.delegate = allDelegate
            self.dataSource = allDelegate
        }
    }
    var headerView: UIView? {
        didSet {
            super.tableHeaderView = headerView;
            
            if (self.emptyView == nil) {
                return;
            }
            
            if  (self.tableHeaderView != nil) {
                self.emptyView?.frame = CGRectMake(0, self.tableHeaderView!.bounds.size.height, self.bounds.size.width, self.bounds.size.height-self.tableHeaderView!.bounds.size.height);
            } else {
                self.emptyView?.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
            }
        }
    }
    
    var isLoading: Bool = false
    
    var emptyView: UIView?
    var emptyBackgroundView: UIView?
    var loadMoreView: MudLoadMoreFootView!
    var refreshHeaderView: MudRefreshControl!
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        
        self.page = 1
        self.isLoading = false
        
        self.refreshHeaderView = MudRefreshControl(frame:CGRectMake(0, 0 - self.bounds.size.height, self.frame.size.width, self.bounds.size.height))
        self.refreshHeaderView.delegate = self
        self.refreshHeaderView.backgroundColor = UIColor.clearColor()
        self.addSubview(self.refreshHeaderView)
        
        self.loadMoreView = MudLoadMoreFootView(frame: CGRectMake(0, 0, self.bounds.size.width, 40))
        self.loadMoreView.delegate = self;
        self.addObserver(self.loadMoreView, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    deinit {
        if (self.loadMoreView != nil) {
            self.removeObserver(self.loadMoreView, forKeyPath: "contentOffset")
        }
    }
    
    //MARK: - Public
    func loadData() {
        if self.refreshHeaderView.superview == nil {
            self.page = 1
            self.isLoading = true
            if self.allDelegate != nil {
                self.allDelegate!.tableViewDidTriggerRefresh(self)
            }
        } else {
            self.refreshHeaderView.refreshLastUpdatedDate()
            self.refreshHeaderView.autoRefresh(self)
        }
    }
    
    func endLoadWithAllCount(allCount: Int,lastPageCount pageCount: Int) {
        self.emptyViewHidden(true)
        self.reloadData()
        if (allCount == 0) {
            //如果tableview里面没有数据
            self.endLoadDataWithStatus(MudTableViewStatus.Empty)
            self.emptyViewHidden(false)
        } else if allCount >= self.pageSize && pageCount >= self.pageSize {
            //如果tableview里有整数倍的页数
            self.endLoadDataWithStatus(MudTableViewStatus.CanLoadMore)
        } else {
            //tableview里的数据不是整数页的
            self.endLoadDataWithStatus(MudTableViewStatus.NoMore)
        }
    }
    
    //MARK: Private
    func emptyViewHidden(hidden: Bool) {
        if self.emptyView != nil {
            if hidden {
                self.backgroundView = nil
                self.emptyView?.removeFromSuperview()
            } else {
                self.backgroundView = self.emptyBackgroundView
                if self.tableHeaderView != nil {
                    self.emptyView?.frame = CGRectMake(0, self.tableHeaderView!.bounds.size.height, self.bounds.size.width,  self.bounds.size.height-self.tableHeaderView!.bounds.size.height)
                } else {
                    self.emptyView?.center = CGPointMake(self.bounds.size.width/2,self.bounds.size.height/2)
                }
                self.addSubview(self.emptyView!)
            }
        }
    }
    
    private func endLoadDataWithStatus(status: MudTableViewStatus) {
        self.isLoading = false
        self.refreshHeaderView.refreshLastUpdatedDate()
        self.refreshHeaderView.refreshControlScrollViewDataSourceDidFinishedLoading(self)
        if status == MudTableViewStatus.Empty {
            self.tableFooterView = nil
            self.loadMoreView.status = FootViewStatus.NoMore
        } else if status == MudTableViewStatus.CanLoadMore {
            self.tableFooterView = self.loadMoreView
            self.loadMoreView.status = FootViewStatus.CanLoadMore
        } else if status == MudTableViewStatus.NoMore {
            self.tableFooterView = self.loadMoreView
            self.loadMoreView.status = FootViewStatus.NoMore
        }
    }
    
    //MARK: - header refresh delegate
    func refreshControlTableHeaderDidTriggerRefresh(control: MudRefreshControl) {
        self.page = 1
        self.isLoading = true
        if self.allDelegate != nil {
            self.allDelegate!.tableViewDidTriggerRefresh(self)
        }
    }
    
    func refreshControlTableHeaderDataSourceIsLoading(control: MudRefreshControl) -> Bool {
        return self.isLoading
    }
    
    func refreshControlTableHeaderDataSourceLastUpdated(control: MudRefreshControl) -> NSDate? {
        var date: NSDate? = NSUserDefaults.standardUserDefaults().objectForKey("EGODate") as? NSDate
        if (date == nil) {
            date = NSDate()
        }
        NSUserDefaults.standardUserDefaults().setObject(NSDate(),forKey:"EGODate")
        return date
    }
    
    func didTouchedWithStatus(status: FootViewStatus) {
        if status == FootViewStatus.CanLoadMore && self.isLoading == false {
            self.page += 1
            self.isLoading = true
            if self.allDelegate != nil {
                self.allDelegate!.tableViewDidTriggerLoadMore(self)
            }
        }
    }
}
