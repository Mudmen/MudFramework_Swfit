//
//  String+Category.swift
//  Travel
//
//  Created by TimTiger on 5/11/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    //MARK: - String format
    public static func isValidString(string: String,format: String)->Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", format)
        let ret: Bool = emailTest.evaluateWithObject(string)
        return ret
    }
    
    public static func isEmptyString(str: String?)->Bool {
        if str == nil {
            return true
        }
        if str?.length() < 1 {
            return true
        }
        return false
    }
    
    public static func hasCharacter(str: String?)->Bool {
        if String.isEmptyString(str) {
            return false
        }
        if str!.length() < 1 {
            return false
        }

        var resultString = str!.stringByReplacingOccurrencesOfString("\r", withString: "    ", options: [], range: nil)
        let set = NSCharacterSet.whitespaceAndNewlineCharacterSet()
        resultString = resultString.stringByTrimmingCharactersInSet(set)
        if resultString.length() < 1 {
            return false
        }
        return true
    }
    
    public static func isNotEmptyString(str: String?)->Bool {
        if String.isEmptyString(str) {
            return false
        }
        return true
    }
    
    //MARK: - String Preprotitys
    public func length()->Int {
        return self.characters.count
    }
    
    public func stringToNSDate()->NSDate {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        var format: String = "yyyy-MM-dd HH:mm:ss";
        if (self.length() < format.length())
        {
            let index = format.endIndex.advancedBy(-1);
            format = format.substringToIndex(index)
            dateFormatter.dateFormat = format
            let date: NSDate = dateFormatter.dateFromString(self as String)!
            return date;
        } else if (self.length() > format.length())
        {
            let index = format.endIndex.advancedBy(-1);
            let string = self.substringToIndex(index)
            dateFormatter.dateFormat = format as String
            let date: NSDate = dateFormatter.dateFromString(string as String)!
            return date;
        } else {
            dateFormatter.dateFormat = format as String
            let date: NSDate = dateFormatter.dateFromString(self as String)!
            return date;
        }
    }
    
    public func stringToLocalizedTime()->String {
        let tcreated: NSTimeInterval = (self as NSString).doubleValue
        let postDate = NSDate(timeIntervalSince1970: tcreated)
        let format: NSDateFormatter = NSDateFormatter()
        format.dateFormat = String(format: "yyyy%@MM%@dd%@",MudLocalString.stringForKey("TimeSeparatorYear", tableName: "MudLocalization"),MudLocalString.stringForKey("TimeSeparatorMonth", tableName: "MudLocalization"),MudLocalString.stringForKey("TimeSeparatorDay", tableName: "MudLocalization"))
        //
        let receiveTime = format.stringFromDate(postDate)
        if String.isEmptyString(receiveTime) {
            return ""
        }
        return receiveTime
    }
    
    public func stringToTime()->String {
        let tcreated: NSTimeInterval = (self as NSString).doubleValue
        let postDate = NSDate(timeIntervalSince1970: tcreated)
        let format: NSDateFormatter = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let receiveTime = format.stringFromDate(postDate)
        if String.isEmptyString(receiveTime) {
            return ""
        }
        return receiveTime
    }
    
    public static func currentDateString()->String {
        let curDate: NSDate = NSDate()
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.stringFromDate(curDate)
    }
    
    //MARK: - Substring
    public func getSubstringFromIndex(index: Int,distance: Int)->String {
        let sIndex = self.startIndex.advancedBy(index)
        let eIndex = sIndex.advancedBy(distance)
        return self.substringToIndex(eIndex)
    }
    
    public func compareOtherString(string: String!)->NSComparisonResult {
        if self.intValue > string.intValue {
            return NSComparisonResult.OrderedAscending
        }
        return NSComparisonResult.OrderedDescending
    }
    
    /**
     16进制字符串 转NSData
     
     - parameter hexString: 字符串
     
     - returns: NSData
     */
    public static func dataFromHexString(hexString: String) -> NSData?
    {
        var str = hexString.stringByReplacingOccurrencesOfString("<", withString: "")
        str = hexString.stringByReplacingOccurrencesOfString(">", withString: "")
        str = hexString.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        let nsstr = str as NSString
        
        let chars = nsstr.UTF8String
        var i = 0
        let len = nsstr.length;
        
        let data = NSMutableData(capacity: len/2)
        var byteChars:[CChar] = [0,0]
        
        var wholeByte :CUnsignedLong
        while (i < len)
        {
            byteChars[0] = chars[i++];
            byteChars[1] = chars[i++];
            wholeByte = strtoul(byteChars, nil, 16);
            data?.appendBytes(&wholeByte, length: 1)
        }
        return data;
    }

}