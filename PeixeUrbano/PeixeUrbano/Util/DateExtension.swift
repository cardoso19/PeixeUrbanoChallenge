//
//  DateExtension.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 20/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

extension Date {
    
    /// Convert a date to a string in the requested format.
    ///
    /// - Parameter format: the date format.
    /// - Returns: A string of the date in the requested format.
    func convertToString(onFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
