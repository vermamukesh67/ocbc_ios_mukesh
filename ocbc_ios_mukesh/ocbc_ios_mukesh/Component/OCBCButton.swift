//
//  OCBCButton.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 25/9/21.
//

import UIKit

/// OCBC button.
public class OCBCButton: UIButton {
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
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.medium)
        self.layer.cornerRadius = 4.0
        self.clipsToBounds = true
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .disabled)
        self.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: .highlighted)
        self.backgroundColor = UIColor.red
    }
    public override var isEnabled: Bool {
        didSet {
            self.backgroundColor = (self.isEnabled) ? UIColor.red : UIColor.red.withAlphaComponent(0.5)
        }
    }
}
