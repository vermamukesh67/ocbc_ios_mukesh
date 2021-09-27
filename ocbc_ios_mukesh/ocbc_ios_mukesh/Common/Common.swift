//
//  Common.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 26/9/21.
//

import Foundation
class Common {
    static var dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    static var displayDateFormat = "dd MMM yyyy HH:mm"
    /// Returns the currency formatter object for given locale
    /// - Parameter locale: A Locale object
   static func getCurrencyFormatter(allowDecimal: Bool = true, locale: Locale) -> NumberFormatter {
        let currencyFormattor = NumberFormatter()
        currencyFormattor.numberStyle = .currency
        currencyFormattor.locale = locale
        currencyFormattor.currencySymbol = ""
        currencyFormattor.minimumFractionDigits = allowDecimal ? 2 : 0
        currencyFormattor.maximumFractionDigits = allowDecimal ? 2 : 0
        return currencyFormattor
    }
}
