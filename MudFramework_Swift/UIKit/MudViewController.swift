//
//  MudViewController.swift
//  MudFramework_Swift
//
//  Created by TimTiger on 1/26/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit

class MudViewController: UIViewController {
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        becomeRequestResponder()
        addNotificationObserver()
        initData()
        initView()
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
    
    //MARK: - Private API
    private func becomeRequestResponder() {
        MudRequestCenter.defaultCenter.addResponder(self)
    }
    
    private func removeRequestResponder() {
        MudRequestCenter.defaultCenter.removeResponder(self)
    }
    
    //MARK: - deinit
    deinit {
        removeRequestResponder();
        removeNotificationObserver()
    }
}

extension MudViewController {
    func pushToViewController(controller: UIViewController,animated: Bool) {
        self.navigationController?.pushViewController(controller, animated: animated)
    }
    
    func popViewControllerAnimated(animated: Bool) {
        self.navigationController?.popViewControllerAnimated(animated)
    }
    
}

extension MudViewController {
    func addNotificationObserver() {
        
    }
    func removeNotificationObserver() {
        
    }
    
    func addObserveNotificationWithName(aName: NSString) {
        NSNotificationCenter.defaultCenter().addObserver(self,selector:"handNotification:",name: aName,object:nil)
    }
    
    func addObserveNotificationWithName(aName: NSString, object anObject: AnyObject) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handNotification:", name: aName, object: anObject)
    }
    
    func removeObserverNotificationWithName(aName: NSString) {
        NSNotificationCenter.defaultCenter().removeObserver(self,name:aName,object:nil)
    }
    
    func removeObserverNotificationWithName(aName: NSString,anObject: AnyObject) {
        NSNotificationCenter.defaultCenter().removeObserver(self,name:aName,object:anObject)
    }
    
    func postNotification(notification: NSNotification) {
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    
    func postNotificationName(aName: NSString, anObject:AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(aName,object:anObject)
    }
    
    func postNotificationName(aName: NSString, anObject:AnyObject, userInfo aUserInfo: NSDictionary) {
        NSNotificationCenter.defaultCenter().postNotificationName(aName,object:anObject,userInfo:aUserInfo)
    }
    
    func handNotification(notifacation: NSNotification) {
        
    }
}

extension MudViewController {
    func setBackBarButtonWithImage(image: UIImage?) {
        self.navigationItem.leftBarButtonItem = nil;
        var backItem: UIBarButtonItem = UIBarButtonItem.itemWithImage(image, target: self, action: "onBackButtonAction:")
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    func setBackBarButtonWithCustomView(customView: UIView) {
        self.navigationItem.leftBarButtonItem = nil;
        var backItem:UIBarButtonItem = UIBarButtonItem(customView: customView)
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    func setLeftBarButtonWithImage(image: UIImage?) {
        self.navigationItem.leftBarButtonItem = nil;
        var backItem: UIBarButtonItem = UIBarButtonItem.itemWithImage(image,target:self,action:"onLeftButtonAction:")
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    func setRightBarButtonWithImage(image: UIImage?) {
        self.navigationItem.rightBarButtonItem = nil;
        var rightItem: UIBarButtonItem = UIBarButtonItem.itemWithImage(image ,target:self ,action:"onRightButtonAction:")
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    
    func setRightBarButtonWithTitle(title: NSString) {
        self.navigationItem.rightBarButtonItem = nil;
        var rightItem:UIBarButtonItem = UIBarButtonItem.itemWithTitle(title ,target:self ,action:"onRightButtonAction:")
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func setLeftBarButtonWithTitle(title: NSString) {
        self.navigationItem.leftBarButtonItem = nil;
        var leftItem:UIBarButtonItem = UIBarButtonItem.itemWithTitle(title,target:self,action: "onLeftButtonAction:")
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    func setRightBarButtonWithCustomView(customView: UIView) {
        self.navigationItem.rightBarButtonItem = nil;
        var rightItem: UIBarButtonItem = UIBarButtonItem(customView: customView)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func onLeftButtonAction(sender: AnyObject) {
        
    }
    
    func onBackButtonAction(sender: AnyObject) {
        self.popViewControllerAnimated(true)
    }
    
    func onRightButtonAction(sender: AnyObject) {
        
    }
    
}