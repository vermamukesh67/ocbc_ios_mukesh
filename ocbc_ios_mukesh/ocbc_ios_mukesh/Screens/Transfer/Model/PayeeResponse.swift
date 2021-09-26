//
//  PayeeResponse.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 26/9/21.
//

import Foundation
struct PayeeResponse : Codable {
    let status : String?
    let payeeData : [PayeeData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case payeeData = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        payeeData = try values.decodeIfPresent([PayeeData].self, forKey: .payeeData)
    }

}
