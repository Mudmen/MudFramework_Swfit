//
//  Dictionary+Category.swift
//  Travel
//
//  Created by TimTiger on 5/4/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import Foundation

extension Dictionary {
    
    static func hasContent(dic: MudDictionary?)->Bool {
        if dic == nil {
            return false
        }
        
        if dic?.count < 1 {
            return false
        }
        
        return true
    }
    
    static func isEmpty(object: AnyObject?)->Bool {
        
        if object == nil {
            return true
        }
        
        let dic = object as? MudDictionary
        if dic != nil && dic?.count < 1 {
            return true
        }
        
        let stringKeyDic = object as? MudStringKeyDictionary
        if stringKeyDic != nil && stringKeyDic?.count < 1 {
            return true
        }
        
        return false
    }
    
    func stringForKey(key: Key)->String {
        if let tvalue = self[key] as? String {
            return tvalue
        }
        if let tvalue = self[key] as? NSNumber {
            return String(format: "%@", tvalue)
        }
        return ""
    }
    
    func stringForKey(key: Key,placeholder: String)->String {
        if let tvalue = self[key] as? String {
            if String.isNotEmptyString(tvalue) {
                return tvalue
            }
        }
        return placeholder
    }
    
    func stringForKey(key: Key,placeholderKey: Key)->String {
        if let tvalue = self[key] as? String {
            if String.isNotEmptyString(tvalue) {
                return tvalue
            }
        }
        return self.stringForKey(placeholderKey)
    }
    
    func intForKey(key: Key,placeholder: Int? = 0)->Int {
        if let tvalue = self[key] as? NSNumber {
            return tvalue.integerValue
        } else if let svalue = self[key] as? String {
            return svalue.integerValue
        }
        return placeholder!
    }
    
    func numberForKey(key: Key)->NSNumber {
        if let tvalue = self[key] as? NSNumber {
            return tvalue
        } else if let svalue = self[key] as? String {
            return NSNumber(integer: svalue.integerValue)
        }
        return NSNumber(integer: 0)
    }
    
    func numberForKey(key: Key,placeholder: NSNumber)->NSNumber {
        if let tvalue = self[key] as? NSNumber {
            return tvalue
        } else if let svalue = self[key] as? String {
            return NSNumber(integer: svalue.integerValue)
        }
        return placeholder
    }
    
    func numberForKey(key: Key,placeholderKey: Key)->NSNumber {
        if let tvalue = self[key] as? NSNumber {
            return tvalue
        } else if let svalue = self[key] as? String {
            return NSNumber(integer: svalue.integerValue)
        }
        return self.numberForKey(placeholderKey)
    }
    
    func boolForKey(key: Key)->Bool {
        if let tvalue = self[key] as? NSNumber {
            return tvalue.boolValue
        } else if let svalue = self[key] as? String {
            return svalue.boolValue
        }
        return false
    }
    
    func floatForKey(key: Key)->Float {
        if let tvalue = self[key] as? NSNumber {
            return tvalue.floatValue
        } else if let svalue = self[key] as? String {
            return svalue.floatValue
        }
        return 0
    }
    
    func arrayForKey(akey: Key)->[AnyObject] {
        if let tvalue = self[akey] as? [AnyObject] {
            return tvalue
        }
        return []
    }
    
    func dictionaryArrayForKey(akey: Key)->MudDictionaryArray {
        if let tvalue = self[akey] as? MudDictionaryArray {
            return tvalue
        }
        return []
    }
    
    func dictionaryForKey(akey: Key)->MudDictionary {
        if let tvalue = self[akey] as? MudDictionary {
            return tvalue
        }
        return MudDictionary()
    }
    
    func isEmptyValueForKey(aKey: Key)->Bool {
        let tvalue = self[aKey]
        if tvalue == nil {
            return true
        }
        let tObject: AnyObject? = tvalue as? AnyObject
        if tObject?.isKindOfClass(NSNull) == true {
            return true
        }
        return false
    }
    
    func isNotEmptyValueForKey(aKey: Key)->Bool {
        let tvalue = self[aKey]
        if tvalue == nil {
            return false
        }
        let tObject: AnyObject? = tvalue as? AnyObject
        if tObject?.isKindOfClass(NSNull) == true {
            return false
        }
        return true
    }
    
}

extension NSDictionary {
    func stringForKey(aKey: String)->String {
        if let tvalue = self[aKey] as? String {
            return tvalue
        }
        if let tvalue = self[aKey] as? NSNumber {
            return String(format: "%@", tvalue)
        }
        return ""
    }
}