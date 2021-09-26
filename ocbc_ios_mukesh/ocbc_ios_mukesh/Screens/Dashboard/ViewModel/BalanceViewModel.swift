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
    /// Update the balance after transfer done.
    func updateBalanceAfterTransfer(transactionData: TransactionData) {
        let currentBalance = self.balanceData?.balance
        let deduction = transactionData.amount
        self.balanceData?.balance = (currentBalance ?? 0) - (deduction ?? 0)
    }
    /// Returns true or false if amount can be transfered or not.
    /// - Parameter amount: A double value.
    /// - Returns: A Bool value
    func canSendAmount(amount: Double) -> Bool {
        let currentBalance = self.balanceData?.balance
        let remainBalace = (currentBalance ?? 0) - amount
        return (remainBalace > 0)
    }
    func getFormattedBalanceWithCurreny() -> String {
        return "\(self.balanceData?.balance ?? 0)".formatIntoCurrency(prefix: "SGD", locale: Locale.init(identifier: "en_SG"))
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
