//
//  MudHttpSessionManager.swift
//  Travel
//
//  Created by TimTiger on 16/4/25.
//  Copyright © 2016年 Mudmen. All rights reserved.
//

import UIKit

public class MudHttpSessionManager: MudURLSessionManager {
    private var responseSerializer: MudHTTPResponseSerializer!
    private var requestSerializer: MudHTTPRequestSerializer!
    private var baseURL: String?
    
    /**
     Creates and returns an `MudHttpSessionManager` object.
     */
    class func manager()->MudHttpSessionManager {
        return MudHttpSessionManager(baseURL: nil)
    }
    
    /**
     *   Initializes an `MudHttpSessionManager` object with the specified base URL.
     *
     *  @param url The base URL for the HTTP client.
     *
     *  @return The newly-initialized HTTP client
     */
    convenience init(baseURL url: String?) {
        self.init(baseURL: url,sessionConfiguration: nil)
    }
    
    override convenience init(sessionConfiguration configuration: NSURLSessionConfiguration?) {
        self.init(baseURL: nil,sessionConfiguration: configuration)
    }
    
    /**
     Initializes an `MudHttpSessionManager` object with the specified base URL.
     
     This is the designated initializer.
     
     @param url The base URL for the HTTP client.
     @param configuration The configuration used to create the managed session.
     
     @return The newly-initialized HTTP client
     */
    init(baseURL url: String?,sessionConfiguration configuration: NSURLSessionConfiguration?)  {
        super.init(sessionConfiguration: configuration)
        self.baseURL = url
        self.responseSerializer = MudHTTPResponseSerializer()
        self.requestSerializer = MudHTTPRequestSerializer()
    }
    
    public func sendRequest(request: MudHttpRequest,success: (responseObject: AnyObject) -> Void,failure: (error: NSError) -> Void) {
        var mutableRequest: NSMutableURLRequest? = nil
        do {
            if String.hasCharacter(self.baseURL) {
                request.requestURL = self.baseURL!+request.requestURL
            }
            mutableRequest = try self.requestSerializer.requestWithMudHttpRequest(request)
        } catch let error as NSError {
            failure(error: error)
            return
        }
        
        let dataTask = self.dataTaskWithRequest(mutableRequest!, completionHandler: { (response, responseData, error) in
            if error == nil {
                if responseData != nil && responseData?.length > 0 {
                    do {
                        let responseObject = try self.responseSerializer.responseObjectForData(responseData!)
                        success(responseObject: responseObject)
                    } catch let error as NSError {
                        failure(error: error)
                    }
                } else {
                    failure(error: NSError.getErrorWithDomain("", localizedDescription: "reponse 0 bytes", errorCode: 401))
                }
            }
        })
        dataTask.resume()
    }
}
