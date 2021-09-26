//
//  Date+Extension.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 26/9/21.
//

import Foundation
public extension Date {
    /// Format the date object and return the string
    ///
    /// - Parameter dateFormat: A String value represent the date format
    /// - Returns: formatted string
    func format(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}
