//
//  MudRequestBase.swift
//  Travel
//
//  Created by TimTiger on 1/29/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import Foundation

enum RequestMethod : Int {
    case GET = 1   //request
    case POST
    case PUT
}

class MudRequestParam : NSObject {

    var requestUrl: NSString?
    var callbackPrefix: NSString?
    var params: NSMutableDictionary?
    var additionalParams: NSDictionary?
    var retryTimes: Int = 1
    var retryInterval: Int = 10
    var timeoutInterval: Int = 20
    var tag: String = "default"
    var method: RequestMethod = RequestMethod.GET

    class func paramWithURLSting(requestUrl: NSString, andParams params: NSDictionary)->MudRequestParam {
        var reqParam:MudRequestParam = MudRequestParam()
        reqParam.params = NSMutableDictionary(dictionary: params)
        reqParam.requestUrl = requestUrl;
        reqParam.method = RequestMethod.GET;
        reqParam.retryTimes = 0;
        reqParam.timeoutInterval = 20;
        reqParam.retryInterval = 2;
        return reqParam;
    }

    class func paramWithURLSting(requestUrl: NSString, andParams params: NSDictionary ,withPrefix prefix: NSString)->MudRequestParam {
        var reqParam:MudRequestParam = MudRequestParam.paramWithURLSting(requestUrl,andParams: params)
        reqParam.callbackPrefix = prefix;
        return reqParam;
    }

    class func paramWithURLSting(requestUrl: NSString, andParams params: NSDictionary ,additionParams otherPararms: NSDictionary,withPrefix prefix: NSString)->MudRequestParam {
        var reqParam:MudRequestParam = MudRequestParam.paramWithURLSting(requestUrl,andParams: params,withPrefix: prefix)
        reqParam.additionalParams = otherPararms;
        return reqParam
    }

}

class ResponderObject: NSObject
{
    weak var responder: AnyObject!
}

class MudRequestBase : NSObject
{
    var responders: NSMutableArray
    var baseURL:NSURL?
    
    override init() {
        self.responders = NSMutableArray(capacity: 0)
        super.init()
    }
    
    //添加、移除 网络回调响应者
    func addResponder(responder: AnyObject) {
        let lockQueue = dispatch_queue_create("LockQueue", DISPATCH_QUEUE_SERIAL)
        dispatch_sync(lockQueue) {
            // code
            for obj in self.responders {
                if (obj as ResponderObject).responder === responder {
                    return;
                }
            }
            var responderObj:ResponderObject = ResponderObject()
            responderObj.responder = responder;
            self.responders.addObject(responderObj)
        }
    }
    
    func removeResponder(responder: AnyObject){
        let lockQueue = dispatch_queue_create("LockQueue", DISPATCH_QUEUE_SERIAL)
        dispatch_sync(lockQueue) {
            for obj in self.responders {
                if (obj as ResponderObject).responder === responder {
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


