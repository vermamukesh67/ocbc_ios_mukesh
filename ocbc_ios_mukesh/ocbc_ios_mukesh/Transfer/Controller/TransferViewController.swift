//
//  TransferViewController.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 25/9/21.
//

import UIKit

class TransferViewController: UITableViewController {
    @IBOutlet weak var btnTransfer: OCBCButton!
    @IBOutlet weak var txtRecepient: OCBCPickerTextField!
    @IBOutlet weak var txtDate: OCBCDatePickerTextField!
    @IBOutlet weak var txtDescription: OCBCTextView!
    @IBOutlet weak var txtAmount: OCBCTextField!
    @IBOutlet weak var lblDescriptionPlaceHolder: UILabel!
    var transferViewModel:TransferViewModel!
    var payeeViewModel:PayeeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Make a transfer"
        self.btnTransfer.isEnabled = false
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(endEditing))
        self.view.addGestureRecognizer(tapGesture)
        self.setupPayeesViewModel()
        self.setupTransferViewModel()
    }
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    @IBAction func btnTrasferButtonClicked(_ sender: Any) {
        self.view.endEditing(true)
        if let payeeAccNo = self.payeeViewModel.allPayee[self.txtRecepient.selectedIndex].accountNo, let date = self.txtDate.text, let strDescription = self.txtDescription.text, let amount = self.txtAmount.text {
            self.transferViewModel.doTransfer(transferRequest: TransferRequestModel.init(amount: Int(amount) ?? 0, recipientAccountNo: payeeAccNo, date: date, description: strDescription))
        }
    }
}
extension TransferViewController {
    func setupTransferViewModel() {
        self.transferViewModel = TransferViewModel()
        self.transferViewModel.bindControllerForSuccess = {[weak self] in
            DispatchQueue.main.async {
                self?.showAlert(title: "Success", message: "Transfer successful", buttonHandler: {[weak self] (_) in
                    self?.navigationController?.popViewController(animated: true)
                })
            }
        }
        self.transferViewModel.bindControllerForError = {[weak self] errorMessage in
            DispatchQueue.main.async {
                self?.showAlert(title: "Error", message: errorMessage)
            }
        }
    }
    func setupPayeesViewModel() {
        self.payeeViewModel = PayeeViewModel()
        self.payeeViewModel.bindControllerForSuccess = {[weak self] in
            DispatchQueue.main.async {
                let arrPayee = self?.payeeViewModel.allPayee.map({ payeeData -> String in
                    let name = payeeData.accountHolderName ?? ""
                    let accountNo = payeeData.accountNo ?? ""
                    return  name + " - " + accountNo
                })
                self?.txtRecepient.pickerItems = arrPayee ?? []
            }
        }
        self.payeeViewModel.bindControllerForError = {[weak self] errorMessage in
            DispatchQueue.main.async {
                self?.txtRecepient.pickerItems = []
            }
        }
        self.payeeViewModel.getAllPayees()
    }
}
extension TransferViewController {
    fileprivate func validateTransfer() -> Bool {
        if txtRecepient.text?.isEmpty ?? true || txtDate.text?.isEmpty ?? true || txtDescription.text?.isEmpty ?? true || txtAmount.text?.isEmpty ?? true {
            return false
        }
        return true
    }
    fileprivate func validateTextField(_ textField: UITextField, _ updatedText: String) {
        if textField == txtRecepient {
            self.btnTransfer.isEnabled = !(updatedText.isEmpty || txtDate.text?.isEmpty ?? true || txtDescription.text?.isEmpty ?? true || txtAmount.text?.isEmpty ?? true)
        } else if textField == txtDate {
            self.btnTransfer.isEnabled = !(updatedText.isEmpty || txtRecepient.text?.isEmpty ?? true || txtDescription.text?.isEmpty ?? true || txtAmount.text?.isEmpty ?? true)
        } else if textField == txtDescription {
            self.btnTransfer.isEnabled = !(updatedText.isEmpty || txtDate.text?.isEmpty ?? true || txtRecepient.text?.isEmpty ?? true || txtAmount.text?.isEmpty ?? true)
        } else if textField == txtAmount {
            self.btnTransfer.isEnabled = !(updatedText.isEmpty || txtDate.text?.isEmpty ?? true || txtDescription.text?.isEmpty ?? true || txtRecepient.text?.isEmpty ?? true)
        }
    }
}
extension TransferViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            validateTextField(textField, updatedText)
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.btnTransfer.isEnabled = validateTransfer()
    }
}
extension TransferViewController: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        lblDescriptionPlaceHolder.isHidden = !(textView.text.isEmpty)
        self.btnTransfer.isEnabled = validateTransfer()
    }
}
