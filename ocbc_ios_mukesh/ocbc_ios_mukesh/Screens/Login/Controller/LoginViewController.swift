//
//  ViewController.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 25/9/21.
//

import UIKit

class LoginViewController: UITableViewController {
    @IBOutlet weak var btnLogin: OCBCButton!
    @IBOutlet weak var txtUserName: OCBCTextField!
    @IBOutlet weak var txtPassword: OCBCTextField!
    
    var loginViewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnLogin.isEnabled = validateLogin()
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupViewModel()
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }

    @IBAction func btnLoginButtonClicked(_ sender: Any) {
        self.endEditing()
        if let userName = self.txtUserName.text, let passWord = self.txtPassword.text {
            self.showLoader {
                self.loginViewModel.doLogin(loginRequest: LoginRequestModel.init(username: userName, password: passWord))
            }
        }
    }
}
extension LoginViewController {
    fileprivate func setupViewModel() {
        self.loginViewModel = LoginViewModel()
        self.loginViewModel.bindControllerForSuccess = {[weak self] in
            DispatchQueue.main.async {
                self?.hideLoader()
                self?.moveTODashBoardScreen()
            }
        }
        self.loginViewModel.bindControllerForError = {[weak self] errorMessage in
            DispatchQueue.main.async {
                self?.hideLoader {
                    self?.showAlert(title: "Error", message: errorMessage)
                }
            }
        }
    }
}
extension LoginViewController {
    func validateLogin() -> Bool {
        if txtUserName.text?.isEmpty ?? true || txtPassword.text?.isEmpty ?? true {
            return false
        }
        return true
    }
    func moveTODashBoardScreen() {
        let dashboardStoryBoard = UIStoryboard(name: "Dashboard", bundle: .main)
        guard let dashboardController = dashboardStoryBoard.instantiateViewController(identifier: "DashboardNavigationViewController") as? UINavigationController else {
            return
        }
        UIWindow.key?.rootViewController = dashboardController
    }
}
extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " { // Dont allow to enter the space
            return false
        }
        if let text = textField.text,
           let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange, with: string)
            if textField == txtUserName {
                self.btnLogin.isEnabled = !(updatedText.isEmpty || txtPassword.text?.isEmpty ?? true)
            } else {
                self.btnLogin.isEnabled = !(updatedText.isEmpty || txtUserName.text?.isEmpty ?? true)
            }
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.btnLogin.isEnabled = validateLogin()
    }
}

