//
//  MudFullScreenViewController.swift
//  Travel
//
//  Created by TimTiger on 15/12/19.
//  Copyright © 2015年 Mudmen. All rights reserved.
//

import UIKit

class MudFullScreenViewController: MudViewController {
    
    var topItem: UINavigationItem!
    var topTitle: String! {
        didSet {
            if self.topItem != nil {
                self.topItem.title = topTitle
            }
        }
    }
    var topAlpha: CGFloat! {
        didSet {
            if self.topBar != nil {
                self.topBar.refreshAlpha(topAlpha)
            }
        }
    }
    
    var topBar: MudNavigationView!
    var shouldUpdateNavigationBar = true
    var shouldUpdateWhenAppear = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.topBar)
    }
    
    override func initView() {
        super.initView()
        self.topBar = MudNavigationView.navigationView()
        self.topItem = UINavigationItem(title: "")
        self.topBar.navigationBar.pushNavigationItem(self.topItem, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.shouldUpdateNavigationBar {
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        } else if self.shouldUpdateWhenAppear {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.shouldUpdateWhenAppear = false
        self.shouldUpdateNavigationBar = true
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if self.shouldUpdateNavigationBar {
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    
    //MARK: - 
    override func setBackBarButtonWithImage(image: UIImage?) {
        self.topItem.leftBarButtonItem = nil;
        let backItem: UIBarButtonItem = UIBarButtonItem.itemWithImage(image, target: self, action: #selector(MudViewController.onBackButtonAction(_:)))
        self.topItem.leftBarButtonItem = backItem
    }
    
    override func setRightBarButtonWithImage(image: UIImage?) {
        self.topItem.rightBarButtonItem = nil;
        let rightItem: UIBarButtonItem = UIBarButtonItem.itemWithImage(image, target: self, action: #selector(MudViewController.onRightButtonAction(_:)))
        self.topItem.rightBarButtonItem = rightItem
    }
    
    override func hiddenRightBarButton() {
        self.topItem.rightBarButtonItem = nil;
        let rightItem: UIBarButtonItem = UIBarButtonItem.hiddenItem()
        self.topItem.setRightBarButtonItem(rightItem, animated: false)
    }

}
