//
//  RequestDataHelper.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 26/9/21.
//

import Foundation
struct RequestDataHelper {
    static func parameters(_ parameters: [AnyHashable: Any]?) -> Data? {
        if let httpParams = parameters,let postData = try? JSONSerialization.data(withJSONObject: httpParams, options: []) {
            return postData
        }
        return nil
    }
    static func postRequest(_ url: URL, httpBody: [AnyHashable: Any]?, timeoutInterval: TimeInterval = APIManager.defaultTimeoutInterval) -> NSMutableURLRequest {
        let theRequest = NSMutableURLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: timeoutInterval)
        theRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "POST"
        theRequest.httpBody = RequestDataHelper.parameters(httpBody)
        return theRequest
    }
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
