//
//  BalanceData.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 26/9/21.
//

import Foundation
struct BalanceData: Codable {
    let status : String?
    let balance : Double?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case balance = "balance"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        balance = try values.decodeIfPresent(Double.self, forKey: .balance)
    }
}
