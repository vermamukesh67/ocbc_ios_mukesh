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
        self.lblTopHeader.textColor = UIColor.black
        self.lblBalance.textColor = UIColor.black
        self.lblBottomHeader.textColor = UIColor.black
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        self.clipsToBounds = true
        self.layer.cornerRadius = 4.0
    }
    /// Sets the balance.
    public var balance: String? {
        didSet {
            self.lblBalance.text = balance
        }
    }
}
