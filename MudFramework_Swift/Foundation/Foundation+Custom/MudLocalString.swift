//
//  MudLocalString.swift
//  Travel
//
//  Created by TimTiger on 1/29/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit

class MudLocalString: NSObject {
 
    //get string from Localized file ,named Localization.strings
    class func stringForKey(akey: String)-> String {
         return NSLocalizedString(akey, tableName: "Localization", bundle: NSBundle.mainBundle(), comment: "")
    }
    
    class func stringForKey(akey: String, tableName name: String)->String {
        return NSLocalizedString(akey, tableName: name, bundle: NSBundle.mainBundle(),comment: "")
    }
}
