//
//  LoginData.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 26/9/21.
//

import Foundation
struct LoginData : Codable {
    let status : String?
    let token : String

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case token = "token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        token = try values.decodeIfPresent(String.self, forKey: .token) ?? ""
    }
}
