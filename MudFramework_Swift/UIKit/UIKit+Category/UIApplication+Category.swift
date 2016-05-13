//
//  UIApplication+Category.swift
//  Travel
//
//  Created by TimTiger on 6/16/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    class func formatCurrentVersion()->String {
        var appversion: String = "1.0"
        var infoDic = NSBundle.mainBundle().infoDictionary
        if (infoDic != nil && infoDic?["CFBundleShortVersionString"] != nil) {
            appversion = infoDic!["CFBundleShortVersionString"] as! String
            appversion = appversion.stringByReplacingOccurrencesOfString(".", withString: "_")
            appversion = appversion.stringByReplacingOccurrencesOfString(" ", withString: "_")
        }
        return appversion
    }
    
    class func currentBuildVersion()->String {
        //CFBundleVersion
        var appversion: String = "1.0"
        var infoDic = NSBundle.mainBundle().infoDictionary
        if (infoDic != nil && infoDic?["CFBundleVersion"] != nil) {
            appversion = infoDic!["CFBundleVersion"] as! String
        }
        return appversion
    }
    
    class func currentVersion()->String {
        var appversion: String = "1.0"
        var infoDic = NSBundle.mainBundle().infoDictionary
        if (infoDic != nil && infoDic?["CFBundleShortVersionString"] != nil) {
            appversion = infoDic!["CFBundleShortVersionString"] as! String
        }
        return appversion
    }

}
