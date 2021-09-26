//
//  TransferData.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 26/9/21.
//

import Foundation
struct TransferData: Codable {
    let status : String?
    let transferResponse : TransferResponse?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case transferResponse = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        transferResponse = try values.decodeIfPresent(TransferResponse.self, forKey: .transferResponse)
    }
}
