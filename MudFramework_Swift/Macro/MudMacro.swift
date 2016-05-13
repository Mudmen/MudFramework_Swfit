//
//  MudMacro.swift
//  MudFramework_Swift
//
//  Created by TimTiger on 1/26/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import Foundation
import UIKit

var MUD_LOG = false

//LOG
func MudLog(format: String, args: CVarArgType...) {
    if MUD_LOG {
        NSLogv(format,getVaList(args))
    }
    // else do nothing
}

@inline(never) func MudPrint<T>(value: T) {
    if MUD_LOG {
        print(value, terminator: "")
    }
    // else do nothing
}

//VIEW
let MUD_SCREEN_BOUNDS = (UIScreen.mainScreen().bounds)
let MUD_SCREEN_WIDTH = (UIScreen.mainScreen().bounds.size.width)
let MUD_SCREEN_HEIGHT = (UIScreen.mainScreen().bounds.size.height)