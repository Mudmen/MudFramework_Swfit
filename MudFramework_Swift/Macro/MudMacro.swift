//
//  MudMacro.swift
//  MudFramework_Swift
//
//  Created by TimTiger on 1/26/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import Foundation
import UIKit

public var MUD_LOG = false

//LOG
public func MudLog(format: String, args: CVarArgType...) {
    if MUD_LOG {
        NSLogv(format,getVaList(args))
    }
    // else do nothing
}

@inline(never) public func MudPrint<T>(value: T) {
    if MUD_LOG {
        print(value, terminator: "")
    }
    // else do nothing
}

/**
 *  屏幕
 */
public struct MudScreen {
    /// 屏幕高度
    public static var height: CGFloat {
        return (UIScreen.mainScreen().bounds.size.height)
    }
    /// 屏幕宽度
    public static var width: CGFloat {
        return (UIScreen.mainScreen().bounds.size.height)
    }
    /// 屏幕大小
    public static var bounds: CGRect {
        return (UIScreen.mainScreen().bounds)
    }
}
