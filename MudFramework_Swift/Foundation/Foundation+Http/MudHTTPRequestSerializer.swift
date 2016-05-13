//
//  MudHTTPRequestSerializer.swift
//  Travel
//
//  Created by TimTiger on 16/4/25.
//  Copyright © 2016年 Mudmen. All rights reserved.
//

import Foundation

/** 序列化参数的类 */
public class MudHTTPRequestSerializer: NSObject {
    
    public func requestWithMudHttpRequest(request: MudHttpRequest) throws -> NSMutableURLRequest {
        var mutableRequest = NSMutableURLRequest(URL: NSURL(string: request.requestURL)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: request.timeoutInterval)
        mutableRequest.HTTPShouldHandleCookies = false
        mutableRequest.HTTPMethod = request.method.rawValue
        do {
            try mutableRequest = self.requestBySerializingRequest(mutableRequest, parameters: request.parameters)
        } catch let error as NSError {
            throw(error)
        }
        return mutableRequest
    }
    
    private func requestBySerializingRequest(request: NSMutableURLRequest,parameters: MudParameters?) throws -> NSMutableURLRequest {
        
        if request.HTTPMethod == "GET"
        {
            if MudDictionary.hasContent(parameters) == true {
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                let baseURL = request.URL?.absoluteString
                if String.hasCharacter(baseURL) {
                    request.URL = self.getURLWithParameters(parameters!, baseURL: baseURL!)
                } else {
                    throw(NSError.getErrorWithDomain("error", localizedDescription: "request url is empty", errorCode: 401))
                }
            }
        } else if request.HTTPMethod == "POST" {
            let boundary = self.mudCreateMultipartFormBoundary()
            // set Content-Type in HTTP header
            let contentType = String(format: "multipart/form-data; boundary=%@", boundary)
            request.setValue(contentType, forHTTPHeaderField: "Content-Type")
            // add params
            let body = self.postBodyWithParameters(parameters, boundary: boundary)
            request.HTTPBody = body
            // set the content-length
            let postLength = String(format:"%d",body.length)
            request.setValue(postLength, forHTTPHeaderField: "Content-Length")
        }
        return request
    }
    
    private func getURLWithParameters(parameters: MudParameters,baseURL: String)->NSURL? {
        var httpBodyString = baseURL
        for key in parameters.keys {
            if let value = parameters[key] as? String {
                let enCodeValue = value.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
                if enCodeValue != nil {
                    httpBodyString = httpBodyString.stringByAppendingFormat("&%@=%@",key,enCodeValue!)
                }
            }
            if let value = parameters[key] as? NSNumber {
                httpBodyString = httpBodyString.stringByAppendingFormat("&%@=%@",key,value)
            }
        }
        return NSURL(string: httpBodyString)
    }
    
    private func postBodyWithParameters(parameters: MudStringKeyDictionary?,boundary: String)->NSMutableData {
        var body = NSMutableData()
        if MudStringKeyDictionary.hasContent(parameters) == true {
            for key in parameters!.keys {
                if let value = parameters![key] as? String {
                    body = self.appendPostString(body, boundary: boundary, key: key , value: value)
                }
                if let value = parameters![key] as? NSNumber {
                    body = self.appendPostNumber(body, boundary: boundary, key: key, value: value)
                }
                if let value = parameters![key] as? NSData {
                    if key == "pic" {
                        self.appendPostImageData(body, boundary: boundary, key: key, value: value)
                    }
                }
            }
        }
        body.appendData(String(format: "--%@--\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        return body
    }
    
    private func appendPostString(body: NSMutableData,boundary: String,key: String,value: String)->NSMutableData {
        body.appendData(String(format: "--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(String(format: "Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key).dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(String(format: "%@\r\n",value).dataUsingEncoding(NSUTF8StringEncoding)!)
        return body
    }
    
    private func appendPostNumber(body: NSMutableData,boundary: String,key: String,value: NSNumber)->NSMutableData {
        body.appendData(String(format: "--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(String(format: "Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key).dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(String(format: "%@\r\n",value).dataUsingEncoding(NSUTF8StringEncoding)!)
        return body
    }
    
    private func appendPostImageData(body: NSMutableData,boundary: String,key: String,value: NSData)->NSMutableData {
        body.appendData(String(format: "--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Disposition: form-data; name=\"pic\"; filename=\"pic.jpg\"".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Type: image/jpeg\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(value)
        body.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        return body
    }
    
    private func mudCreateMultipartFormBoundary()->String {
        return String(format:"Boundary+%08X%08X", arc4random(), arc4random())
    }

}
