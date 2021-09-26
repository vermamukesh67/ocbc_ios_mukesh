//
//  ApiRequest.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 25/9/21.
//

import Foundation

/// Api end points
enum ApiRequestUrl: String {
    case login = "/authenticate/login"
    case balances = "/account/balances"
    case transactions = "/account/transactions"
    case transfer = "/transfer"
    case payees = "/account/payees"
    /// Return the url string for given end point
    /// - Parameter api: api end point
    /// - Returns: A url string
    static func urlString(api: ApiRequestUrl) -> String {
        return String(format: "%@%@", APIManager.baseUrl, api.rawValue)
    }
}
/// Api manager for holding api constants
struct APIManager {
    static let baseUrl = "http://localhost:8080"
    static var defaultTimeoutInterval: TimeInterval = 60
}

/// Api request type.
public enum ApiRequestMethodType {
    case GET
    case POST
}

