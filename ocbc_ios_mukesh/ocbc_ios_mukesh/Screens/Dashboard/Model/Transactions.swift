//
//  TransactionData.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 26/9/21.
//


import Foundation
struct Transactions: Codable {
	let status : String?
	let transactionData : [TransactionData]?

	enum CodingKeys: String, CodingKey {
		case status = "status"
		case transactionData = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
        transactionData = try values.decodeIfPresent([TransactionData].self, forKey: .transactionData)
	}

}
