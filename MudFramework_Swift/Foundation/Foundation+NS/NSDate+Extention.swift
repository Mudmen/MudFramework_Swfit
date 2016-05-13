//
//  NSDate+Extention.swift
//  Travel
//
//  Created by TimTiger on 3/15/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

//import Foundation
//let D_MINUTE  =  60.0
//let D_HOUR    =  3600.0
//let D_DAY     =  86400
//let D_WEEK    =  604800
//let D_YEAR    =  31556926
//
//let DATE_COMPONENTS : NSCalendarUnit = [NSCalendarUnit.Year,NSCalendarUnit.Month, NSCalendarUnit.Day,NSCalendarUnit.WeekOfYear,NSCalendarUnit.Weekday, NSCalendarUnit.WeekdayOrdinal , NSCalendarUnit.Hour , NSCalendarUnit.Minute , NSCalendarUnit.Second]
//var CURRENT_CALENDAR =  NSCalendar.currentCalendar()

//extension NSDate {

//    func isToday()->Bool {
//        return self.isEqualToDateIgnoringTime(NSDate())
//    }
//    
//    func isEqualToDateIgnoringTime(aDate: NSDate)->Bool
//    {
//        let  components1:NSDateComponents =  CURRENT_CALENDAR.components(DATE_COMPONENTS, fromDate: self)
//        let components2: NSDateComponents =  CURRENT_CALENDAR.components(DATE_COMPONENTS, fromDate: aDate)
//        
//        return (components1.year == components2.year) &&
//            (components1.month == components2.month) &&
//            (components1.day == components2.day);
//    }
//    
//    
//    func minutesAfterDate(aDate: NSDate)->NSInteger
//    {
//        let ti: NSTimeInterval = self.timeIntervalSinceDate(aDate)
//        return (NSInteger)(ti / D_MINUTE)
//    }
//    
//    func minutesBeforeDate(aDate: NSDate)->NSInteger
//    {
//        let ti: NSTimeInterval = self.timeIntervalSinceDate(self)
//        return (NSInteger)(ti / D_MINUTE)
//    }
//    
//    func hoursAfterDate(aDate: NSDate)->NSInteger
//    {
//        let ti: NSTimeInterval = self.timeIntervalSinceDate(aDate)
//        return (NSInteger)(ti / D_HOUR)
//    }

//}