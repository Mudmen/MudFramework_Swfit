//
//  Array+Category.swift
//  Travel
//
//  Created by TimTiger on 7/3/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import Foundation
import ObjectiveC.objc

extension Array {

    //from http://stackoverflow.com/questions/24938948/array-extension-to-remove-object-by-value
    mutating func removeElement<U: Equatable>(element: U) -> Bool {
        for (idx, objectToCompare) in self.enumerate() {
            if let to = objectToCompare as? U {
                if element == to {
                    self.removeAtIndex(idx)
                    return true
                }
            }
        }
        return false
    }
    
    static func hasContent(array: [AnyObject]?) -> Bool {
        if (array == nil) {
            return false;
        }
        
        if (array?.count < 1) {
            return false
        }
        
        return true;
    }
}

