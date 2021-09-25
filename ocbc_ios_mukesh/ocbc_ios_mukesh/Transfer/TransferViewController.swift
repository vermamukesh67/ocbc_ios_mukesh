//
//  TransferViewController.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 25/9/21.
//

import UIKit

class TransferViewController: UITableViewController {
    @IBOutlet weak var btnTransfer: OCBCButton!
    @IBOutlet weak var txtRecepient: OCBCTextField!
    @IBOutlet weak var txtDate: OCBCTextField!
    @IBOutlet weak var txtDescription: OCBCTextView!
    @IBOutlet weak var txtAmount: OCBCTextField!
    @IBOutlet weak var lblDescriptionPlaceHolder: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Make a transfer"
        self.btnTransfer.isEnabled = false
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    @IBAction func btnLoginButtonClicked(_ sender: Any) {
        if validateTransfer() {
        }
    }
}
extension TransferViewController {
    func validateTransfer() -> Bool {
        if txtRecepient.text?.isEmpty ?? true || txtDate.text?.isEmpty ?? true || txtDescription.text?.isEmpty ?? true || txtAmount.text?.isEmpty ?? true {
            return false
        }
        return true
    }
}
extension TransferViewController: UITextFieldDelegate {
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
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    public func textViewDidChange(_ textView: UITextView) {
        lblDescriptionPlaceHolder.isHidden = !(textView.text.isEmpty)
        self.btnTransfer.isEnabled = validateTransfer()
    }
}
