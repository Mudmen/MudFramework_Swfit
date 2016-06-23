//
//  MudTableViewController.swift
//  BorrowNote
//
//  Created by TimTiger on 11/23/14.
//  Copyright (c) 2014 Mudmen. All rights reserved.
//

import UIKit

public class MudTableViewController: UITableViewController {

   public weak var dataDelegate: MudTableViewControllerdelegate?
   public private(set) var firstAppear = true
   public private(set) var isTopViewController = false
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.addNotificationObserver()
        initData()
        initView()
    }
    
    public func viewFirstDidAppear(animated: Bool = true) {
        
    }
    
    public func initView() {
        
    }
    
    public func initData() {
        
    }
    
    public func refreshView() {
        
    }
    
    public func refreshData() {
        
    }
    
    override public func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if self.firstAppear {
            self.viewFirstDidAppear(animated)
            self.firstAppear = false
        }
        self.isTopViewController = true
    }
    
    override public func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.isTopViewController = false
    }
    
    //MARK: - deinit
    deinit {
        MudPrint("deinit MudTableViewController ====== ")
        removeNotificationObserver()
    }
}

public extension MudTableViewController {
    public func pushToViewController(controller: UIViewController,animated: Bool) {
        controller.hidesBottomBarWhenPushed = true
        if self.navigationController != nil {
            self.navigationController?.pushViewController(controller, animated: animated)
        } else if self.parentViewController != nil {
            if (self.parentViewController?.isKindOfClass(UINavigationController) == true) {
                (self.parentViewController as! UINavigationController).pushViewController(controller, animated: animated)
            } else if self.parentViewController?.navigationController != nil {
                self.parentViewController?.navigationController?.pushViewController(controller, animated: animated)
            }
        }
    }
    
    public func popViewControllerAnimated(animated: Bool) {
        if self.navigationController != nil && self.navigationController!.viewControllers.count > 0 {
            if self.navigationController?.viewControllers[0] != self {
                self.navigationController?.popViewControllerAnimated(animated)
                return
            }
        }
        self.dismissCurrentModalViewController()
    }
    
    public func popViewControllerWithData(data: AnyObject? ,animated: Bool) {
        if self.dataDelegate != nil {
            self.dataDelegate?.dataFromTopViewController(data,tag: String(UTF8String: object_getClassName(self)) )
        }
        self.navigationController?.popViewControllerAnimated(animated)
    }
    
    public func exitViewControllerWithData(data: AnyObject?) {
        if self.dataDelegate != nil {
            self.dataDelegate?.dataFromTopViewController(data,tag: String(UTF8String: object_getClassName(self)) )
        }
    }
    
    public func popToBeforeControllerAnimated(animated: Bool) {
        for index in 0 ..< self.navigationController!.viewControllers.count {
            let tvc: UIViewController? = self.navigationController?.viewControllers[index]
            if tvc != nil && tvc == self && index > 0{
                let tovc: UIViewController? = self.navigationController?.viewControllers[index-2]
                if tovc != nil {
                    self.navigationController?.popToViewController(tovc!, animated: animated)
                }
            }
        }
    }
    
    public func dismissCurrentModalViewController() {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
    }
    
}

public extension MudTableViewController {
    public func addNotificationObserver() {
        
    }
    public func removeNotificationObserver() {
        
    }
    
    public func addObserveNotificationWithName(aName: String) {
        NSNotificationCenter.defaultCenter().addObserver(self,selector:#selector(MudTableViewController.handNotification(_:)),name: aName,object:nil)
    }
    
    public func addObserveNotificationWithName(aName: String, object anObject: AnyObject) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MudTableViewController.handNotification(_:)), name: aName, object: anObject)
    }
    
    public func removeObserverNotificationWithName(aName: String) {
        NSNotificationCenter.defaultCenter().removeObserver(self,name:aName,object:nil)
    }
    
    public func removeObserverNotificationWithName(aName: String,anObject: AnyObject) {
        NSNotificationCenter.defaultCenter().removeObserver(self,name:aName,object:anObject)
    }
    
    public func postNotification(notification: NSNotification) {
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    
    public func postNotificationName(aName: String?, anObject:AnyObject?) {
        NSNotificationCenter.defaultCenter().postNotificationName(aName!,object:anObject)
    }
    
    public func postNotificationName(aName: String, anObject:AnyObject, userInfo aUserInfo:  [NSObject : AnyObject]) {
        NSNotificationCenter.defaultCenter().postNotificationName(aName,object:anObject,userInfo:aUserInfo)
    }
    
    public func handNotification(notification: NSNotification) {
        
    }
}

public extension MudTableViewController {
    public func setBackBarButtonWithImage(image: UIImage?) {
        self.navigationItem.leftBarButtonItem = nil;
        let backItem: UIBarButtonItem = UIBarButtonItem.itemWithImage(image, target: self, action: #selector(MudTableViewController.onBackButtonAction(_:)))
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    public func setBackBarButtonWithCustomView(customView: UIView) {
        self.navigationItem.leftBarButtonItem = nil;
        let backItem:UIBarButtonItem = UIBarButtonItem(customView: customView)
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    public func setLeftBarButtonWithImage(image: UIImage?) {
        self.navigationItem.leftBarButtonItem = nil;
        let backItem: UIBarButtonItem = UIBarButtonItem.itemWithImage(image,target:self,action:#selector(MudTableViewController.onLeftButtonAction(_:)))
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    public func setRightBarButtonWithImage(image: UIImage?) {
        self.navigationItem.rightBarButtonItem = nil;
        let rightItem: UIBarButtonItem = UIBarButtonItem.itemWithImage(image ,target:self ,action:#selector(MudTableViewController.onRightButtonAction(_:)))
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    
    public func setRightBarButtonWithTitle(title: String,titleColor: UIColor? = nil,textAlignment: UIControlContentHorizontalAlignment = UIControlContentHorizontalAlignment.Right) {
        self.navigationItem.rightBarButtonItem = nil;
        let rightItem:UIBarButtonItem = UIBarButtonItem.itemWithTitle(title ,target:self ,action:#selector(MudTableViewController.onRightButtonAction(_:)),titleColor: titleColor,textAlignment: textAlignment)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    public func setLeftBarButtonWithTitle(title: String,titleColor: UIColor? = nil,textAlignment: UIControlContentHorizontalAlignment = UIControlContentHorizontalAlignment.Left) {
        self.navigationItem.leftBarButtonItem = nil;
        let leftItem:UIBarButtonItem = UIBarButtonItem.itemWithTitle(title,target:self,action: #selector(MudTableViewController.onLeftButtonAction(_:)),titleColor: titleColor,textAlignment: textAlignment)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    public func hiddenRightBarButton() {
        self.navigationItem.rightBarButtonItem = nil;
        let rightItem: UIBarButtonItem = UIBarButtonItem.hiddenItem()
        self.navigationItem.setRightBarButtonItem(rightItem, animated: false)
    }
    
    public func hiddenBackBarButton() {
        self.navigationItem.rightBarButtonItem = nil;
        let backItem: UIBarButtonItem = UIBarButtonItem.hiddenItem()
        self.navigationItem.leftBarButtonItems = [backItem]
    }
    
    public func setRightBarButtonWithCustomView(customView: UIView) {
        self.navigationItem.rightBarButtonItem = nil;
        let rightItem: UIBarButtonItem = UIBarButtonItem(customView: customView)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    public func onLeftButtonAction(sender: AnyObject) {
        self.onBackButtonAction(sender)
    }
    
    public func onBackButtonAction(sender: AnyObject?) {
        if (self.navigationController?.viewControllers.count > 0) {
            let vc: UIViewController = self.navigationController!.viewControllers[0] 
            if (vc === self) {
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                })
                return
            }
        }
        self.popViewControllerAnimated(true)
    }
    
    public func onModalBackAction(sender: AnyObject?) {
        if (self.navigationController?.viewControllers.count > 0) {
            let vc: UIViewController = self.navigationController!.viewControllers[0] 
            if (vc === self) {
                self.navigationController?.dismissViewControllerAnimated(true, completion: { () -> Void in
                })
                return
            }
        }
        self.popViewControllerAnimated(true)
    }
    
    public func onRightButtonAction(sender: AnyObject?) {
        
    }
    
}

public protocol MudTableViewControllerdelegate: NSObjectProtocol {
    func dataFromTopViewController(data: AnyObject?,tag: String?)
}

