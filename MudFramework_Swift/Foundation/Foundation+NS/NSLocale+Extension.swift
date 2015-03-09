//
//  NSLocale+Extension.swift
//  Travel
//
//  Created by TimTiger on 2/7/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import Foundation

extension NSLocale {
    //get current system language
    class func systemLanguage()->String {
        var lanArray: Array =  NSLocale.preferredLanguages()
        var language: String = lanArray[0] as String
        if (language == "zh-Hans" || language == "zh-Hant") {
            language = "zh_CN"
        } else {
            language = "en_US"
        }
        return language
    }
    
    //current language is english or not
    class func isEnglish()->Bool {
        var lanArray: Array =  NSLocale.preferredLanguages()
        var language: String = lanArray[0] as String
        if (language == "zh-Hans" || language == "zh-Hant") {
            return false
        } else {
            return true
        }
    }
}