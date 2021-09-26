//
//  UIAlertViewController+Extra.swift
//  ZuhlkeVarmaMukeshPracticleTest
//
//  Created by verma mukesh on 8/1/21.
//

import Foundation
import UIKit
public extension UIViewController {
    /// Loader alert controller
    var loaderAlert:UIAlertController {
        get {
            let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = .medium
            loadingIndicator.startAnimating();

            alert.view.addSubview(loadingIndicator)
            return alert
        }
    }
    /// Show alert controller
    /// - Parameters:
    ///   - title: The title of the alert
    ///   - message: The message of the alert
    ///   - buttonHandler: A block to execute when the user selects the action.
    func showAlert(title: String?, message: String?, buttonHandler:((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: buttonHandler))
        self.present(alert, animated: true, completion: nil)
    }
    /// Show loader
    /// - Parameter completion: A block to execute when the loader finished showing successfully.
    func showLoader(completion: (() -> Void)? = nil) {
        present(loaderAlert, animated: false, completion: completion)
    }
    /// Hide loader.
    /// - Parameter completion: A block to execute when the loader hide  successfully.
    func hideLoader(completion: (() -> Void)? = nil) {
        dismiss(animated: true, completion: completion)
    }
}
