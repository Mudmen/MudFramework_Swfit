//
//  MudURLSessionManager.swift
//  Travel
//
//  Created by TimTiger on 16/4/25.
//  Copyright © 2016年 Mudmen. All rights reserved.
//

import Foundation

public class MudURLSessionManager: NSObject {
    
    private var session: NSURLSession!
    
    convenience override init() {
        self.init(sessionConfiguration: nil)
    }
    
    init(sessionConfiguration configuration: NSURLSessionConfiguration?) {
        super.init()
        if configuration != nil {
            self.session = NSURLSession(configuration: configuration!, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        } else {
            self.session = NSURLSession()
        }
    }
    
    func dataTaskWithRequest(request: NSURLRequest,completionHandler: (response: NSURLResponse?,responseData: NSData?,error: NSError?) -> Void)->NSURLSessionDataTask {
        MudLog("%@", args: request.URL!)
        let dataTask = self.session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            completionHandler(response: response, responseData: data, error: error)
        }
        return dataTask
    }
}
