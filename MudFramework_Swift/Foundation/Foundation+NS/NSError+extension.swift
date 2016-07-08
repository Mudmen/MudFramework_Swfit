//
//  NSError+extension.swift
//  Travel
//
//  Created by TimTiger on 2/6/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import Foundation

public extension NSError {
    /**
    * create a NSError 
    * domain : alert title 
    * localizedDes : error describtion
    * code : error code
    **/
    public class func getErrorWithDomain(domain: String, localizedDescription localizedDes: String, errorCode code: Int)->NSError {
        let userinfo: Dictionary =  [NSLocalizedDescriptionKey: localizedDes]
        let error: NSError = NSError(domain: domain, code: code, userInfo: userinfo)
        return error
    }
}