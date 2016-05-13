//
//  String+Category.swift
//  Travel
//
//  Created by TimTiger on 5/11/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import Foundation
import UIKit

extension String {
    //MARK: - String format
    static func isValidString(string: String,format: String)->Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", format)
        let ret: Bool = emailTest.evaluateWithObject(string)
        return ret
    }
    
    static func isEmptyString(str: String?)->Bool {
        if str == nil {
            return true
        }
        if str?.length() < 1 {
            return true
        }
        return false
    }
    
    static func hasCharacter(str: String?)->Bool {
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
    
    static func isNotEmptyString(str: String?)->Bool {
        if String.isEmptyString(str) {
            return false
        }
        return true
    }
    
    //MARK: - String Preprotitys
    func length()->Int {
        return self.characters.count
    }
    
    func stringToNSDate()->NSDate {
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
    
    func stringToLocalizedTime()->String {
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
    
    func stringToTime()->String {
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
    
    static func currentDateString()->String {
        let curDate: NSDate = NSDate()
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.stringFromDate(curDate)
    }
    
    //MARK: - Substring
    func getSubstringFromIndex(index: Int,distance: Int)->String {
        let sIndex = self.startIndex.advancedBy(index)
        let eIndex = sIndex.advancedBy(distance)
        return self.substringToIndex(eIndex)
    }
    
    func compareOtherString(string: String!)->NSComparisonResult {
        if self.intValue > string.intValue {
            return NSComparisonResult.OrderedAscending
        }
        return NSComparisonResult.OrderedDescending
    }

}