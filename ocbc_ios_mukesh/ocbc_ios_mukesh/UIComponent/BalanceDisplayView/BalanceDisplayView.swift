//
//  BalanceDisplayVIew.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 25/9/21.
//

import UIKit

/// Display the balance view.
public class BalanceDisplayView: UIView {
    @IBOutlet private(set) weak var lblTopHeader: UILabel!
    @IBOutlet private(set) weak var lblBalance: UILabel!
    @IBOutlet private(set) weak var lblBottomHeader: UILabel!
    /// :nodoc:
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    /// :nodoc:
    public init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    /// :nodoc:
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    /// Initilize the view from the nib
    fileprivate func commonInit() {
        _ = fromNib(nibName: "BalanceDisplayView")
        setupUI()
    }
    private func setupUI() {
        self.lblTopHeader.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.regular)
        self.lblBalance.font = UIFont.systemFont(ofSize: 24.0, weight: UIFont.Weight.semibold)
        self.lblBottomHeader.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.regular)
        self.lblTopHeader.textColor = UIColor.white
        self.lblBalance.textColor = UIColor.white
        self.lblBottomHeader.textColor = UIColor.white
        self.backgroundColor = UIColor.red
        self.clipsToBounds = true
        self.layer.cornerRadius = 4.0
    }
    /// Sets the balance text.
    public var balance: String? {
        didSet {
            self.lblBalance.text = balance
        }
    }
    /// Sets the top label text.
    public var topText: String? {
        didSet {
            self.lblTopHeader.text = topText
        }
    }
    /// Sets the bottom label text.
    public var bottomText: String? {
        didSet {
            self.lblBottomHeader.text = bottomText
        }
    }
}
