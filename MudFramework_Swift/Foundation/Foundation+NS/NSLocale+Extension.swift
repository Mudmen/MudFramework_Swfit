//
//  NSLocale+Extension.swift
//  Travel
//
//  Created by TimTiger on 2/7/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import Foundation

extension NSLocale {
    class func systemLanguage()->String {
        var lanArray: Array =  NSLocale.preferredLanguages()
        var language: String = lanArray[0] 
        if language == "zh-Hans" || language == "zh-Hant" || language == "zh-HK" || language == "zh-TW" {
            language = "zh_CN"
        } else {
            language = "en_US"
        }
        return language
    }
    
    class func isEnglish()->Bool {
        var lanArray: Array =  NSLocale.preferredLanguages()
        let language: String = lanArray[0] 
        if (language == "en" || language == "en-GB" || language == "en-US") {
            return true
        } else {
            return false
        }
    }
}