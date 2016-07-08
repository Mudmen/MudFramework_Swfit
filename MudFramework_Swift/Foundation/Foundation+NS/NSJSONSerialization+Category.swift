//
//  NSJSONSerialization+Category.swift
//  Travel
//
//  Created by TimTiger on 5/2/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import Foundation

public extension NSJSONSerialization {
    public class func jsonStringWithObject(object: AnyObject)->String? {
        var jsonString:String?
        var jsonData: NSData?
        do {
            jsonData = try NSJSONSerialization.dataWithJSONObject(object, options: NSJSONWritingOptions.PrettyPrinted)
        } catch _ as NSError {
            jsonData = nil
        }
        if jsonData != nil {
            jsonString = NSString(data: jsonData!, encoding: NSUTF8StringEncoding) as? String
        } else {
            return nil
        }
        return jsonString!;
    }
    
    public class func arrayWithJsonString(jString: String)->[AnyObject]? {
        var array: [AnyObject]?
        let data = jString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        if data != nil {
            var tobject: AnyObject?
            do {
                tobject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves)
            } catch _ as NSError {
                tobject = nil
            }
            array = tobject as? [AnyObject]
        }
        return array
    }
}