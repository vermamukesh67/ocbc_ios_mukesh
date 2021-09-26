//
//  LoginService.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 25/9/21.
//

import Foundation
struct LoginRequestModel {
    var username: String
    var password: String
}
public class LoginViewModel {
    var apiService = APIRequest(resource: LoginDataResource())
    var bindControllerForSuccess : (() -> Void)?
    var bindControllerForError : ((_ errorMessage: String) -> Void)?
    
    var loginData : LoginData? {
        didSet {
            if  let data = loginData, !data.token.isEmpty {
                SessionManager.sharedInstance.authorizationToken = data.token
                self.bindControllerForSuccess?()
            } else {
                self.bindControllerForError?("login data not found")
            }
        }
    }
    /// Fetch login data.
    func doLogin(loginRequest: LoginRequestModel) {
        apiService.resource.httpBody = self.getLoginRequestData(loginRequest)
        apiService.load { [weak self] (loginData) in
            self?.loginData = loginData
        } onError: { error in
            self.bindControllerForError?(error?.localizedDescription ?? "login data not found")
        }
    }
    /// Converts LoginRequestModel into Dictionary for login request.
    private func getLoginRequestData(_ param: LoginRequestModel) -> [AnyHashable: Any] {
        let data: [AnyHashable: Any] = ["username": param.username,
                                        "password": param.password]
        return data
    }
}
/// Represents the login data resource information.
public struct LoginDataResource: APIResource {
    var httpBody: [AnyHashable : Any]?
    var methodPath: String = ApiRequestUrl.login.rawValue
    var headerData: [String : String]? = nil
    var requestType: ApiRequestMethodType = .POST
    var queryItems: [URLQueryItem]? = nil
    typealias ModelType = LoginData
}
