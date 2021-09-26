//
//  TransactionActivityView.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 25/9/21.
//

import UIKit

/// Transaction activity view.
public class TransactionActivityView: UIView {
    @IBOutlet private(set) weak var lblAmount: UILabel!
    @IBOutlet private(set) weak var lblDate: UILabel!
    @IBOutlet private(set) weak var lblTitle: UILabel!
    private let creditAmountColor =  UIColor(red: 11.0/255.0, green: 162.0/255.0, blue: 26.0/255.0, alpha: 1.0)
    private var deductionAmountColor = UIColor.red
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
        _ = fromNib(nibName: "TransactionActivityView")
        setupUI()
    }
    private func setupUI() {
        self.lblDate.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.semibold)
        self.lblTitle.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.regular)
        self.lblAmount.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.semibold)
        self.lblDate.textColor = UIColor.black
        self.lblTitle.textColor = UIColor.black
        self.lblAmount.textColor = UIColor.black
        self.backgroundColor = UIColor.clear
    }
    /// Sets the date.
    public var date: String? {
        didSet {
            self.lblDate.text = date
        }
    }
    /// Sets the amount.
    public var title: String? {
        didSet {
            self.lblTitle.text = title
        }
    }
    /// Sets the amount.
    public func setAmount(amount: String, isCredited: Bool = true) {
        self.amount = amount
        self.lblAmount.textColor = (isCredited) ? creditAmountColor : deductionAmountColor
    }
    /// Return the amount.
    public private(set) var amount: String? {
        didSet {
            self.lblAmount.text = amount
        }
    }
}
