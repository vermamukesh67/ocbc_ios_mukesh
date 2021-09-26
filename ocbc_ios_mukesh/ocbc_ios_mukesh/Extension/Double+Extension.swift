//
//  Double+Extension.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 26/9/21.
//

import Foundation
extension Double {
    /// Format the double value into currency format for given locale
    /// - Parameters:
    ///   - prefix: A String value to display the prefix before currency
    ///   - locale: A Locale object for formatting the string data
    func formatIntoCurrency(prefix: String, locale: Locale) -> String? {
        let currencyFormattor = Common.getCurrencyFormatter(locale: locale)
        var strAmount: String?
        if let value = currencyFormattor.string(from: NSNumber.init(value: self)) {
            // The currency converter is adding extra space with the iOS 12.2
            // So need to remove any extra spaces added by the formatter
            if !prefix.isEmpty {
               strAmount =  prefix + " " + value.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            }
        }
        return strAmount
    }
    func formatIntoCurrency(allowDecimal: Bool = true, locale: Locale = .current) -> String {
        let formatter = Common.getCurrencyFormatter(allowDecimal: allowDecimal, locale: locale)
        var textFieldStringValue = formatter.string(from: (allowDecimal) ? NSNumber(value: self) : NSNumber(value: Int(self)))
        // The currency converter is adding extra space with the iOS 12.2
        // So need to remove any extra spaces added by the formatter
        textFieldStringValue = textFieldStringValue?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        return textFieldStringValue ?? ""
    }
}
