//
//  MudHttpReqManager.swift
//  Travel
//
//  Created by TimTiger on 16/4/25.
//  Copyright © 2016年 Mudmen. All rights reserved.
//

import UIKit

private let shareInstance = MudHttpReqManager()

public class MudHttpReqManager: NSObject {
    
    private var sessionManager: MudHttpSessionManager!
    
    class func sharedManager()->MudHttpReqManager {
        return shareInstance
    }
    
    override init() {
        super.init()
        let defaultConfigObject = NSURLSessionConfiguration.defaultSessionConfiguration()
        var cachePath = "/MudCacheDirectory"
        if TARGET_OS_SIMULATOR == 1 {
            cachePath = NSTemporaryDirectory().stringByAppendingString("/mudurlsession.cache")
        }
        let myCache = NSURLCache(memoryCapacity: 16384,diskCapacity: 268435456 ,diskPath: cachePath)
        defaultConfigObject.URLCache = myCache
        defaultConfigObject.requestCachePolicy = NSURLRequestCachePolicy.UseProtocolCachePolicy
        self.sessionManager = MudHttpSessionManager(baseURL: "",sessionConfiguration: defaultConfigObject)
    }
    
    class func sendRequest(request: MudHttpRequest,success: (responseObject: AnyObject) -> Void,failure: (error: NSError) -> Void) {
        MudHttpReqManager.sharedManager().sessionManager.sendRequest(request, success: { (responseObject) in
            success(responseObject: responseObject)
        }) { (error) in
            failure(error: error)
        }
    }
}
