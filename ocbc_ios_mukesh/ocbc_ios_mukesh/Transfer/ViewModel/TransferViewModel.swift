//
//  TransferViewModel.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 26/9/21.
//

import Foundation
struct TransferRequestModel {
    var amount: Int
    var recipientAccountNo: String
    var date: String
    var description: String
}
public class TransferViewModel {
    var apiService = APIRequest(resource: TransferDataResource())
    var bindControllerForSuccess : (() -> Void)?
    var bindControllerForError : ((_ errorMessage: String) -> Void)?
    
    var transferData : TransferData? {
        didSet {
            if  let data = transferData, data.status == "success" {
                self.bindControllerForSuccess?()
            } else {
                self.bindControllerForError?("transfer was not successful")
            }
        }
    }
    /// Fetch transfer data.
    func doTransfer(transferRequest: TransferRequestModel) {
        apiService.resource.httpBody = self.getTransferRequestData(transferRequest)
        apiService.load { [weak self] (transferData) in
            self?.transferData = transferData
        } onError: { error in
            self.bindControllerForError?(error?.localizedDescription ?? "transfer was not successful")
        }
    }
    /// Converts TransferRequestModel into Dictionary for transfer request.
    private func getTransferRequestData(_ param: TransferRequestModel) -> [AnyHashable: Any] {
        let data: [AnyHashable: Any] = ["recipientAccountNo": param.recipientAccountNo,
                                        "amount": param.amount,
                                        "date": param.date,
                                        "description": param.description]
        return data
    }
}
/// Represents the transfer data resource information.
public struct TransferDataResource: APIResource {
    var httpBody: [AnyHashable : Any]?
    var methodPath: String = ApiRequestUrl.transfer.rawValue
    var headerData: [String : String]? = ["Authorization" : SessionManager.sharedInstance.authorizationToken]
    var requestType: ApiRequestMethodType = .POST
    var queryItems: [URLQueryItem]? = nil
    typealias ModelType = TransferData
}

