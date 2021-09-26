//
//  Data.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 26/9/21.
//


import Foundation
struct TransactionData : Codable {
	let id : String?
	let type : String?
	let amount : Double?
	let currency : String?
	let fromAccount : FromAccount?
    let toAccount : ToAccount?
    let description : String?
	let date : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case type = "type"
		case amount = "amount"
		case currency = "currency"
		case fromAccount = "from"
        case toAccount = "to"
		case description = "description"
		case date = "date"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		amount = try values.decodeIfPresent(Double.self, forKey: .amount)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
        fromAccount = try values.decodeIfPresent(FromAccount.self, forKey: .fromAccount)
        toAccount = try values.decodeIfPresent(ToAccount.self, forKey: .toAccount)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		date = try values.decodeIfPresent(String.self, forKey: .date)
	}
    init(id: String?, type: String?, amount: Double?, currency: String?, fromAccount: FromAccount?, toAccount: ToAccount?, date: String?, description: String?) {
        self.amount = amount
        self.type = type
        self.id = id
        self.currency = currency
        self.date = date
        self.fromAccount = fromAccount
        self.toAccount = toAccount
        self.description = description
    }
}
