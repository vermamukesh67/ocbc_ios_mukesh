//
//  BalanceViewModel.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 26/9/21.
//

import Foundation
/// Balance view model class to handle the balance information related business logic.
public class BalanceViewModel {
    var apiService = APIRequest(resource: BalanceDataResource())
    var bindControllerForSuccess : (() -> Void)?
    var bindControllerForError : ((_ errorMessage: String) -> Void)?
    
    var balanceData : BalanceData? {
        didSet {
            if balanceData != nil {
                self.bindControllerForSuccess?()
            } else {
                self.bindControllerForError?("balance data not found")
            }
        }
    }
    /// Fetch balance data.
    func getBalance() {
        apiService.load { [weak self] (balanceData) in
            self?.balanceData = balanceData
        } onError: { error in
            self.bindControllerForError?(error?.localizedDescription ?? "balance data not found")
        }
    }
}
/// Represents the balance data resource information.
public struct BalanceDataResource: APIResource {
    var httpBody: [AnyHashable : Any]?
    var methodPath: String = ApiRequestUrl.balances.rawValue
    var headerData: [String : String]? = ["Authorization" : SessionManager.sharedInstance.authorizationToken]
    var requestType: ApiRequestMethodType = .GET
    var queryItems: [URLQueryItem]? = nil
    typealias ModelType = BalanceData
}
