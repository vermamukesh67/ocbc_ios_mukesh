//
//  String+Extension.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 26/9/21.
//

import Foundation
extension String {
    /// Format the string value into currency format for given locale
    /// - Parameters:
    ///   - prefix: A String value to display the prefix before currency
    ///   - locale: A Locale object for formatting the string data
    func formatIntoCurrency(prefix: String, locale: Locale) -> String {
        if self.isEmpty {
           return self
        } else {
            let currencyFormattor = Common.getCurrencyFormatter(locale: locale)
            var strAmount = self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            if let value = currencyFormattor.number(from: self), let strValue = currencyFormattor.string(from: value) {
                strAmount = strValue
                return ((prefix.isEmpty) ? "" : prefix + " ") + strAmount
            }
            // The currency converter is adding extra space with the iOS 12.2
            // So need to remove any extra spaces added by the formatter
            return self
        }
    }
    /// Format the string and return the date
    ///
    /// - Parameter dateFormat: A String value represent the date format
    /// - Returns: formatted string
    func format(dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self)
    }
}
