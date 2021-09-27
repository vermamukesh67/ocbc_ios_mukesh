//
//  OCBCTextField.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 25/9/21.
//

import UIKit
/// OCBC textfield.
public class OCBCTextField: UITextField {
    public init() {
        super.init(frame: .zero)
        configure()
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    func configure() {
        self.borderStyle = .none
        self.addLineAtBottom()
        self.font = UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight.medium)
        self.textColor = UIColor.black
        self.clipsToBounds = true
        self.layer.cornerRadius = 4.0
    }
}

