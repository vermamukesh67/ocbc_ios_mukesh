//
//  UIAlertViewController+Extra.swift
//  ZuhlkeVarmaMukeshPracticleTest
//
//  Created by verma mukesh on 8/1/21.
//

import Foundation
import UIKit
public extension UIViewController {
    
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
