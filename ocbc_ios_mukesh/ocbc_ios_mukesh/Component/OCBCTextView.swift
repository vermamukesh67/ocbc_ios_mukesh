//
//  OCBCTextView.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 25/9/21.
//

import UIKit

public class OCBCTextView: UITextView {
    public init() {
        super.init(frame: .zero, textContainer: nil)
        configure()
    }
    public init(frame: CGRect) {
        super.init(frame: frame, textContainer: nil)
        configure()
    }
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    private func configure() {
        self.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.medium)
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        self.layer.borderWidth = 1.0
        self.clipsToBounds = true
        self.layer.cornerRadius = 4.0
        self.contentInset = UIEdgeInsets.init(top: 0, left: 4, bottom: 0, right: 0)
    }
}
