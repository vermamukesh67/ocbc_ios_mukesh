//
//  TransactionViewModel.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 26/9/21.
//

import Foundation
// A View model class that handles the transactions api calls and its business logic.
class TransactionViewModel {
    
    var apiService = APIRequest(resource: TransactionResource())
    
    var bindControllerForSuccess : (() -> Void)?
    var bindControllerForError : ((_ errorMessage: String) -> Void)?
    var allTransactionData = [TransactionData]()
    
    var transactionData : Transactions? {
        didSet {
            if let transactions = self.transactionData?.transactionData, !transactions.isEmpty {
                self.allTransactionData = transactions
                self.bindControllerForSuccess?()
            } else {
                self.bindControllerForError?("transaction data not found")
            }
        }
    }
    
    /// Fetch transaction  data.
    func getAllTransactionsData() {
        apiService.load { [weak self] (transactionData) in
            self?.transactionData = transactionData
        } onError: { error in
            self.bindControllerForError?(error?.localizedDescription ?? "transaction data not found")
        }
    }
}

/// Represents the transaction data resource information.
public struct TransactionResource: APIResource {
    var httpBody: [AnyHashable : Any]?
    var methodPath: String = ApiRequestUrl.transactions.rawValue
    var headerData: [String : String]? = ["Authorization" : SessionManager.sharedInstance.authorizationToken]
    var requestType: ApiRequestMethodType = .GET
    var queryItems: [URLQueryItem]? = nil
    typealias ModelType = Transactions
}
