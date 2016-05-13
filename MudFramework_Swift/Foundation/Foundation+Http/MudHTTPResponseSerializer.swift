//
//  MudHTTPResponseSerializer.swift
//  Travel
//
//  Created by TimTiger on 16/4/26.
//  Copyright © 2016年 Mudmen. All rights reserved.
//

import Foundation

public class MudHTTPResponseSerializer: NSObject {
    public func responseObjectForData(data: NSData) throws ->AnyObject {
        do {
              let jsonData = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
              return jsonData
        } catch let error as NSError {
            throw(error)
        }
    }
}

public class MudResultCodeCheck: NSObject {
    class func isValidCode(resultcode: String)->Bool {
        if (resultcode.compare("OK", options: NSStringCompareOptions.CaseInsensitiveSearch) == NSComparisonResult.OrderedSame)
            || (resultcode.compare("true", options: NSStringCompareOptions.CaseInsensitiveSearch) == NSComparisonResult.OrderedSame)
            || (resultcode.compare("1", options: NSStringCompareOptions.CaseInsensitiveSearch) == NSComparisonResult.OrderedSame) {
            return true
        }
        return false
    }
    
    class func isValidResultCode(resultDic: [NSObject: AnyObject]?)->Bool {
        
        if resultDic == nil {
            return false
        }
        
        let resultcode = resultDic!.stringForKey("retcode")
        if (resultcode.compare("OK", options: NSStringCompareOptions.CaseInsensitiveSearch) == NSComparisonResult.OrderedSame)
            || (resultcode.compare("true", options: NSStringCompareOptions.CaseInsensitiveSearch) == NSComparisonResult.OrderedSame)
            || (resultcode.compare("1", options: NSStringCompareOptions.CaseInsensitiveSearch) == NSComparisonResult.OrderedSame) {
            return true
        }
        return false
    }
    
    class func isInvalidResultCode(resutDic: [NSObject: AnyObject])->Bool {
        let resultcode = resutDic.stringForKey("retcode")
        if (resultcode.compare("NO", options: NSStringCompareOptions.CaseInsensitiveSearch) == NSComparisonResult.OrderedSame)
            || (resultcode.compare("false", options: NSStringCompareOptions.CaseInsensitiveSearch) == NSComparisonResult.OrderedSame)
            || (resultcode.compare("0", options: NSStringCompareOptions.CaseInsensitiveSearch) == NSComparisonResult.OrderedSame) {
            return true
        }
        return false
    }
}

