//
//  RequestDataHelper.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 26/9/21.
//

import Foundation
struct RequestDataHelper {
    /// Convert [AnyHashable: Any] into Data object.
    static func parameters(_ parameters: [AnyHashable: Any]?) -> Data? {
        if let httpParams = parameters,let postData = try? JSONSerialization.data(withJSONObject: httpParams, options: []) {
            return postData
        }
        return nil
    }
    /// Returns the URLRequest object based on url, httpbody, header data and timeout interval for post method.
    static func postRequest(_ url: URL, httpBody: [AnyHashable: Any]?, headerData: [String: String]?, timeoutInterval: TimeInterval = APIManager.defaultTimeoutInterval) -> NSMutableURLRequest {
        let theRequest = NSMutableURLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: timeoutInterval)
        theRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "POST"
        theRequest.httpBody = RequestDataHelper.parameters(httpBody)
        if let headers = headerData {
            for (key, value) in headers {
                theRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        return theRequest
    }
    /// Returns the URLRequest object based on url, httpbody, header data and timeout interval for get method.
    static func getRequest(_ url: URL, headerData: [String: String]?, timeoutInterval: TimeInterval = APIManager.defaultTimeoutInterval) -> NSMutableURLRequest {
        let theRequest = NSMutableURLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: timeoutInterval)
        theRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "GET"
        if let headers = headerData {
            for (key, value) in headers {
                theRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        return theRequest
    }
}
