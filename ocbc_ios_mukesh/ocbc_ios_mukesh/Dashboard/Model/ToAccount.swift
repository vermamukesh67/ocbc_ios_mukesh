//
//  ToAccount.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 26/9/21.
//

import Foundation
struct ToAccount: Codable {
    let accountNo : String?
    let accountHolderName : String?

    enum CodingKeys: String, CodingKey {

        case accountNo = "accountNo"
        case accountHolderName = "accountHolderName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accountNo = try values.decodeIfPresent(String.self, forKey: .accountNo)
        accountHolderName = try values.decodeIfPresent(String.self, forKey: .accountHolderName)
    }

}
