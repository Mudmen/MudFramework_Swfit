//
//  MudRequestBase.swift
//  Travel
//
//  Created by TimTiger on 1/29/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import Foundation
import UIKit

enum RequestMethod : Int {
    case GET = 1   //request
    case POST
    case PUT
}

private let currentVersion: String = UIApplication.formatCurrentVersion()

class MudRequestParam : NSObject {

    var requestUrl: String?
    var callbackPrefix: String?
    var params: NSMutableDictionary?
    var additionalParams: NSDictionary?
    var retryTimes: Int = 1
    var retryInterval: Int = 10
    var timeoutInterval: Int = 20
    var tag: String = "default"
    var method: RequestMethod = RequestMethod.GET
    var userinfo: [NSObject: AnyObject]?

    class func paramWithURLSting(requestUrl: String, andParams params: NSDictionary)->MudRequestParam {
        let reqParam:MudRequestParam = MudRequestParam()
        if params.count < 1 {
            reqParam.params = NSMutableDictionary(capacity: 0)
        } else {
            reqParam.params = NSMutableDictionary(dictionary: params)
        }
        if (reqParam.params?.objectForKey("platform") == nil) {
            reqParam.params?.setValue("iphone", forKey: "platform")
        }
        if (reqParam.params?.objectForKey("version") == nil) {
            reqParam.params?.setValue(currentVersion, forKey: "version")
        }
        if (reqParam.params?.objectForKey("device_id") == nil) {
            reqParam.params?.setValue(UIDevice.ADUDID(), forKey: "device_id")
        }
        if (reqParam.params?.objectForKey("language") == nil) {
            reqParam.params?.setValue(NSLocale.systemLanguage(), forKey: "language")
        }
        reqParam.requestUrl = requestUrl;
        reqParam.method = RequestMethod.GET;
        reqParam.retryTimes = 0;
        reqParam.timeoutInterval = 20;
        reqParam.retryInterval = 2;
        return reqParam;
    }

    class func generalParamWithURLSting(requestUrl: String, andParams params: NSDictionary ,withPrefix prefix: String)->MudRequestParam {
        let reqParam:MudRequestParam = MudRequestParam()
        reqParam.params = NSMutableDictionary(dictionary: params)
        reqParam.requestUrl = requestUrl;
        reqParam.method = RequestMethod.GET;
        reqParam.retryTimes = 0;
        reqParam.timeoutInterval = 20;
        reqParam.retryInterval = 2;
        reqParam.callbackPrefix = prefix
        return reqParam;
    }
    
    class func paramWithURLSting(requestUrl: String, andParams params: NSDictionary ,withPrefix prefix: String)->MudRequestParam {
        let reqParam:MudRequestParam = MudRequestParam.paramWithURLSting(requestUrl,andParams: params)
        reqParam.callbackPrefix = prefix
        return reqParam;
    }

    class func paramWithURLSting(requestUrl: String, andParams params: NSDictionary ,userinfo: [NSObject: AnyObject],withPrefix prefix: String)->MudRequestParam {
        let reqParam:MudRequestParam = MudRequestParam.paramWithURLSting(requestUrl,andParams: params)
        reqParam.userinfo = userinfo
        reqParam.callbackPrefix = prefix
        return reqParam;
    }
    
    class func paramWithURLSting(requestUrl: String, andParams params: NSDictionary ,additionParams otherPararms: NSDictionary,withPrefix prefix: String)->MudRequestParam {
        let reqParam:MudRequestParam = MudRequestParam.paramWithURLSting(requestUrl,andParams: params,withPrefix: prefix)
        reqParam.additionalParams = otherPararms;
        return reqParam
    }
}

class ResponderObject: NSObject
{
    weak var responder: AnyObject?
}

class MudRequestBase : NSObject
{
    var responders: NSMutableArray = NSMutableArray(capacity: 0)
    var baseURL:NSURL?
    
    override init() {
        super.init()
    }
    
    //添加、移除 网络回调响应者
    func addResponder(responder: AnyObject) {
        let lockQueue = dispatch_queue_create("LockQueue", DISPATCH_QUEUE_SERIAL)
        dispatch_sync(lockQueue) {
            // code
            for obj in self.responders {
                if (obj as! ResponderObject).responder === responder {
                    return;
                }
            }
            var responderObj:ResponderObject?
            responderObj = ResponderObject()
            responderObj!.responder = responder;
            self.responders.addObject(responderObj!)
        }
    }
    
    func removeResponder(responder: AnyObject){
        let lockQueue = dispatch_queue_create("LockQueue", DISPATCH_QUEUE_SERIAL)
        dispatch_sync(lockQueue) {
            for obj in self.responders {
                if (obj as! ResponderObject).responder === responder {
                    self.responders.removeObject(obj)
                    break;
                }
            }
        }
    }
    
    func removeAllResponder() {
        let lockQueue = dispatch_queue_create("LockQueue", DISPATCH_QUEUE_SERIAL)
        dispatch_sync(lockQueue) {
            self.responders.removeAllObjects()
        }
    }
    //TODO: - 接着写网络
    
}


