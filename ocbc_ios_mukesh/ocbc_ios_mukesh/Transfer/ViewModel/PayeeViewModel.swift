//
//  PayeeViewModel.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 26/9/21.
//

import Foundation
public class PayeeViewModel {
    var apiService = APIRequest(resource: PayeeDataResource())
    var bindControllerForSuccess : (() -> Void)?
    var bindControllerForError : ((_ errorMessage: String) -> Void)?
    var allPayee: [PayeeData] = []
    var payeeResponse : PayeeResponse? {
        didSet {
            if let response = payeeResponse, let arrPayee = response.payeeData {
                self.allPayee = arrPayee
                self.bindControllerForSuccess?()
            } else {
                self.bindControllerForError?("payee data not found")
            }
        }
    }
    /// Fetch payees data.
    func getAllPayees() {
        apiService.load { [weak self] (payeeResponse) in
            self?.payeeResponse = payeeResponse
        } onError: { error in
            self.bindControllerForError?(error?.localizedDescription ?? "payee data not found")
        }
    }
}
/// Represents the Ppayee data resource information.
public struct PayeeDataResource: APIResource {
    var httpBody: [AnyHashable : Any]?
    var methodPath: String = ApiRequestUrl.payees.rawValue
    var headerData: [String : String]? = ["Authorization" : SessionManager.sharedInstance.authorizationToken]
    var requestType: ApiRequestMethodType = .GET
    var queryItems: [URLQueryItem]? = nil
    typealias ModelType = PayeeResponse
}
