//
//  OCBCTextField.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 25/9/21.
//

import UIKit

class OCBCTextField: UITextField {
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
    private func configure() {
        self.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.medium)
        self.textColor = UIColor.black
    }
}
