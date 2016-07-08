//
//  Dictionary+Category.swift
//  Travel
//
//  Created by TimTiger on 5/4/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    public static func hasContent(dic: MudDictionary?)->Bool {
        if dic == nil {
            return false
        }
        
        if dic?.count < 1 {
            return false
        }
        
        return true
    }
    
    public static func isEmpty(object: AnyObject?)->Bool {
        
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
    
    public func stringForKey(key: Key)->String {
        if let tvalue = self[key] as? String {
            return tvalue
        }
        if let tvalue = self[key] as? NSNumber {
            return String(format: "%@", tvalue)
        }
        return ""
    }
    
    public func stringForKey(key: Key,placeholder: String)->String {
        if let tvalue = self[key] as? String {
            if String.isNotEmptyString(tvalue) {
                return tvalue
            }
        }
        return placeholder
    }
    
    public func stringForKey(key: Key,placeholderKey: Key)->String {
        if let tvalue = self[key] as? String {
            if String.isNotEmptyString(tvalue) {
                return tvalue
            }
        }
        return self.stringForKey(placeholderKey)
    }
    
    public func intForKey(key: Key,placeholder: Int? = 0)->Int {
        if let tvalue = self[key] as? NSNumber {
            return tvalue.integerValue
        } else if let svalue = self[key] as? String {
            return svalue.integerValue
        }
        return placeholder!
    }
    
    public func numberForKey(key: Key)->NSNumber {
        if let tvalue = self[key] as? NSNumber {
            return tvalue
        } else if let svalue = self[key] as? String {
            return NSNumber(integer: svalue.integerValue)
        }
        return NSNumber(integer: 0)
    }
    
    public func numberForKey(key: Key,placeholder: NSNumber)->NSNumber {
        if let tvalue = self[key] as? NSNumber {
            return tvalue
        } else if let svalue = self[key] as? String {
            return NSNumber(integer: svalue.integerValue)
        }
        return placeholder
    }
    
    public func numberForKey(key: Key,placeholderKey: Key)->NSNumber {
        if let tvalue = self[key] as? NSNumber {
            return tvalue
        } else if let svalue = self[key] as? String {
            return NSNumber(integer: svalue.integerValue)
        }
        return self.numberForKey(placeholderKey)
    }
    
    public func boolForKey(key: Key)->Bool {
        if let tvalue = self[key] as? NSNumber {
            return tvalue.boolValue
        } else if let svalue = self[key] as? String {
            return svalue.boolValue
        }
        return false
    }
    
    public func floatForKey(key: Key)->Float {
        if let tvalue = self[key] as? NSNumber {
            return tvalue.floatValue
        } else if let svalue = self[key] as? String {
            return svalue.floatValue
        }
        return 0
    }
    
    public func arrayForKey(akey: Key)->[AnyObject] {
        if let tvalue = self[akey] as? [AnyObject] {
            return tvalue
        }
        return []
    }
    
    public func dictionaryArrayForKey(akey: Key)->MudDictionaryArray {
        if let tvalue = self[akey] as? MudDictionaryArray {
            return tvalue
        }
        return []
    }
    
    public func dictionaryForKey(akey: Key)->MudDictionary {
        if let tvalue = self[akey] as? MudDictionary {
            return tvalue
        }
        return MudDictionary()
    }
    
    public func isEmptyValueForKey(aKey: Key)->Bool {
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
    
    public func isNotEmptyValueForKey(aKey: Key)->Bool {
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
    
    /**
     添加其它字典的数据
     
     - parameter otherDictionary: 其它字典
     */
    public mutating func addOtherDictionary(otherDictionary: [Key : Value]?) {
        if otherDictionary == nil {
            return
        }
        for dkey in otherDictionary!.keys {
            let value = otherDictionary![dkey]
            self.setOptionalValue(value, forKey: dkey)
        }
    }
    
    public mutating func setOptionalValue(value: Value?, forKey key: Key) {
        if value == nil {
            return
        }
        self.updateValue(value!, forKey: key)
    }
    

}

public extension NSDictionary {
    public func stringForKey(aKey: String)->String {
        if let tvalue = self[aKey] as? String {
            return tvalue
        }
        if let tvalue = self[aKey] as? NSNumber {
            return String(format: "%@", tvalue)
        }
        return ""
    }
}