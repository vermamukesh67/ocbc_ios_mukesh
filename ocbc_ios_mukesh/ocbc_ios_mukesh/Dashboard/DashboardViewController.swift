//
//  DashboardViewController.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 25/9/21.
//

import UIKit

class DashboardViewController: UIViewController {
    @IBOutlet weak var balanceDisplayView: BalanceDisplayView!
    @IBOutlet weak var tblTransactionView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        balanceDisplayView.balance = "SGD 12,482.32"
        self.tblTransactionView.register(UINib(nibName: "TransactionActivityTableViewCell", bundle: .main), forCellReuseIdentifier: "transactioncell")
    }
    @IBAction func btnLogoutButtonClicked(_ sender: Any) {
        let dashboardStoryBoard = UIStoryboard(name: "Main", bundle: .main)
        guard let dashboardController = dashboardStoryBoard.instantiateViewController(identifier: "LoginNavigationViewController") as? UINavigationController else {
            return
        }
        UIWindow.key?.rootViewController = dashboardController
    }
    @IBAction func btnTransferButtonClicked(_ sender: Any) {
        let transferStoryBoard = UIStoryboard(name: "Transfer", bundle: .main)
        guard let transferController = transferStoryBoard.instantiateViewController(identifier: "TransferViewController") as? TransferViewController else {
            return
        }
        self.navigationController?.pushViewController(transferController, animated: true)
    }
}
extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transactioncell", for: indexPath) as? TransactionActivityTableViewCell else {
            return UITableViewCell()
        }
        let row = (indexPath.row % 2 == 0)
        cell.transactionActivityView.setAmount(amount: row ? "120" : "-90", isCredited: row)
        cell.transactionActivityView.date = row ? "6 Sep" : "31 Aug"
        cell.transactionActivityView.title = row ? "Received from Friend C" : "Transfer to friend A"
        return cell
    }
}
