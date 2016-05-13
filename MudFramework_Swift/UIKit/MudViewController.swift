//
//  MudViewController.swift
//  MudFramework_Swift
//
//  Created by TimTiger on 1/26/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit
import Dispatch

class MudViewController: UIViewController,UINavigationControllerDelegate {
    
    weak var dataDelegate: MudViewControllerdelegate?
    var isTopViewController = false
    var firstAppear: Bool = true

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        becomeRequestResponder()
        self.addNotificationObserver()
        initData()
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        MudPrint("didReceiveMemoryWarning")
    }
    
    func viewFirstDidAppear(animated: Bool = true) {
        
    }
    
    func initView() {
       
    }
    
    func initData() {
        
    }
    
    func refreshView() {
        
    }
    
    func refreshData() {
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if self.firstAppear {
            self.viewFirstDidAppear(animated)
            self.firstAppear = false
        }
        self.isTopViewController = true
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.isTopViewController = false
    }
    
    //MARK: - Private API
    func becomeRequestResponder() {
        MudRequestCenter.defaultCenter.addResponder(self)
    }
    
    func removeRequestResponder() {
        MudRequestCenter.defaultCenter.removeResponder(self)
    }
    
    //MARK: - deinit
    deinit {
        MudPrint("deinit MudViewController ====== ")
        removeRequestResponder();
        removeNotificationObserver()
    }

}

extension MudViewController {
    func popViewControllerAnimated(animated: Bool) {
        if self.navigationController != nil && self.navigationController!.viewControllers.count > 0 {
            if self.navigationController?.viewControllers[0] != self {
                self.navigationController?.popViewControllerAnimated(animated)
                return
            }
        }
        self.dismissCurrentModalViewController()
    }
    
    func popToRootViewController(animated: Bool) {
        if self.navigationController?.presentingViewController != nil {
            self.navigationController?.dismissViewControllerAnimated(animated, completion: { () -> Void in
            })
        } else {
            self.navigationController?.popToRootViewControllerAnimated(animated)
        }
    }
    
    func popToFirstViewControllerAnimated(animated: Bool) {
        self.navigationController?.popToRootViewControllerAnimated(animated)
    }
    
    func popToViewController(controller: UIViewController,animated: Bool) {
        self.navigationController?.popToViewController(controller, animated: animated)
    }
    
    func popToBeforeControllerAnimated(animated: Bool) {
        for var i = 0; i < self.navigationController?.viewControllers.count; i++ {
            let tvc: UIViewController? = self.navigationController?.viewControllers[i]
            if tvc != nil && tvc == self && i > 1{
                let tovc: UIViewController? = self.navigationController?.viewControllers[i-2]
                if tovc != nil {
                    self.navigationController?.popToViewController(tovc!, animated: animated)
                }
            }
        }
    }
    
    func popViewControllerWithData(data: AnyObject? ,animated: Bool) {
        if self.dataDelegate != nil && self.dataDelegate?.respondsToSelector("dataFromTopViewController:tag:") != nil {
            self.dataDelegate?.dataFromTopViewController(data,tag: String(UTF8String: object_getClassName(self)) )
        }
        self.navigationController?.popViewControllerAnimated(animated)
    }
    
    func popToSelf(animated: Bool) {
        self.navigationController?.popToViewController(self, animated: animated)
    }
    
    func pushToViewController(controller: UIViewController,animated: Bool) {
        
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
    
    func presentToNaviViewController(modalViewController: UIViewController) {
        let navi = MudNavigationController(rootViewController: modalViewController)
        self.presentViewController(navi, animated: true) { () -> Void in
        }
    }
    
    func presentToModalViewController(modalViewController: UIViewController) {
        self.presentViewController(modalViewController, animated: true) { () -> Void in
        }
    }
    
    func dismissCurrentModalViewController() {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
    }
    
}

extension MudViewController {
    func addNotificationObserver() {
        
    }
    func removeNotificationObserver() {
        
    }
    
    func addObserveNotificationWithName(aName: String) {
        NSNotificationCenter.defaultCenter().addObserver(self,selector:"handNotification:",name: aName,object:nil)
    }
    
    func addObserveNotificationWithName(aName: String, object anObject: AnyObject?) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handNotification:", name: aName, object: anObject)
    }
    
    func removeObserverNotificationWithName(aName: String) {
        NSNotificationCenter.defaultCenter().removeObserver(self,name:aName,object:nil)
    }
    
    func removeObserverNotificationWithName(aName: String,anObject: AnyObject) {
        NSNotificationCenter.defaultCenter().removeObserver(self,name:aName,object:anObject)
    }
    
    func postNotification(notification: NSNotification) {
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    
    func postNotificationName(aName: String, anObject:AnyObject?) {
        NSNotificationCenter.defaultCenter().postNotificationName(aName,object:anObject)
    }
    
    func postNotificationName(aName: String, anObject:AnyObject?, userInfo aUserInfo:  [NSObject : AnyObject]?) {
        NSNotificationCenter.defaultCenter().postNotificationName(aName, object: anObject, userInfo: aUserInfo)
    }
    
    func handNotification(notification: NSNotification) {
    }
    
    
}

extension MudViewController {
    func setBackBarButtonWithImage(image: UIImage?) {
        self.navigationItem.leftBarButtonItem = nil;
        let backItem: UIBarButtonItem = UIBarButtonItem.itemWithImage(image, target: self, action: "onBackButtonAction:")
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    func setBackBarButtonWithCustomView(customView: UIView) {
        self.navigationItem.leftBarButtonItem = nil;
        let backItem:UIBarButtonItem = UIBarButtonItem(customView: customView)
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    func setLeftBarButtonWithImage(image: UIImage?) {
        self.navigationItem.leftBarButtonItem = nil;
        let backItem: UIBarButtonItem = UIBarButtonItem.itemWithImage(image,target:self,action:"onLeftButtonAction:")
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    func setRightBarButtonWithImage(image: UIImage?) {
        self.navigationItem.rightBarButtonItem = nil;
        if image != nil {
            let rightItem: UIBarButtonItem = UIBarButtonItem.itemWithImage(image ,target:self ,action:"onRightButtonAction:")
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
        let rightItem:UIBarButtonItem = UIBarButtonItem.itemWithTitle(title ,target:self ,action:"onRightButtonAction:",titleColor: titleColor,textAlignment: textAlignment)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func setLeftBarButtonWithTitle(title: String,titleColor: UIColor? = nil,textAlignment: UIControlContentHorizontalAlignment = UIControlContentHorizontalAlignment.Left) {
        self.navigationItem.leftBarButtonItem = nil;
        let leftItem:UIBarButtonItem = UIBarButtonItem.itemWithTitle(title,target:self,action: "onLeftButtonAction:",titleColor: titleColor,textAlignment: textAlignment)
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

protocol MudViewControllerdelegate: NSObjectProtocol {
    func dataFromTopViewController(data: AnyObject?,tag: String?)
}