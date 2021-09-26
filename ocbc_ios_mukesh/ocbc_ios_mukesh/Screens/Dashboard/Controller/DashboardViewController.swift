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
    var balanceViewModel: BalanceViewModel!
    var transactionViewModel: TransactionViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblTransactionView.register(UINib(nibName: "TransactionActivityTableViewCell", bundle: .main), forCellReuseIdentifier: "transactioncell")
        self.setupTransactionViewModel()
        self.setupBalanceViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
extension DashboardViewController {
    fileprivate func setupBalanceViewModel() {
        self.balanceViewModel = BalanceViewModel()
        self.balanceViewModel.bindControllerForSuccess = {[weak self] in
            DispatchQueue.main.async {
                self?.balanceDisplayView.stopShimmeringEffect()
                self?.balanceDisplayView.balance = "\(self?.balanceViewModel.balanceData?.balance ?? 0)".formatIntoCurrency(prefix: "SGD", locale: Locale.init(identifier: "en_SG"))
            }
        }
        self.balanceViewModel.bindControllerForError = {[weak self] errorMessage in
            DispatchQueue.main.async {
                self?.balanceDisplayView.stopShimmeringEffect()
                self?.showAlert(title: "Error", message: errorMessage)
            }
        }
        self.balanceDisplayView.startShimmeringEffect()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.balanceViewModel.getBalance()
        }
    }
    fileprivate func setupTransactionViewModel() {
        self.transactionViewModel = TransactionViewModel()
        self.transactionViewModel.bindControllerForSuccess = {[weak self] in
            DispatchQueue.main.async {
                self?.tblTransactionView.stopShimmeringEffect()
                self?.tblTransactionView.backgroundColor = UIColor.white
                self?.tblTransactionView.reloadData()
            }
        }
        self.transactionViewModel.bindControllerForError = {[weak self] errorMessage in
            DispatchQueue.main.async {
                self?.tblTransactionView.stopShimmeringEffect()
                self?.tblTransactionView.backgroundColor = UIColor.white
                self?.tblTransactionView.reloadData()
            }
        }
        self.tblTransactionView.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        self.tblTransactionView.startShimmeringEffect()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.transactionViewModel.getAllTransactionsData()
        }
    }
}
extension DashboardViewController: TransferViewControllerDelegate {
    func transferDidSucessFull(transactionData: TransactionData) {
        DispatchQueue.main.async {
            let currentBalance = self.balanceViewModel.balanceData?.balance
            let deduction = transactionData.amount
            self.balanceViewModel.balanceData?.balance = Double(CGFloat(currentBalance ?? 0) - CGFloat(deduction ?? 0))
            self.balanceDisplayView.balance = "\(self.balanceViewModel.balanceData?.balance ?? 0)".formatIntoCurrency(prefix: "SGD", locale: Locale.init(identifier: "en_SG"))
            self.transactionViewModel.allTransactionData.insert(transactionData, at: 0)
            self.tblTransactionView.reloadData()
        }
    }
}
extension DashboardViewController {
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
        transferController.delegate = self
        self.navigationController?.pushViewController(transferController, animated: true)
    }
}
extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactionViewModel.allTransactionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transactioncell", for: indexPath) as? TransactionActivityTableViewCell else {
            return UITableViewCell()
        }
        cell.updateCell(transactionData: self.transactionViewModel.allTransactionData[indexPath.row])
        return cell
    }
}
