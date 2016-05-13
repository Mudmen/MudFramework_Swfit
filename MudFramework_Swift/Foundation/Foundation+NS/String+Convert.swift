//
//  String+Convert.swift
//  Travel
//
//  Created by TimTiger on 6/26/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import Foundation

extension String {
    var doubleValue: Double {
        return NSString(string: self).doubleValue
    }
    
    var floatValue: Float {
        return NSString(string: self).floatValue
    }
    
    var intValue: Int32 {
        return NSString(string: self).intValue
    }
    
    @available(iOS, introduced=2.0)
    var integerValue: Int {
        return NSString(string: self).integerValue
    }
    
    @available(iOS, introduced=2.0)
    var longLongValue: Int64 {
        return NSString(string: self).longLongValue
    }
    
    @available(iOS, introduced=2.0)
    var boolValue: Bool {
        return NSString(string: self).boolValue
    }
    
    //string
    static func optimizedString(text: String?)->String {
        if String.hasCharacter(text) {
            var resultString = text!.stringByReplacingOccurrencesOfString("\r", withString: "    ", options: NSStringCompareOptions.AnchoredSearch, range: nil)
            let set = NSCharacterSet.whitespaceAndNewlineCharacterSet()
            resultString = resultString.stringByTrimmingCharactersInSet(set)
            return resultString
        }
        return ""
    }
}