//
//  MudTableViewController.swift
//  BorrowNote
//
//  Created by TimTiger on 11/23/14.
//  Copyright (c) 2014 Mudmen. All rights reserved.
//

import UIKit

class MudTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.initData()
        self.initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        
    }
    
    func initData() {
        
    }
    
    func refreshView() {
        
    }
    
    func refreshData() {

    }
    
    func setCustomBackItem() {
        //Custom your back item
        var item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: Selector("onBackItemAction"))
        self.navigationItem.leftBarButtonItem = item
    }
    
    func onBackItemAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func setRightItemWithCustomView(customView: UIView) {
        var item = UIBarButtonItem(customView: customView)
        self.navigationItem.rightBarButtonItem = item
    }
    
    func pushToViewController(controller: UIViewController,animated: Bool) {
        self.navigationController?.pushViewController(controller, animated: animated)
    }

}
