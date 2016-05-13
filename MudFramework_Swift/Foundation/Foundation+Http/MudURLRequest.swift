//
//  MudURLRequest.swift
//  Travel
//
//  Created by TimTiger on 16/4/27.
//  Copyright © 2016年 Mudmen. All rights reserved.
//

import UIKit

/// key一定为String类型的字典
public typealias MudStringKeyDictionary = [String: AnyObject]
/// http请求参数的字典类型
public typealias MudParameters = MudStringKeyDictionary

public extension Dictionary {
    
    public mutating func setParameter(value: Value?, forKey aKey: Key) {
        if value == nil {
            return
        }
        self.updateValue(value!, forKey: aKey)
    }
}

/// Http请求方式
public enum MudRequestMethod: String {
    case Get = "GET"
    case Post = "POST"
}

/** 
 *Http请求 
 */
public class MudHttpRequest : NSObject {
    
    /// 请求连接地址
    var requestURL: String = ""
    /// 请求参数
    var parameters: MudParameters!
    /// 请求失败后的重试次数
    var retryTimes: Int = 1
    /// 重试间隔
    var retryInterval: Int = 10
    /// 超时限制
    var timeoutInterval: NSTimeInterval = 30
    /// 请求方式
    var method: MudRequestMethod = MudRequestMethod.Get
    
    /**
     获得一个请求
     - parameter requestURL: 请求地址
     - parameter parameters: 请求参数
     - returns: 返回一个请求
     */
    init(requestURL: String,parameters: MudParameters?) {
        super.init()
        self.requestURL = requestURL
        self.parameters = parameters
    }
}

/** 请求类 转换成 http请求协议 */
public protocol MudHttpRequestConvertProtocol: NSObjectProtocol {
    func httpRequest()->MudHttpRequest
}

