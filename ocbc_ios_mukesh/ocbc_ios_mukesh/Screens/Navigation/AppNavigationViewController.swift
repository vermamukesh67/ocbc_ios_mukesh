//
//  AppNavigationViewController.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 27/9/21.
//

import UIKit

class AppNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = UIColor.red
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium)]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium),NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
    }
}
