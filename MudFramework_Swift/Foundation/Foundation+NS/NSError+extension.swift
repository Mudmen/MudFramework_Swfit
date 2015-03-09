//
//  NSError+extension.swift
//  Travel
//
//  Created by TimTiger on 2/6/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import Foundation

extension NSError {
    /**
    * create a NSError 
    * domain : alert title 
    * localizedDes : error describtion
    * code : error code
    **/
    class func errorWithDomain(domain: String, localizedDescription localizedDes: String, errorCode code: Int)->NSError {
        var userinfo: NSDictionary = NSDictionary(objectsAndKeys:localizedDes,NSLocalizedDescriptionKey)
        var error: NSError = NSError(domain: domain, code: code, userInfo: userinfo)
        return error
    }
}