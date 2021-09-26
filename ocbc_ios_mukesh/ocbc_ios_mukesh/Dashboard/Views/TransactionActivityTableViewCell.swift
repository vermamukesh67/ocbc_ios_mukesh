//
//  TransactionActivityTableViewCell.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 25/9/21.
//

import UIKit

class TransactionActivityTableViewCell: UITableViewCell {
    @IBOutlet weak var transactionActivityView: TransactionActivityView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCell(transactionData: TransactionData) {
        let isReceived = transactionData.type == "receive"
        let strAmount: String = String(format: "%.2f", transactionData.amount ?? 0).formatIntoCurrency(prefix: "", locale: Locale.init(identifier: "en_SG"))

        self.transactionActivityView.setAmount(amount: (isReceived) ? strAmount : "-\(strAmount)" , isCredited: isReceived)
        if let date = transactionData.date?.format(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ") {
            self.transactionActivityView.date = date.format(dateFormat: "dd MMM yyyy")
        }
        self.transactionActivityView.title = isReceived ? "Received from \(transactionData.fromAccount?.accountHolderName ?? "")" : "Transfer to \(transactionData.toAccount?.accountHolderName ?? "")"
    }
}
