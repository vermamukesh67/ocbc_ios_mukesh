//
//  OCBCTextField.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 25/9/21.
//

import UIKit

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
        self.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.medium)
        self.textColor = UIColor.black
    }
}

/// Date picker textfield.
public class OCBCDatePickerTextField: OCBCTextField {
    //Uidate picker
    let datePicker = UIDatePicker()
    override func configure() {
        super.configure()
        self.configureDatePicker()
    }
    func configureDatePicker(){
        self.tintColor = UIColor.clear
        let image = UIImage(named: "calendar_icon")
        let imgIcon = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        imgIcon.image = image
        imgIcon.contentMode = .scaleAspectFit
        self.rightView = imgIcon
        self.rightViewMode = .always
        self.rightView?.widthAnchor.constraint(lessThanOrEqualToConstant: 30).isActive = true
        self.rightView?.heightAnchor.constraint(lessThanOrEqualToConstant: 30).isActive = true
        //Formate Date
        datePicker.datePickerMode = .dateAndTime
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(btnDoneButtonClicked))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton,doneButton], animated: false)
        
        // add toolbar to textField
        self.inputAccessoryView = toolbar
        // add datepicker to textField
        self.inputView = datePicker
        
    }
    @objc func btnDoneButtonClicked(){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = Common.dateFormat
        self.text = formatter.string(from: datePicker.date)
        //dismiss date picker dialog
        self.endEditing(true)
    }
}
/// Picker textfield.
public class OCBCPickerTextField: OCBCTextField {
    //Uidate picker
    private var pickerView: UIPickerView = UIPickerView()
    override func configure() {
        super.configure()
        self.configurePicker()
        self.commonInit()
    }
    func configurePicker(){
        self.tintColor = UIColor.clear
        let image = UIImage(named: "dropdown_icon")
        let imgIcon = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        imgIcon.image = image
        imgIcon.contentMode = .scaleAspectFit
        self.rightView = imgIcon
        self.rightViewMode = .always
        self.rightView?.widthAnchor.constraint(lessThanOrEqualToConstant: 30).isActive = true
        self.rightView?.heightAnchor.constraint(lessThanOrEqualToConstant: 30).isActive = true
        
        /// set up picker
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.isUserInteractionEnabled = false
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(btnDoneButtonClicked))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton,doneButton], animated: false)
        
        // add toolbar to textField
        self.inputAccessoryView = toolbar
        // add datepicker to textField
        self.inputView = pickerView
        
    }
    @objc func btnDoneButtonClicked(){
        let value = pickerView.selectedRow(inComponent: 0)
        if  pickerItems.count > value {
            self.text = pickerItems[value]
        }
        self.endEditing(true)
    }
    /// Sets picker items.
    public var pickerItems = [String]() {
        didSet {
            pickerView.isUserInteractionEnabled = (pickerItems.count != 0)
        }
    }
}
extension OCBCPickerTextField {
    func commonInit() {
        self.addTarget(self, action: #selector(didBegin), for: .editingDidBegin)
        self.addTarget(self, action: #selector(didEnd), for: .editingDidEnd)
    }
    @objc func didBegin() {
        self.animateDropDown(isUp: true)
    }
    @objc func didEnd() {
        self.animateDropDown(isUp: false)
    }
    func animateDropDown(isUp: Bool) {
        if isUp {
            let transform = CGAffineTransform.identity
            UIView.animate(withDuration: 0.3, animations: {
                // to rotate counterclockwise set both of these in this exact order
                self.rightView?.transform = transform.rotated(by: 180 * CGFloat(Double.pi))
                self.rightView?.transform = transform.rotated(by: -1 * CGFloat(Double.pi))
            })
        } else {
            let transform = CGAffineTransform.identity
            UIView.animate(withDuration: 0.3, animations: {
                // to rotate clockwise set both of these in this exact order
                self.rightView?.transform = transform
            })
        }
    }
}
extension OCBCPickerTextField: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerItems.count
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(pickerItems[row])"
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let value = pickerView.selectedRow(inComponent: 0)
         if  pickerItems.count > value {
             self.text = pickerItems[value]
        }
    }
}

