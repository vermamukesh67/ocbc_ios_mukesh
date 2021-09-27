//
//  OCBCDatePickerTextField.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 27/9/21.
//

import Foundation
import UIKit
/// OCBC Date picker textfield.
public class OCBCDatePickerTextField: OCBCTextField {
    //Uidate picker
    let datePicker = UIDatePicker()
    override func configure() {
        super.configure()
        self.configureDatePicker()
    }
    /// Current selected date.
    public var selectedDate: Date?
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
        formatter.dateFormat = Common.displayDateFormat
        selectedDate = datePicker.date
        self.text = formatter.string(from: datePicker.date)
        //dismiss date picker dialog
        self.endEditing(true)
    }
}
