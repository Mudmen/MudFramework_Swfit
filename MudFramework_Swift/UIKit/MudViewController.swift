//
//  MudViewController.swift
//  MudFramework_Swift
//
//  Created by TimTiger on 1/26/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit
import Dispatch

public class MudViewController: UIViewController,UINavigationControllerDelegate {
    
    public weak var dataDelegate: MudViewControllerdelegate?
    public private(set) var isTopViewController = false
    public private(set) var firstAppear: Bool = true

    //MARK: - Life Cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.addNotificationObserver()
        initData()
        initView()
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        MudPrint("didReceiveMemoryWarning")
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
        MudPrint("deinit MudViewController ====== ")
        removeNotificationObserver()
    }

}

public extension MudViewController {
    func popViewControllerAnimated(animated: Bool) {
        if self.navigationController != nil && self.navigationController!.viewControllers.count > 0 {
            if self.navigationController?.viewControllers[0] != self {
                self.navigationController?.popViewControllerAnimated(animated)
                return
            }
        }
        self.dismissCurrentModalViewController()
    }
    
    public func popToRootViewController(animated: Bool) {
        if self.navigationController?.presentingViewController != nil {
            self.navigationController?.dismissViewControllerAnimated(animated, completion: { () -> Void in
            })
        } else {
            self.navigationController?.popToRootViewControllerAnimated(animated)
        }
    }
    
    public func popToFirstViewControllerAnimated(animated: Bool) {
        self.navigationController?.popToRootViewControllerAnimated(animated)
    }
    
    public func popToViewController(controller: UIViewController,animated: Bool) {
        self.navigationController?.popToViewController(controller, animated: animated)
    }
    
    public func popToBeforeControllerAnimated(animated: Bool) {
        for index in 0 ..< self.navigationController!.viewControllers.count {
            let tvc: UIViewController? = self.navigationController?.viewControllers[index]
            if tvc != nil && tvc == self && index > 1{
                let tovc: UIViewController? = self.navigationController?.viewControllers[index-2]
                if tovc != nil {
                    self.navigationController?.popToViewController(tovc!, animated: animated)
                }
            }
        }
    }
    
    public func popViewControllerWithData(data: AnyObject? ,animated: Bool) {
        if self.dataDelegate != nil {
            self.dataDelegate?.dataFromTopViewController(data,tag: String(UTF8String: object_getClassName(self)) )
        }
        self.navigationController?.popViewControllerAnimated(animated)
    }
    
    public func popToSelf(animated: Bool) {
        self.navigationController?.popToViewController(self, animated: animated)
    }
    
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
    
    public func presentToNaviViewController(modalViewController: UIViewController) {
        let navi = MudNavigationController(rootViewController: modalViewController)
        self.presentViewController(navi, animated: true) { () -> Void in
        }
    }
    
    public func presentToModalViewController(modalViewController: UIViewController) {
        self.presentViewController(modalViewController, animated: true) { () -> Void in
        }
    }
    
    public func dismissCurrentModalViewController() {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
    }
    
}

public extension MudViewController {
    public func addNotificationObserver() {
        
    }
    
    public func removeNotificationObserver() {
        
    }
    
    public func addObserveNotificationWithName(aName: String) {
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(MudViewController.handNotification(_:)),
                                                         name: aName,
                                                         object:nil)
    }
    
    public func addObserveNotificationWithName(aName: String, object anObject: AnyObject?) {
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(MudViewController.handNotification(_:)),
                                                         name: aName,
                                                         object: anObject)
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
    
    public func postNotificationName(aName: String, anObject:AnyObject?) {
        NSNotificationCenter.defaultCenter().postNotificationName(aName,object:anObject)
    }
    
    public func postNotificationName(aName: String, anObject:AnyObject?, userInfo aUserInfo:  [NSObject : AnyObject]?) {
        NSNotificationCenter.defaultCenter().postNotificationName(aName, object: anObject, userInfo: aUserInfo)
    }
    
    public func handNotification(notification: NSNotification) {
        
    }
    
    
}

extension MudViewController {
    func setBackBarButtonWithImage(image: UIImage?) {
        self.navigationItem.leftBarButtonItem = nil;
        let backItem: UIBarButtonItem = UIBarButtonItem.itemWithImage(image, target: self, action: #selector(MudViewController.onBackButtonAction(_:)))
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    func setBackBarButtonWithCustomView(customView: UIView) {
        self.navigationItem.leftBarButtonItem = nil;
        let backItem:UIBarButtonItem = UIBarButtonItem(customView: customView)
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    func setLeftBarButtonWithImage(image: UIImage?) {
        self.navigationItem.leftBarButtonItem = nil;
        let backItem: UIBarButtonItem = UIBarButtonItem.itemWithImage(image,target:self,action:#selector(MudViewController.onLeftButtonAction(_:)))
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    func setRightBarButtonWithImage(image: UIImage?) {
        self.navigationItem.rightBarButtonItem = nil;
        if image != nil {
            let rightItem: UIBarButtonItem = UIBarButtonItem.itemWithImage(image ,target:self ,action:#selector(MudViewController.onRightButtonAction(_:)))
            self.navigationItem.setRightBarButtonItem(rightItem, animated: false)
        }
    }
    
    func hiddenRightBarButton() {
        self.navigationItem.rightBarButtonItem = nil;
        let rightItem: UIBarButtonItem = UIBarButtonItem.hiddenItem()
        self.navigationItem.setRightBarButtonItem(rightItem, animated: false)
    }
    
    func setRightBarButtonWithTitle(title: String,titleColor: UIColor? = nil,textAlignment: UIControlContentHorizontalAlignment = UIControlContentHorizontalAlignment.Right) {
        self.navigationItem.rightBarButtonItem = nil;
        let rightItem:UIBarButtonItem = UIBarButtonItem.itemWithTitle(title ,target:self ,
                                                                      action:#selector(MudViewController.onRightButtonAction(_:)),
                                                                      titleColor: titleColor,
                                                                      textAlignment: textAlignment)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func setLeftBarButtonWithTitle(title: String,titleColor: UIColor? = nil,textAlignment: UIControlContentHorizontalAlignment = UIControlContentHorizontalAlignment.Left) {
        self.navigationItem.leftBarButtonItem = nil;
        let leftItem:UIBarButtonItem = UIBarButtonItem.itemWithTitle(title,target:self,
                                                                     action: #selector(MudViewController.onLeftButtonAction(_:)),
                                                                     titleColor: titleColor,
                                                                     textAlignment: textAlignment)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    func setRightBarButtonWithCustomView(customView: UIView) {
        self.navigationItem.rightBarButtonItem = nil;
        let rightItem: UIBarButtonItem = UIBarButtonItem(customView: customView)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func onLeftButtonAction(sender: AnyObject) {
        
    }
    
    func onBackButtonAction(sender: AnyObject) {
        if (self.navigationController?.viewControllers.count > 0) {
            let vc: UIViewController = self.navigationController!.viewControllers[0] 
            if (vc === self) {
                self.dismissViewControllerAnimated(true, completion: { () -> Void in})
                return
            }
        }
        self.popViewControllerAnimated(true)
    }
    
    func onRightButtonAction(sender: AnyObject?) {
        
    }
    
}

public protocol MudViewControllerdelegate: NSObjectProtocol {
    func dataFromTopViewController(data: AnyObject?,tag: String?)
}