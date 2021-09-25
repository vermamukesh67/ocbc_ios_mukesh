//
//  ViewController.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 25/9/21.
//

import UIKit

class LoginViewController: UITableViewController {
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnLoginButtonClicked(_ sender: Any) {
        let dashboardStoryBoard = UIStoryboard(name: "Dashboard", bundle: .main)
        guard let dashboardController = dashboardStoryBoard.instantiateViewController(identifier: "DashboardNavigationViewController") as? UINavigationController else {
            return
        }
        UIWindow.key?.rootViewController = dashboardController
    }
}

