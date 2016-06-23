//
//  MudFullScreenViewController.swift
//  Travel
//
//  Created by TimTiger on 15/12/19.
//  Copyright © 2015年 Mudmen. All rights reserved.
//

import UIKit

public class MudFullScreenViewController: MudViewController {
    
    
    public var topTitle: String! {
        didSet {
            if self.topItem != nil {
                self.topItem.title = topTitle
            }
        }
    }
    public var topAlpha: CGFloat! {
        didSet {
            if self.topBar != nil {
                self.topBar.refreshAlpha(topAlpha)
            }
        }
    }
    
    private var topItem: UINavigationItem!
    private var topBar: MudNavigationView!
    private var shouldUpdateNavigationBar = true
    private var shouldUpdateWhenAppear = false
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.topBar)
    }
    
    override public func initView() {
        super.initView()
        self.topBar = MudNavigationView.navigationView()
        self.topItem = UINavigationItem(title: "")
        self.topBar.navigationBar.pushNavigationItem(self.topItem, animated: true)
    }
    
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.shouldUpdateNavigationBar {
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        } else if self.shouldUpdateWhenAppear {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.shouldUpdateWhenAppear = false
        self.shouldUpdateNavigationBar = true
    }

    override public func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if self.shouldUpdateNavigationBar {
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    
    //MARK: - 
    override public func setBackBarButtonWithImage(image: UIImage?) {
        self.topItem.leftBarButtonItem = nil;
        let backItem: UIBarButtonItem = UIBarButtonItem.itemWithImage(image, target: self, action: #selector(MudViewController.onBackButtonAction(_:)))
        self.topItem.leftBarButtonItem = backItem
    }
    
    override public func setRightBarButtonWithImage(image: UIImage?) {
        self.topItem.rightBarButtonItem = nil;
        let rightItem: UIBarButtonItem = UIBarButtonItem.itemWithImage(image, target: self, action: #selector(MudViewController.onRightButtonAction(_:)))
        self.topItem.rightBarButtonItem = rightItem
    }
    
    override public func hiddenRightBarButton() {
        self.topItem.rightBarButtonItem = nil;
        let rightItem: UIBarButtonItem = UIBarButtonItem.hiddenItem()
        self.topItem.setRightBarButtonItem(rightItem, animated: false)
    }

}
