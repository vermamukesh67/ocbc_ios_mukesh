//
//  ApiRequest.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 25/9/21.
//

import Foundation

enum ApiRequestUrl: String {
    case login = "/authenticate/login"
    case balances = "/account/balances"
    case transactions = "/account/transactions"
    case transfer = "/transfer"
    case payees = "/account/payees"
    static func urlString(api: ApiRequestUrl) -> String {
        return String(format: "%@%@", APIManager.baseUrl, api.rawValue)
    }
}
struct APIManager {
    static let baseUrl = "http://localhost:8080"
    static var defaultTimeoutInterval: TimeInterval = 60
}

public enum ApiRequestMethodType {
    case GET
    case POST
}

