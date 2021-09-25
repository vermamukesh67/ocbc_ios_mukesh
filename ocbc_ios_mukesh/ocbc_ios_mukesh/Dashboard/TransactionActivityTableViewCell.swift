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
}
