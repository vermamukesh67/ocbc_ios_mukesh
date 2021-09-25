//
//  DashboardViewController.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 25/9/21.
//

import UIKit

class DashboardViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
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
