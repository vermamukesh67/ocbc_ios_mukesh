//
//  SessionManager.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 26/9/21.
//

import Foundation
/// Store the session related information.
class SessionManager: NSObject {
    static let sharedInstance = SessionManager()
    var authorizationToken: String = ""
}
